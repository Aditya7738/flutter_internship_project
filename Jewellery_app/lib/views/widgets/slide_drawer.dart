import 'package:flutter/material.dart';

import 'package:jwelery_app/model/category_model.dart';
import 'package:jwelery_app/views/widgets/category_grid_item.dart';


class SlideDrawer extends StatelessWidget {
   const SlideDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    //print(MediaQuery.of(context).size.width);
    List<CategoryImageModel> listOfCategoryModel = <CategoryImageModel>[];
    // listOfCategoryModel
    //     .add( CategoryImageModel("Rings", "assets/images/wedding_ring.png"));
    // listOfCategoryModel
    //     .add( CategoryImageModel("Earrings", "assets/images/wedding_ring.png"));
    // listOfCategoryModel.add( CategoryImageModel(
    //     "Braceles & Bangles", "assets/images/wedding_ring.png"));
    // listOfCategoryModel
    //     .add( CategoryImageModel("Necklaces", "assets/images/wedding_ring.png"));
    // listOfCategoryModel
    //     .add( CategoryImageModel("Earrongs", "assets/images/wedding_ring.png"));
    // listOfCategoryModel
    //     .add( CategoryImageModel("Solitaires", "assets/images/wedding_ring.png"));
    // listOfCategoryModel
    //     .add( CategoryImageModel("Magalsutra", "assets/images/wedding_ring.png"));

    return Padding(
              padding:  const EdgeInsets.all(18.0),
              child: GridView.builder(
                  itemCount: listOfCategoryModel.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3.1,
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 14.0),
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryGridItem(
                        categoryImageModel: listOfCategoryModel[index],);
                  }),

    );
  }
}
