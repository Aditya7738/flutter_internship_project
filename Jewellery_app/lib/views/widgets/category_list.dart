import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/feature_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  Stream<FileResponse>? categoryFileStream;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CacheProvider cacheProvider =
        Provider.of<CacheProvider>(context, listen: false);
    print("categoryFileStream == null ${categoryFileStream == null}");
    if (categoryFileStream == null) {
      _downloadFile(cacheProvider);
    }
  }

  void getFile(AsyncSnapshot<Object?> snapshot,
      CategoryProvider categoryProvider) async {
    if (categoryProvider.fileInfoFetching != null) {
      categoryProvider.setFileInfoFetching(true);
      //  CacheMemory.listOfCategory.clear();
      await CacheMemory.getCategoryFile(snapshot);
      categoryProvider.setFileInfoFetching(null);
    }
  }

  void _downloadFile(CacheProvider cacheProvider) {
    if (mounted) {
      setState(() {
        categoryFileStream = DefaultCacheManager()
            .getFileStream(ApiService.categoryUri, withProgress: true);
      });
      print("categoryFileStream == null ${categoryFileStream == null}");
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    return categoryFileStream != null
        ? StreamBuilder(
            stream: categoryFileStream!,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                getFile(snapshot, categoryProvider);
              }

              Widget body;
              print("!snapshot.hasData ${!snapshot.hasData}");
              print(
                  "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
              final loading =
                  !snapshot.hasData || snapshot.data is DownloadProgress;
              // DownloadProgress? progress =
              //     snapshot.data as DownloadProgress?;
              print("loading $loading");
              if (snapshot.hasError) {
                body = SizedBox();
                print("snapshot error ${snapshot.error.toString()}");
              }
              //   uncomment below code
              else if ( //loading
                  snapshot.connectionState == ConnectionState.waiting) {
                body = SizedBox(
                    width: deviceWidth,
                    height: MediaQuery.of(context).size.height / 6,
                    child: Center(
                      child: CircularProgressIndicator(
                        color:
                            // Colors.red,
                            Theme.of(context).primaryColor,
                      ),
                    ));
                print("snapshot.loading");
                //  p_i.ProgressIndicator(
                //   progress: snapshot.data as DownloadProgress?,
                // );
              } else {
                // print("categoryFileStream.length ${}");

                if (categoryProvider.fileInfoFetching != null) {
                  print(
                      "categoryProvider.fileInfoFetching ${categoryProvider.fileInfoFetching!}");
                  if (categoryProvider.fileInfoFetching!) {
                    body = SizedBox(
                        width: deviceWidth,
                        height: MediaQuery.of(context).size.height / 6,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            //Colors.yellow,
                          ),
                        ));
                  } else {
                    //  body = SizedBox();
                    body = SizedBox(
                        width: deviceWidth,
                        height: MediaQuery.of(context).size.height / 6,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            //Colors.yellow,
                          ),
                        ));
                  }
                } else {
                  body = SizedBox(
                    width: deviceWidth,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Scrollbar(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: CacheMemory.listOfCategory.length,
                          //+    (isNewCategoryLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            print(
                                "CacheMemory.listOfCategory.length ${CacheMemory.listOfCategory.length}");
                            if (index < CacheMemory.listOfCategory.length) {
                              return FeatureWidget(
                                categoriesModel:
                                    CacheMemory.listOfCategory[index],
                                isLoading: isLoading,
                              );
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ));
                            }
                          }),
                    ),
                  );
                }
                print("snapshot.data ${snapshot.data}");
              }
              return body;
              // return Container(
              //   margin: const EdgeInsets.symmetric(
              //       horizontal: 10.0, vertical: 10.0),
              //   height: MediaQuery.of(context).size.height / 6,
              //   child: Scrollbar(
              //     child: ListView.builder(
              //         controller: _scrollController,
              //         scrollDirection: Axis.horizontal,
              //         itemCount: ApiService.listOfCategory.length +
              //             (isNewCategoryLoading ? 1 : 0),
              //         itemBuilder: (context, index) {
              //           if (index < ApiService.listOfCategory.length) {
              //             return FeatureWidget(
              //               categoriesModel:
              //                   ApiService.listOfCategory[index],
              //               isLoading: isLoading,
              //             );
              //           } else {
              //             return const Center(
              //                 child: CircularProgressIndicator(
              //               color: Color(0xffCC868A),
              //             ));
              //           }
              //         }),
              //   ),
              // );
            },
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}
