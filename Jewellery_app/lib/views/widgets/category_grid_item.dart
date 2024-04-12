import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  final CategoryImageModel categoryImageModel;

  const CategoryGridItem({super.key, required this.categoryImageModel});

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0.0, 1.0),
                blurRadius: 1.0,
                spreadRadius: 2.0)
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(
                categoryImageModel.src ?? layoutDesignProvider.placeHolder,
                width: 40.0,
                height: 40.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Text(
              categoryImageModel.name ?? "Jewellery",
              style: const TextStyle(fontSize: 15.0),
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )),
        ],
      ),

      //   return Card(
      // elevation: 8.0,
      // child: ListTile(
      //   leading: Card(
      //   elevation: 0.0,
      //   color: Colors.greenAccent,
      // child: Image.asset(categoryModel.imagePath, width: 40.0, height: 40.0,),
      // ),
      // title: Text(categoryModel.title),
      // trailing: Icon(Icons.chevron_right),
      // ),
    );
  }
}
