import 'dart:convert';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteReviewPage extends StatefulWidget {
  final ProductsModel productsModel;

  const WriteReviewPage({super.key, required this.productsModel});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  bool isCreatingReview = false;
  TextEditingController _reviewController = TextEditingController();

  double selectedRate = 0.0;

  String review = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Feedback & Review"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(children: [
                    Text(
                      widget.productsModel.name ?? "Jewellery",
                      textAlign: TextAlign.center,
                      style: Fontsizes.headlineTextStyle,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadiusDirectional.circular(20.0),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Theme.of(context).primaryColor)),
                      child: CachedNetworkImage(
                        imageUrl:
                            //
                            // Constants.defaultImageUrl
                            //:
                            widget.productsModel.images.isNotEmpty
                                ? widget.productsModel.images[0].src ??
                                    Constants.defaultImageUrl
                                : Constants.defaultImageUrl,
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        placeholder: (context, url) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RatingBar.builder(
                      //  tapOnlyMode: true,
                      unratedColor: Color.fromARGB(255, 220, 220, 220),
                      // glowColor: Theme.of(context).primaryColor,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
                      updateOnDrag: true,
                      onRatingUpdate: (value) {
                        if (mounted) {
                          setState(() {
                            print("selectedRate $selectedRate");
                            selectedRate = value;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ]),
                ),
                Text(
                  "Write Review",
                  style: Fontsizes.headlineTextStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _reviewController,

                  maxLines: 5,
                  validator: (value) {
                    return ValidationHelper.nullOrEmptyString(value);
                  },
                  // keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    hintText:
                        "You can talk about the fit, design, size, packaging, etc..",
                    hintStyle: TextStyle(fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            if (mounted) {
              setState(() {
                review = _reviewController.text;
              });
            }

            if (selectedRate == 0.0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  padding: EdgeInsets.all(15.0),
                  backgroundColor: Theme.of(context).primaryColor,
                  content: Text("Please select rating")));
            }

            Map<String, dynamic> data = {
              "product_id": widget.productsModel.id,
              "review": review,
              "reviewer":
                  "${customerProvider.customerData[0]["first_name"]}  ${customerProvider.customerData[0]["last_name"]}",
              "reviewer_email": "${customerProvider.customerData[0]["email"]}",
              "rating": selectedRate
            };
            bool isThereInternet =
                await ApiService.checkInternetConnection(context);
            if (isThereInternet) {
              if (mounted) {
                setState(() {
                  isCreatingReview = true;
                });
              }
              final response = await ApiService.createProductReview(data);
              if (mounted) {
                setState(() {
                  isCreatingReview = false;
                });
              }

              print("REVIEW response.statusCode ${response.statusCode}");

              if (response.statusCode == 201) {
                print(jsonDecode(response.body));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    padding: EdgeInsets.all(15.0),
                    backgroundColor: Colors.green,
                    content: Text(
                      "Thanks for your review",
                      style: TextStyle(fontSize: 17.0),
                    )));
                Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    padding: EdgeInsets.all(15.0),
                    backgroundColor: Colors.red,
                    content: Text(
                      "Don't able to send review",
                      style: TextStyle(fontSize: 17.0),
                    )));
              }
            }
          }
        },
        child: Container(
          height: deviceWidth > 600 ? 60.0 : 50.0,
          width: MediaQuery.of(context).size.width - 30,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).primaryColor),
          child: Center(
            child: isCreatingReview
                ? SizedBox(
                    width: 18.sp,
                    height: 18.sp,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                      backgroundColor: Color(0xffCC868A),
                    ),
                  )
                : Text("Submit Review", style: Fontsizes.buttonTextStyle),
          ),
        ),
      ),
    );
  }
}
