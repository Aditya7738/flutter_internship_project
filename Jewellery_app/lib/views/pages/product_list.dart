import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/product_grid_list_item.dart';

class ProductList extends StatefulWidget {
  final int? id;
  const ProductList({super.key, required this.id});

  @override
  State<ProductList> createState() => _ProductListState();
}




class _ProductListState extends State<ProductList> {


  @override
  void initState() {
    
    super.initState();
    getProducts();
  }
  void getProducts(){

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
          itemCount: listOfCategoryModel.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.1,
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 14.0),
          itemBuilder: (BuildContext context, int index) {
            return ProductGridListItem(
              categoryImageModel: listOfCategoryModel[index],
            );
          }),
    );
  }
}
