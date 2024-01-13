import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/date_helper.dart';
import 'package:jwelery_app/model/choice_model.dart';
import 'package:jwelery_app/model/products_of_category.dart';
import 'package:jwelery_app/views/widgets/app_bar.dart';
import 'package:jwelery_app/views/widgets/bottom_app_bar_cart.dart';
import 'package:jwelery_app/views/widgets/cart_app_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jwelery_app/views/widgets/choice_widget.dart';

class CartPage extends StatefulWidget {
  int? productId;

  CartPage({super.key});

  // CartPage.empty() : productId = 0;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //List<int> productIds = <int>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (widget.productId != null) {
    //   CartOperation.addProductToCart(widget.productId!);
    // }
  }

  @override
  Widget build(BuildContext context) {
    List<ChoiceModel> listOfChoiceModel = <ChoiceModel>[];

    //print("IDS LENGTH: ${productIds.length}");
    listOfChoiceModel.add(ChoiceModel(
      label: "Qty",
      options: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
      selectedOption: "1",
    ));
    listOfChoiceModel.add(ChoiceModel(
      label: "Size",
      options: [
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25"
      ],
      selectedOption: "12",
    ));

    return Scaffold(
      appBar: CartAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height:
                    MediaQuery.of(context).size.height - (kToolbarHeight * 3),
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Row(
                              children: [
                          Image.network(
                            //CartOperation.listOfProductsAddedToCart[index].images[0].src ??
                            Strings.defaultImageUrl,
                            width: MediaQuery.of(context).size.width / 3,
                            height: 170,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 200,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HtmlWidget(
                                  //productOfCategoryModel.priceHtml ??
                                  "<b>Rs 45,000</b>",
                                  textStyle: TextStyle(fontSize: 18.0),
                                ),

                                Text(
                                  //productOfCategoryModel.name ??
                                  "Jewellery",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                //Text("SKU: ${productOfCategoryModel.sku!}"),
                                Container(
                                  width: 200.0,
                                  height: 60.0,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listOfChoiceModel.length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: ChoiceWidget(
                                            choiceModel:
                                                listOfChoiceModel[index],
                                            fromCart: true,
                                          ),
                                        );
                                      })),
                                ),
                                const Text(
                                  "Expected Delivery : ",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                Text(
                                  DateHelper.getCurrentDateInWords(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                )
                              ],
                            ),
                          )
                        ]));
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
