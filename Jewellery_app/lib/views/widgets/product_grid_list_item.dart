import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/model/products_of_category.dart';
import 'package:provider/provider.dart';

class ProductGridListItem extends StatefulWidget {
  final ProductOfCategoryModel productOfCategoryModel;
  const ProductGridListItem({super.key, required this.productOfCategoryModel});

  @override
  State<ProductGridListItem> createState() => _ProductGridListItemState();
}

class _ProductGridListItemState extends State<ProductGridListItem> {
  late final ProductOfCategoryModel productOfCategoryModel;

  final defaultImageUrl =
      "https://cdn.shopify.com/s/files/1/0985/9548/products/Orissa_jewellery_Silver_Filigree_OD012h_1_1000x1000.JPG?v=1550653176";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productOfCategoryModel = widget.productOfCategoryModel;
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.favorite_border_outlined;
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context);
    return Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(productOfCategoryModel.images.isEmpty
                    ? layoutDesignProvider.placeHolder
                    : productOfCategoryModel.images[0].src ?? layoutDesignProvider.placeHolder),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(right: 5.0, top: 5.0),
                  width: 7.0,
                  height: 7.0,
                  child: GestureDetector(
                    child: Icon(
                      icon,
                      color: const Color(0xFFCC868A),
                      size: 5.0,
                    ),
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          icon = Icons.favorite;
                        });
                      }
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    width: 20.0,
                    height: 5.0,
                    margin: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(productOfCategoryModel.averageRating ?? "3.5"),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ))
              ],
            ),
            Text(productOfCategoryModel.name ?? "Jewellery"),
            Row(children: [
              Text(
                productOfCategoryModel.regularPrice != ""
                    ? productOfCategoryModel.regularPrice ?? "20000"
                    : "20000",
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(productOfCategoryModel.salePrice ?? "8,000"),
            ])
          ],
        ));
  }
}
