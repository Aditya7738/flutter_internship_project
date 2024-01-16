import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';

import 'package:jwelery_app/model/category_model.dart';
import 'package:jwelery_app/model/products_model.dart';
import 'package:jwelery_app/views/pages/product_page.dart';

class FeatureWidget extends StatefulWidget {
  final bool isLoading;
   final CategoriesModel categoriesModel;
 

  const FeatureWidget(
      {super.key,
       required this.categoriesModel, 
 
       required this.isLoading});

  @override
  State<FeatureWidget> createState() => _FeatureWidgetState();
}

class _FeatureWidgetState extends State<FeatureWidget> {
  bool localLoading = true;
    late CategoriesModel categoriesModel;

    final defaultImageUrl =
      "https://cdn.shopify.com/s/files/1/0985/9548/products/Orissa_jewellery_Silver_Filigree_OD012h_1_1000x1000.JPG?v=1550653176";

  @override
  void initState() {
    super.initState();
    localLoading = widget.isLoading;
     categoriesModel = widget.categoriesModel;
   
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(id: 
        categoriesModel.id

        )));
      },
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      categoriesModel.image?.src ?? defaultImageUrl,
                  
                      loadingBuilder: (context, child, loadingProgress) {
                        if(loadingProgress == null){
                          return child;
                        }
                        return Container(
                          alignment: Alignment.center,
                         width: 95.0,
                      height: 92.0,
                          child: const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      },
                      fit: BoxFit.fill,
                      
                      width: 95.0,
                      height: 92.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    categoriesModel.name ?? "Jewellery",
           
                    style: const TextStyle(fontSize: 10.0),
                  ),
                ),
              ],
            ),
    ));
  }
}
