import 'dart:io';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
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
    CacheProvider cacheProvider = Provider.of(context, listen: false);
    localLoading = widget.isLoading;
    categoriesModel = widget.categoriesModel;
    _downloadFile(categoriesModel.image?.src ?? defaultImageUrl, cacheProvider);
    // _downloadFile(categoriesModel.image?.src ?? defaultImageUrl);

    // if (categoryImageFileStream == null) {
    //   //getRequest();
    //   _downloadFile(categoriesModel.image?.src ?? defaultImageUrl);
    // }
  }

  void _downloadFile(String imageUrl, CacheProvider cacheProvider) {
    if (categoryImageFileStream == null) {
      if (mounted) {
        setState(() {
          if (imageUrl.contains('http://') || imageUrl.contains('https://')) {
            //    cacheProvider.setCategoryImageFileStream(
            categoryImageFileStream = DefaultCacheManager().getImageFile(
              imageUrl,
              withProgress: true,
              maxWidth: 172,
              maxHeight: 172,
            );
            //);
          } else {
            //  cacheProvider.setCategoryImageFileStream(
            categoryImageFileStream = DefaultCacheManager().getImageFile(
              defaultImageUrl,
              withProgress: true,
              maxWidth: 172,
              maxHeight: 172,
            );
            //);
          }
        });
      }
    }
  }

  bool isPathExist = false;

  // doFileExist(String path
  //     //, CategoryProvider categoryProvider
  //     ) async {
  //   try {
  //     File file = File(path);
  //     //  categoryProvider.setIsPathChecking(true);
  //     setState(() {
  //       isPathChecking = true;
  //     });
  //     bool fileExists = await file.exists();
  //     setState(() {
  //       isPathChecking = false;
  //     });
  //     //   categoryProvider.setIsPathChecking(false);
  //     if (fileExists) {
  //       setState(() {
  //         isPathExist = true;
  //       });
  //       // categoryProvider.setIsFilePathExist(true);
  //     } else {
  //       setState(() {
  //         isPathExist = false;
  //       });
  //       //categoryProvider.setIsFilePathExist(false);
  //     }
  //   } catch (e) {
  //     print("doFileExist error ${e.toString()}");
  //     // categoryProvider.setIsFilePathExist(false);
  //   }
  // }

  Future<bool> checkFileExistence(String path) async {
    try {
      File file = File(path);
      return await file.exists();
    } catch (e) {
      print("doFileExist error ${e.toString()}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //   CacheProvider cacheProvider = Provider.of(context, listen: false);
    print("categoriesModel.id ${categoriesModel.id}");
    // CategoryProvider categoryProvider =
    //     Provider.of<CategoryProvider>(context, listen: false);
    print("categoriesModel.image?.src ${categoriesModel.image?.src}");

    // Call _downloadFile method here
    print("categoryImageFileStream == null ${categoryImageFileStream == null}");
    // if (cacheProvider.categoryImageFileStream == null) {

    // } else {

    if (categoryImageFileStream != null) {
      return GestureDetector(onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  id: categoriesModel.id,
                  forCollections: false,
                )));
      }, child: LayoutBuilder(
        builder: (context, constraints) {
          print("fontsize constraints.maxHeight ${constraints.maxHeight / 12}");
          return Padding(
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

                              return FutureBuilder<bool>(
                                future: checkFileExistence(path),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      alignment: Alignment.center,
                                      width: constraints.maxHeight - 72,
                                      height: constraints.maxHeight - 72,
                                      child: const CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ); // Show a loading indicator
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    if (snapshot.hasData) {
                                      isPathExist = snapshot.data ?? false;
                                      if (isPathExist) {
                                        return Image.file(
                                          File(path),
                                          fit: BoxFit.fill,
                                          width: constraints.maxHeight - 72,
                                          height: constraints.maxHeight - 72,
                                        );
                                      } else {
                                        return Image.asset(
                                          "assets/images/image_placeholder.jpg",
                                          fit: BoxFit.fill,
                                          width: constraints.maxHeight - 72,
                                          height: constraints.maxHeight - 72,
                                        );
                                      }
                                    } else {
                                      return Container(
                                        alignment: Alignment.center,
                                        width: 90.0,
                                        height: 87.0,
                                        child: const CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                width: constraints.maxHeight - 72,
                                height: constraints.maxHeight - 72,
                                child: const CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            }
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              width: constraints.maxHeight - 72,
                              height: constraints.maxHeight - 72,
                              child: const CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }

                          // bool isFileExist = true;
                          // return Consumer<CategoryProvider>(
                          //   builder: (context, value, child) {

                          // if (path != "") {
                          //   print("image path $path");

                          // checkFileExistence(path).then((value) {
                          //   setState(() {
                          //     isPathChecking = false;
                          //   });
                          // });

                          // doFileExist(path
                          //     //, value
                          //     );

                          // if (isPathChecking) {
                          //   return Container(
                          //     alignment: Alignment.center,
                          //     width: 90.0,
                          //     height: 87.0,
                          //     child: const CircularProgressIndicator(
                          //       color: Colors.black,
                          //     ),
                          //   );
                          // } else

                          //   }

                          // return Container(
                          //   alignment: Alignment.center,
                          //   width: 90.0,
                          //   height: 87.0,
                          //   child: const CircularProgressIndicator(
                          //     color: Colors.black,
                          //   ),
                          // );
                          //   },
                          // );
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
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          );
        },
        //child:
      ));
    }
    return Container(
      alignment: Alignment.center,
      width: 172.0,
      height: 172.0,
      child: const CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }
}

// void getFile(AsyncSnapshot<Object?> snapshot, categoryProvider) async {
//   categoryProvider.setImageFileFetching(true);
//   //  CacheMemory.listOfCategory.clear();
//   await CacheMemory.getCategoryImage(snapshot);
//   categoryProvider.setImageFileFetching(false);
// }
//}
