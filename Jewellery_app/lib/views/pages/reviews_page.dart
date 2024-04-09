import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/model/reviews_model.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/pages/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  final ProductsModel productsModel;
  ReviewsPage({super.key, required this.productsModel});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All reviews",
          style: TextStyle(fontSize: deviceWidth > 600 ? 29.sp : 19.sp),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WriteReviewPage(productsModel: widget.productsModel))),
            child: Text(
              "Write Review",
              style: TextStyle(
                  color: Color(int.parse(
                      "0xff${layoutDesignProvider.primary.substring(1)}")),
                  fontSize: deviceWidth > 600 ? 25.0 : 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Scrollbar(
          child: ListView.separated(
              itemCount: ApiService.reviewsList.length,
              itemBuilder: (context, index) {
                ReviewsModel reviewsModel = ApiService.reviewsList[index];

                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey)),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: deviceWidth > 600 ? 45.0 : 27.0,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(reviewsModel.reviewer ?? "Reviewer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: deviceWidth > 600
                                                ? 25.sp
                                                : 14.sp,
                                          )),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        reviewsModel.verified != null
                                            ? reviewsModel.verified! == true
                                                ? "(Verified Purchase)"
                                                : ""
                                            : "",
                                        style: TextStyle(
                                            color: Color(int.parse(
                                                "0xff${layoutDesignProvider.primary.substring(1)}")),
                                            fontWeight: FontWeight.bold,
                                            fontSize: deviceWidth > 600
                                                ? 23.sp
                                                : 13.sp),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < (reviewsModel.rating ?? 0)
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: deviceWidth > 600 ? 33.0 : 22.0,
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            DateHelper.dateFormatForOrder(
                                reviewsModel.dateCreated ?? DateTime.now()),
                            style: TextStyle(
                              fontSize: deviceWidth > 600 ? 25.sp : 14.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      HtmlWidget(
                        reviewsModel.review ??
                            "<p>Reviewwwwwwwwwwwwwwwwwwwwwwwwwwwwwww</p>",
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: deviceWidth > 600 ? 24.sp : 13.sp),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1.0, color: Colors.grey)),
        ),
      ),
    );
  }
}
