import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/model/products_of_category.dart';

class ProductList extends StatefulWidget {
  final int? id;
  const ProductList({super.key, required this.id});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductOfCategoryModel> listOfProductsCategoryWise = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    final response = await ApiService.fetchProductsCategoryWise(id: widget.id);

    setState(() {
      isLoading = false;
      listOfProductsCategoryWise = response;
    });
    }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  //  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: isLoading
  //         ? const CircularProgressIndicator(
  //             color: Colors.black,
  //           )
  //         : GridView.builder(
  //             itemCount: listOfProductsCategoryWise.length,
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 childAspectRatio: 3.1,
  //                 crossAxisCount:
  //                     MediaQuery.of(context).size.width > 600 ? 4 : 2,
  //                 crossAxisSpacing: 16.0,
  //                 mainAxisSpacing: 14.0),
  //             itemBuilder: (BuildContext context, int index) {
  //               return ProductGridListItem(
  //                 productOfCategoryModel: listOfProductsCategoryWise[index],
  //               );
  //             }),
  //   );
  // }
}