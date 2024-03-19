import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/collections_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart' as AllProducts;
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CollectionGridList extends StatefulWidget {
  final int collectionId;
  const CollectionGridList({super.key, required this.collectionId});

  @override
  State<CollectionGridList> createState() => _CollectionGridListState();
}

class _CollectionGridListState extends State<CollectionGridList> {
  bool isCollectionLoading = false;

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCollections();
  }

  getCollections() async {
    setState(() {
      isCollectionLoading = true;
    });
    ApiService.collectionList.clear();
    await ApiService.getCollections(collectionId: widget.collectionId, pageNo: 1);

    setState(() {
      isCollectionLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return isCollectionLoading
        ? SizedBox(
            width: deviceWidth,
            height: (MediaQuery.of(context).size.height / 2) + 220,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          )
        : Container(
            width: deviceWidth,
            height: (MediaQuery.of(context).size.height / 2) + 220,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.64,
                  crossAxisCount: deviceWidth > 600 ? 3 : 2),
              itemBuilder: (context, index) {
                AllProducts.ProductsModel collectionsModel =
                    ApiService.collectionList[index];
                print(
                    "index < ApiService.collectionList.length ${index < ApiService.collectionList.length}");
                if (index < ApiService.collectionList.length) {
                  print(" productIndex: $index");
                  return ProductItem(
                    productIndex: index,
                    productsModel: collectionsModel, fromFetchHome: true,
                  );
                } else {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color(0xffCC868A),
                    )),
                  );
                }
              },
            ),
          );
  }
}
