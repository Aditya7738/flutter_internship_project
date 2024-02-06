import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/model/reviews_model.dart';
import 'package:Tiara_by_TJ/views/pages/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ReviewsPage extends StatefulWidget {
  final ProductsModel productsModel;
  ReviewsPage({super.key, required this.productsModel});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All reviews"),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WriteReviewPage(productsModel: widget.productsModel))),
            child: Text(
              "Write Review",
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            
          ),
          SizedBox(width: 10.0,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Scrollbar(
          child: ListView.separated(
              itemCount:ApiService.reviewsList.length,
                  
              itemBuilder: (context, index) {
                ReviewsModel reviewsModel = ApiService.reviewsList[index];
        
                return Column(
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
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
                                );
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                    HtmlWidget(reviewsModel.review ?? "<p>Review</p>"),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1.0, color: Colors.grey)),
        ),
      ),
    );
  }
}
