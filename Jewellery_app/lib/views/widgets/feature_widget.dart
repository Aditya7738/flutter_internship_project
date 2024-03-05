import 'dart:io';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/views/pages/product_page.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FeatureWidget extends StatefulWidget {
  final bool isLoading;
  final CategoriesModel categoriesModel;

  const FeatureWidget(
      {super.key, required this.categoriesModel, required this.isLoading});

  @override
  State<FeatureWidget> createState() => _FeatureWidgetState();
}

class _FeatureWidgetState extends State<FeatureWidget> {
  bool localLoading = true;
  late CategoriesModel categoriesModel;

  final defaultImageUrl =
      "https://cdn.shopify.com/s/files/1/0985/9548/products/Orissa_jewellery_Silver_Filigree_OD012h_1_1000x1000.JPG?v=1550653176";
  Stream<FileResponse>? categoryImageFileStream;

  @override
  void initState() {
    super.initState();
    localLoading = widget.isLoading;
    categoriesModel = widget.categoriesModel;
    _downloadFile(categoriesModel.image?.src ?? defaultImageUrl);

    print("categoryImageFileStream == null ${categoryImageFileStream == null}");
    if (categoryImageFileStream == null) {
      //getRequest();
      _downloadFile(categoriesModel.image?.src ?? defaultImageUrl);
    }
  }

  void _downloadFile(String imageUrl) {
    // if (mounted) {
    setState(() {
      categoryImageFileStream = DefaultCacheManager().getImageFile(
        imageUrl,
        withProgress: true,
        maxWidth: 90,
        maxHeight: 87,
      );
    });
    //  }
  }

  bool isPathExist = false;

  @override
  Widget build(BuildContext context) {
    print("categoriesModel.id ${categoriesModel.id}");
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    print("categoriesModel.image?.src ${categoriesModel.image?.src}");
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductPage(id: categoriesModel.id)));
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
                    child: StreamBuilder(
                      stream: categoryImageFileStream,
                      builder: (context, snapshot) {
                        String path = "";
                        if (snapshot.hasData) {
                          // getFile(snapshot, categoryProvider);
                          print(
                              "data is FileInfo image ${snapshot.data is FileInfo}");
                          if (snapshot.data is FileInfo) {
                            FileInfo fileInfo =
                                snapshot.requireData as FileInfo;

                            path = fileInfo.file.path;
                          }
                          print("image path $path");
                        }

                        doFileExist(path, categoryProvider);

                        if (categoryProvider.isPathChecking) {
                          return Container(
                            alignment: Alignment.center,
                            width: 90.0,
                            height: 87.0,
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        } else if (categoryProvider.isFilePathExist) {
                          return Image.file(
                            File(path),
                            fit: BoxFit.fill,
                            width: 90.0,
                            height: 87.0,
                          );
                        } else {
                          return Image.asset(
                            "assets/images/image_placeholder.jpg",
                            fit: BoxFit.fill,
                            width: 90.0,
                            height: 87.0,
                          );
                        }
                      },
                    )
                    //  CachedNetworkImage(
                    //   imageUrl: categoriesModel.image?.src ?? defaultImageUrl,
                    //   placeholder: (context, url) {
                    //     return Container(
                    //       alignment: Alignment.center,
                    //       width: 90.0,
                    //       height: 87.0,
                    //       child: const CircularProgressIndicator(
                    //         color: Colors.black,
                    //       ),
                    //     );
                    //   },
                    //   fit: BoxFit.fill,
                    //   width: 90.0,
                    //   height: 87.0,
                    // ),

                    //  Image.network(
                    //   categoriesModel.image?.src ?? defaultImageUrl,
                    //   loadingBuilder: (context, child, loadingProgress) {
                    //     if (loadingProgress == null) {
                    //       return child;
                    //     }
                    //     return Container(
                    //       alignment: Alignment.center,
                    //       width: 90.0,
                    //       height: 87.0,
                    //       child: const CircularProgressIndicator(
                    //         color: Colors.black,
                    //       ),
                    //     );
                    //   },
                    // fit: BoxFit.fill,
                    // width: 90.0,
                    // height: 87.0,
                    ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  categoriesModel.name ?? "Jewellery",
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ],
          ),
        ));
  }

  doFileExist(String path, CategoryProvider categoryProvider) async {
    try {
      File file = File(path);
      categoryProvider.setIsPathChecking(true);
      bool fileExists = await file.exists();
      categoryProvider.setIsPathChecking(false);
      if (fileExists) {
        categoryProvider.setIsFilePathExist(true);
      } else {
        categoryProvider.setIsFilePathExist(false);
      }
    } catch (e) {
      print("doFileExist error ${e.toString()}");
      categoryProvider.setIsFilePathExist(false);
    }
  }

  // void getFile(AsyncSnapshot<Object?> snapshot, categoryProvider) async {
  //   categoryProvider.setImageFileFetching(true);
  //   //  CacheMemory.listOfCategory.clear();
  //   await CacheMemory.getCategoryImage(snapshot);
  //   categoryProvider.setImageFileFetching(false);
  // }
}
