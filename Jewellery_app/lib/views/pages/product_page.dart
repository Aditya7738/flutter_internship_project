import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/model/products_of_category.dart';
import 'package:jwelery_app/views/widgets/app_bar.dart';
import 'package:jwelery_app/views/widgets/product_item.dart';

class ProductPage extends StatefulWidget {
  final int? id;
  const ProductPage({super.key, required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
    return Scaffold(
      appBar: AppBarWidget(
        menuIcon: Icons.menu,
        onPressed: () {
          // if(scaffoldKey.currentState!.isDrawerOpen){
          //   scaffoldKey.currentState!.closeDrawer();
          // }else{
          //   scaffoldKey.currentState!.openDrawer();
          // }
        },
        isNeededForHome: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                  itemCount: listOfProductsCategoryWise.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.74,
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItem(
                      productOfCategoryModel: listOfProductsCategoryWise[index],
                    );
                    // return ProductGridListItem(
                    //   productOfCategoryModel: listOfProductsCategoryWise[index],
                    // );
                  }),
            ),
    );
  }
}
