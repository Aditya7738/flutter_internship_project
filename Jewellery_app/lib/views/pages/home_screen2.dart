import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
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

  late CarouselController carouselController;

  List<String> images = <String>[];

  bool isLoading = true;

  bool isNewCategoryLoading = false;

  List<CategoriesModel> categories = <CategoriesModel>[];

  @override
  void initState() {
    super.initState();
    //getDataFromProvider();
    carouselController = CarouselController();
    getRequest();
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
    setState(() {
      isNewCategoryLoading = true;
    });

    // Fetch more data (e.g., using ApiService)
    await ApiService.showNextPageOfCategories();

    categories = ApiService.listOfCategory;
    setState(() {
      isNewCategoryLoading = false;
    });
  }

  Future<void> getRequest() async {
    await ApiService.fetchCategories(1);

    categories = ApiService.listOfCategory;

    for (var i = 0; i < categories.length; i++) {
      images.add(categories[i].image?.src ?? Strings.defaultImageUrl);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CachedNetworkImage(
            imageUrl: Strings.app_logo,
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
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
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
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
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
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
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
}
