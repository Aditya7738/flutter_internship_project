import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/model/products_of_category.dart';
import 'package:jwelery_app/views/pages/product_details_page.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProductItem extends StatefulWidget {
  final ProductOfCategoryModel productOfCategoryModel;
  const ProductItem({super.key, required this.productOfCategoryModel});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late final ProductOfCategoryModel productOfCategoryModel;
  bool isFavourite = false;
  List<CategoryWiseProductImage> listOfProductImage = <CategoryWiseProductImage>[];
  

  @override
  void initState() {
 
    super.initState();
    productOfCategoryModel = widget.productOfCategoryModel;
    
  }

  void toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite; // Toggle the state of the heart icon
    });
  }

  

  @override
  Widget build(BuildContext context) {
    print(productOfCategoryModel.toJson());
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(productOfCategoryModel: productOfCategoryModel)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                productOfCategoryModel.images.isEmpty
                    ? Strings.defaultImageUrl
                    : productOfCategoryModel.images[0].src ?? Strings.defaultImageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) + 16.0,
                    height: (MediaQuery.of(context).size.width / 2) + 10.0,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                width: (MediaQuery.of(context).size.width / 2) + 16.0,
                height: (MediaQuery.of(context).size.width / 2) + 10.0,
                fit: BoxFit.fill,
              ),
              Positioned(
                right: 5.0,
                top: 5.0,
                child: IconButton(
                    icon: Icon(
                      isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                      size: 30.0,
                    ),
                    onPressed: () {
                      print("PRESSED");
                      toggleFavourite();
                    }),
              ),
              Positioned(
                  bottom: 10.0,
                  left: 5.0,
                  child: Center(
                      child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 2, // Border width
                      ),
                      borderRadius: BorderRadius.circular(18), // Border radius
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          productOfCategoryModel.averageRating ?? "3.5",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      ],
                    ),
                  )))
            ],
          ),
          Text(productOfCategoryModel.name ?? "Jewellery", style: TextStyle(
                        
                        fontSize: 16.0,
                      ),),
          // Row(children: [
          //   Image.asset(
          //     "assets/images/rupee.png",
          //     width: 20.0,
          //     height: 20.0,
          //   ),
          //   Text(
          //     productOfCategoryModel.regularPrice ?? "15,000",
          //     style: const TextStyle(decoration: TextDecoration.lineThrough),
          //   ),
          //   const SizedBox(
          //     width: 5.0,
          //   ),
          //   Text(productOfCategoryModel.salePrice == "" ? "10,000" : productOfCategoryModel.salePrice ?? "10,000",),
          // ])
          productOfCategoryModel.salePrice == ""
                    ?
                    HtmlWidget(productOfCategoryModel.priceHtml ??
                      "<b>${productOfCategoryModel.regularPrice}</b>",
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                      )
                      :
                Row(
                  children: [
                    Image.asset(
                      "assets/images/rupee.png",
                      width: 20.0,
                      height: 20.0,
                    ),
                    
                      
                    Text(
                      productOfCategoryModel.salePrice == ""
                          ? "10,000"
                          : productOfCategoryModel.salePrice ?? "10,000",
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      productOfCategoryModel.regularPrice ?? "15,000",
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
