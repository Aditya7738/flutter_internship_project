import 'dart:convert';

import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/model/choice_model.dart';
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/choice_widget.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/model/navigation_model.dart';
import 'package:Tiara_by_TJ/views/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:Tiara_by_TJ/views/widgets/button_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/feature_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/pincode_widget.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();

  List<String> images = [
    "https://newspaperads.ads2publish.com/wp-content/uploads/2020/11/fuzion-queentessential-extravagance-finest-diamond-jewelry-ad-toi-ahmedabad-6-11-2020.jpg",
    "https://i.pinimg.com/564x/43/68/b2/4368b2a77dceb87086c8752ce87c7728.jpg",
    "https://www.eventalways.com/media/eventgallery/large/gallery-image-1646823449.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/jewelry-collection-instagram-post-flyer-design-template-5cbe7bd2c299c98f3145f0a61d7b5cae_screen.jpg",
    "https://images.freecreatives.com/wp-content/uploads/2016/03/Luxury-Jewelry-Advertising.jpg"
  ];

  late CarouselController carouselController;

  int currentIndex = 0;

  // List<CategoriesModel> listOfCategories = [];

  bool isLoading = false;

  bool isBannerLoading = false;

  bool isNewCategoryLoading = false;

  Stream<FileResponse>? categoryFileStream;

  void _downloadFile(CacheProvider cacheProvider) {
    if (mounted) {
      setState(() {
        // cacheProvider.setCategoryFileStream(DefaultCacheManager()
        //     .getFileStream(ApiService.categoryUri, withProgress: true));
        categoryFileStream = DefaultCacheManager()
            .getFileStream(ApiService.categoryUri, withProgress: true);
      });
      print("categoryFileStream == null ${categoryFileStream == null}");
    }
  }

  @override
  void initState() {
    super.initState();
    //getDataFromProvider();
    CacheProvider cacheProvider = Provider.of(context, listen: false);
    if (categoryFileStream == null) {
      //getRequest();
      _downloadFile(cacheProvider);
    }

    getBanners();

    carouselController = CarouselController();

    // _scrollController.addListener(() async {
    //   print(
    //       "CONDITION ${_scrollController.position.pixels == _scrollController.position.maxScrollExtent}");
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     loadMoreData();
    //   }
    // });
  }

  void loadMoreData() async {
    if (mounted) {
      setState(() {
        isNewCategoryLoading = true;
      });
    }

    // Fetch more data (e.g., using ApiService)
    await ApiService.showNextPageOfCategories(context);

    if (mounted) {
      setState(() {
        isNewCategoryLoading = false;
      });
    }
  }

  Future<void> getBanners() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isBannerLoading = true;
        });
      }
      await ApiService.getBanners();

      if (mounted) {
        setState(() {
          isBannerLoading = false;
        });
      }
    }
  }

  Future<void> getRequest() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await ApiService.fetchCategories(1, context);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<NavigationModel> listOfNavigationModel = <NavigationModel>[];
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/notification.png",
    //         width: width, height: height, color: Colors.white),
    //     "Notifications"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/gold_bars.png",
    //         width: width, height: height),
    //     "Gold Rate"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset(
    //       "assets/images/gift.png",
    //       width: width,
    //       height: height,
    //     ),
    //     "Promotions"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/branding.jpg",
    //         width: width, height: height, color: Colors.white),
    //     "Brands"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/roadmap.png",
    //         width: width, height: height, color: Colors.white),
    //     "Plans"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset(
    //       "assets/images/info.png",
    //       width: width,
    //       height: height,
    //       color: Colors.white,
    //     ),
    //     "About us"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/account.png", width: width, height: height),
    //     "My Account"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/gears.png", width: width, height: height),
    //     "Settings"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset("assets/images/terms_and_conditions.png",
    //         width: width, height: height, color: Colors.white),
    //     "Terms and Conditions"));
    // listOfNavigationModel.add(NavigationModel(
    //     Image.asset(
    //       "assets/images/login.png",
    //       width: width,
    //       height: height,
    //       color: Colors.white,
    //     ),
    //     "Login"));
    List<String> layoutsOptions = <String>[
      "Home screen 1",
      "Home screen 2",
      "Home screen 3",
    ];
   // CacheProvider cacheProvider = Provider.of(context, listen: false);
    ChoiceModel choiceModel =
        ChoiceModel(options: layoutsOptions, selectedOption: layoutsOptions[0]);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    //   print("categoryFileStream == null ${categoryFileStream == null}");
    // if (categoryFileStream == null) {
    //   //getRequest();
    //   _downloadFile();
    // }
    // print("categoryFileStream == null ${categoryFileStream == null}");

    return Scaffold(
      key: scaffoldKey,
      // drawer: NavDrawer(
      //     backgroundColor: const Color(0xFF9A0056),
      //     fontColor: Colors.white,
      //     fontSize: 15.0,
      //     fontFamily: 'Montserrat',
      //     listOfNavigationModel: listOfNavigationModel,
      //     fontWeight: FontWeight.bold),
      appBar: AppBarWidget(
          //  menuIcon: Icons.menu,
          // onPressed: () {
          //   if (scaffoldKey.currentState!.isDrawerOpen) {
          //     scaffoldKey.currentState!.closeDrawer();
          //   } else {
          //     scaffoldKey.currentState!.openDrawer();
          //   }
          // },
          isNeededForHome: true,
          isNeededForProductPage: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChoiceWidget(choiceModel: choiceModel, fromCart: true),
                SizedBox(
                  width: 10.0,
                )
              ],
            ),

            categoryFileStream != null
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
                      final loading = !snapshot.hasData ||
                          snapshot.data is DownloadProgress;
                      // DownloadProgress? progress =
                      //     snapshot.data as DownloadProgress?;
                      print("loading $loading");
                      if (snapshot.hasError) {
                        body = ListTile(
                          title: const Text('Error'),
                          subtitle: Text(snapshot.error.toString()),
                        );
                        print("snapshot error");
                      }
                      //   uncomment below code
                      else if (loading) {
                        body = SizedBox(
                            width: MediaQuery.of(context).size.width,
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
                        print(
                            "categoryProvider.fileInfoFetching ${categoryProvider.fileInfoFetching}");
                        // print("categoryFileStream.length ${}");

                        categoryProvider.fileInfoFetching
                            ? body = SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 6,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                    // Colors.yellow,
                                  ),
                                ))
                            : body = SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 5,
                                child: Scrollbar(
                                  child: ListView.builder(
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          CacheMemory.listOfCategory.length,
                                      //+    (isNewCategoryLoading ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        print(
                                            "CacheMemory.listOfCategory.length ${CacheMemory.listOfCategory.length}");
                                        if (index <
                                            CacheMemory.listOfCategory.length) {
                                          return FeatureWidget(
                                            categoriesModel: CacheMemory
                                                .listOfCategory[index],
                                            isLoading: isLoading,
                                          );
                                        } else {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                            color: Color(0xffCC868A),
                                          ));
                                        }
                                      }),
                                ),
                              );

                        // body = FileInfoWidget(
                        //   fileInfo: snapshot.requireData as FileInfo,
                        //   clearCache: clearCache,
                        //   removeFile: removeFile,
                        // );
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
                  ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            //   child: PincodeWidget(),
            // ),

            isBannerLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      CarouselSlider(
                        carouselController: carouselController,
                        items: ApiService.listOfBanners
                            .map((banner) => Container(
                                  margin: const EdgeInsets.all(5.0),
                                  child: Image.network(
                                    banner.metadata != null
                                        ? banner.metadata!.bgImageMobile[0]
                                        : "https://rotationalmoulding.com/wp-content/uploads/2017/02/NoImageAvailable.jpg",
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 92.0,
                                        child: const CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    },
                                    fit: BoxFit.fill,
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1.04,
                            height: MediaQuery.of(context).size.height / 2,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: const Duration(seconds: 3),
                            onPageChanged: (index, reason) {
                              if (mounted) {
                                setState(() {
                                  currentIndex = index;
                                });
                              }
                            }),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DotsIndicator(
                            dotsCount: ApiService.listOfBanners.length > 0 ? ApiService.listOfBanners.length : 1,
                            position: currentIndex,
                            onTap: (index) {
                              carouselController.animateToPage(index);
                            },
                            decorator: const DotsDecorator(
                              color: Colors.grey,
                              activeColor: Colors.black,
                              size: Size.square(12.0),
                              activeSize: Size.square(15.0),
                            ),
                          )),
                    ],
                  )

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: Stack(alignment: AlignmentDirectional.center, children: [
            //     Card(
            //       elevation: 0.0,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20.0)),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(20.0),
            //         child: Image.asset(
            //           "assets/images/banner_web.png",
            //           fit: BoxFit.fill,
            //           width: MediaQuery.of(context).size.width,
            //           height: MediaQuery.of(context).size.height / 3,
            //         ),
            //       ),
            //     ),
            //     Column(
            //       children: [
            //         Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Image.asset(
            //               "assets/images/heart.png",
            //               color: const Color.fromRGBO(0, 0, 0, 0.1),
            //               width: 45.0,
            //               height: 45.0,
            //             ),
            //             Image.asset(
            //               "assets/images/caratlane_transparent.png",
            //               color: Colors.white,
            //               width: 20.0,
            //               height: 20.0,
            //             ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 30.0,
            //         ),
            //         const Text(
            //           "Launching Refer & Earn",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 15.0,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         const SizedBox(
            //           height: 10.0,
            //         ),
            //         const Text(
            //           "Inspire your friends & family and \n ear upto Rs 750 xCLusive points!",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 15.0,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 30.0,
            //         ),
            //         Container(
            //           width: 400.0,
            //           child: ButtonWidget(
            //               btnString: "Get Started",
            //               imagePath: "assets/images/right_arrow.png"),
            //         )
            //       ],
            //     ),
            //   ]),
            // ),

            // const SizedBox(
            //   height: 10.0,
            // ),

            //error
            // Container(
            //   margin: const EdgeInsets.fromLTRB(20, 15, 10, 10),
            //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.grey.shade200,
            //           offset: const Offset(0.0, 1.0),
            //           blurRadius: 1.0,
            //           spreadRadius: 2.0)
            //     ],
            //     borderRadius: BorderRadius.circular(30.0),
            //     shape: BoxShape.rectangle),
            //   child: const FreePointsWidget(textColor: Color(0xFF4F3267),),

            // ),
          ],
        ),
      ),
    );
  }

  void getFile(AsyncSnapshot<Object?> snapshot,
      CategoryProvider categoryProvider) async {
    categoryProvider.setFileInfoFetching(true);
    //  CacheMemory.listOfCategory.clear();
    await CacheMemory.getFile(snapshot);
    categoryProvider.setFileInfoFetching(false);
  }
}
