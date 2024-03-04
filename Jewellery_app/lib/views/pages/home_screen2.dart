import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/model/choice_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/choice_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int currentIndex = 0;

  // late CarouselController carouselController;

  List<String> images = <String>[];

  bool isCategoryLoading = true;

  bool isNewCategoryLoading = false;

  //List<CategoriesModel> categories = <CategoriesModel>[];
  final CarouselController carouselController = CarouselController();

  bool isSalesLoading = false;

  @override
  void initState() {
    super.initState();
    //getDataFromProvider();
    // carouselController = CarouselController();
    getCategories();
    //getNewArrivals();
    getProductsOnSale();
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
    ApiService.listOfCategory.clear();
    await ApiService.showNextPageOfCategories(context);

    //categories = ApiService.listOfCategory;
    if (mounted) {
      setState(() {
        isNewCategoryLoading = false;
      });
    }
  }

  Future<void> getCategories() async {
    await ApiService.fetchCategories(1, context);

    //categories = ApiService.listOfCategory;

    for (var i = 0; i < ApiService.listOfCategory.length; i++) {
      images.add(
          ApiService.listOfCategory[i].image?.src ?? Constants.defaultImageUrl);
    }

    if (mounted) {
      setState(() {
        isCategoryLoading = false;
      });
    }
  }

  Future<void> getProductsOnSale() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isSalesLoading = true;
        });
      }
      await ApiService.getOnSaleProducts(1);

      //categories = ApiService.listOfCategory;

      // for (var i = 0; i < ApiService.listOfCategory.length; i++) {
      //   images.add(
      //       ApiService.listOfCategory[i].image?.src ?? Constants.defaultImageUrl);
      // }

      if (mounted) {
        setState(() {
          isSalesLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> layoutsOptions = <String>[
      "Home screen 1",
      "Home screen 2",
      "Home screen 3",
    ];

    ChoiceModel choiceModel =
        ChoiceModel(options: layoutsOptions, selectedOption: layoutsOptions[1]);

    print(
        "ApiService.listOfCategory.length ${ApiService.listOfCategory.length ~/ 2}");
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CachedNetworkImage(
            imageUrl: Constants.app_logo,
            width: 150,
            height: 70,
            placeholder: (context, url) {
              return SizedBox(
                width: 150,
                height: 70,
                child: const Center(
                  child: LinearProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ));
              },
              child: Icon(
                Icons.search_rounded,
                size: 30.0,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              height: 40.0,
              width: 32.0,
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
                badgeContent: Consumer<WishlistProvider>(
                    builder: (context, value, child) {
                  print("LENGTH OF FAV: ${value.favProductIds}");
                  return Text(
                    value.favProductIds.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WishListPage()));
                  },
                  icon: const Icon(Icons.favorite_sharp, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              height: 40.0,
              width: 32.0,
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
                badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                          value.cart.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                child: IconButton(
                  onPressed: () {
                    print("CART CLICKED");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChoiceWidget(choiceModel: choiceModel, fromCart: true),
                SizedBox(width: 10.0,)
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Products on Sale",
              style: TextStyle(fontSize: 27.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            // isSalesLoading
            //     ?
            //     SizedBox(
            //         height: MediaQuery.of(context).size.width / 2,
            //         child: Center(
            //           child: CircularProgressIndicator(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       )
            //     :
            CarouselSlider.builder(
              itemCount: ApiService.listOfCategory.length ~/ 2,
              itemBuilder: (context, index, realIndex) {
                // final image1Label = ApiService.listOfCategory[index * 2].name;
                // final image2Label = ApiService.listOfCategory[index * 2 + 1].name;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: Colors.yellow,
                        child: isNewCategoryLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : ProductItem(
                                productsModel: ApiService.onSaleProducts[index],
                              )),
                    Container(
                        color: Colors.red,
                        child: isNewCategoryLoading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : ProductItem(
                                productsModel: ApiService.onSaleProducts[index],
                              )),
                  ],
                );
              },
              options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: 340,
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
              height: 40.0,
            ),
            Text(
              "Newly Arrivals",
              style: TextStyle(fontSize: 27.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            // isCategoryLoading
            //     ?
            //      SizedBox(
            //         height: MediaQuery.of(context).size.width / 2,
            //         child: Center(
            //           child: CircularProgressIndicator(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       )
            //     :
            CarouselSlider.builder(
              itemCount: ApiService.listOfCategory.length ~/ 2,
              itemBuilder: (context, index, realIndex) {
                // final image1Label = ApiService.listOfCategory[index * 2].name;
                // final image2Label = ApiService.listOfCategory[index * 2 + 1].name;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: Colors.yellow,
                        child: ProductItem(
                          productsModel: ApiService.onSaleProducts[index],
                        )),
                    Container(
                        color: Colors.red,
                        child: ProductItem(
                          productsModel: ApiService.onSaleProducts[index],
                        )),
                  ],
                );
              },
              options: CarouselOptions(
                  viewportFraction: 1.03,
                  height: 255,
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
              height: 40.0,
            ),
            Text(
              "Categories",
              style: TextStyle(fontSize: 27.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            // isCategoryLoading || isNewCategoryLoading
            //     ?
            //     SizedBox(
            //         height: MediaQuery.of(context).size.width / 2,
            //         child: Center(
            //           child: CircularProgressIndicator(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       )
            //     :
            CarouselSlider.builder(
              itemCount: ApiService.listOfCategory.length ~/ 2,
              itemBuilder: (context, index, realIndex) {
                // final image1Label = ApiService.listOfCategory[index * 2].name;
                // final image2Label = ApiService.listOfCategory[index * 2 + 1].name;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.yellow,
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: images[index * 2],
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            placeholder: (context, url) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              ApiService.listOfCategory[index * 2].name ??
                                  "Jewellery",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: images[index * 2 + 1],
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            placeholder: (context, url) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              ApiService.listOfCategory[index * 2 + 1].name ??
                                  "Jewellery",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                  viewportFraction: 1.03,
                  height: 255,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  //autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    print("ON PAGE CHANGED CALL");
                    handleCarouselSlide(index);
                  }),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  void handleCarouselSlide(int index) {
    print(
        "CURRENT INDEX $index, ${(ApiService.listOfCategory.length / 2) - 1}");
    if (index == ((ApiService.listOfCategory.length / 2) - 1)) {
      print("CALL LOAD MORE DATA");
      loadMoreData();
    }
  }
}
