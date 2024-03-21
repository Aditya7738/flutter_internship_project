import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_modal.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
import 'package:Tiara_by_TJ/views/widgets/search_products_category.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';

import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductPage extends StatefulWidget {
  final int id;
  final bool fromFetchHome;
  const ProductPage({super.key, required this.id, required this.fromFetchHome});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //List<ProductOfCategoryModel> listOfProductsCategoryWise = [];
  final ScrollController _scrollController = ScrollController();

  bool isLoading = true;

  bool isThereMoreProducts = false;

  bool newListLoading = false;

  late CategoryProvider categoryProvider;
  late FilterOptionsProvider filterOptionsProvider;

  bool isCollectionLoading = false;

  Stream<FileResponse>? productFileStream;

  @override
  void initState() {
    super.initState();

    categoryProvider = Provider.of(context, listen: false);
    filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    // if (widget.fromFetchHome == false) {
    //   getProducts();
    // }

    print("productFileStream == null ${productFileStream == null}");
    if (productFileStream == null) {
      _downloadFile();
    }

    _scrollController.addListener(() async {
      print(
          "CONDITION ${_scrollController.position.pixels == _scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("REACHED END OF LIST");

        loadMoreData();
      }
    });
  }

  void _downloadFile() {
    String productsUri =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&category=${widget.id}&per_page=100&page=1";
    if (mounted) {
      setState(() {
        productFileStream = DefaultCacheManager()
            .getFileStream(productsUri, withProgress: true);
      });
      print("productFileStream == null ${productFileStream == null}");
    }
  }

  void loadMoreData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    if (widget.fromFetchHome == false) {
      isThereMoreProducts = await ApiService.showNextPagesCategoryProduct();
    } else {
      isThereMoreProducts = await ApiService.showNextPagesCollectionProduct();
    }
    // Fetch more data (e.g., using ApiService)

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getProducts() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      categoryProvider.setIsCategoryProductFetching(true);
      ApiService.listOfProductsCategoryWise.clear();
      await ApiService.fetchProductsCategoryWise(id: widget.id, pageNo: 1);

      categoryProvider.setIsCategoryProductFetching(false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //  final filterProvider = Provider.of<FilterOptionsProvider>(context);
    filterOptionsProvider.clearFilterList();
    _scrollController.dispose();
    super.dispose();
  }

  void getFile(
      AsyncSnapshot<Object?> snapshot, CacheProvider cacheProvider) async {
    if (cacheProvider.fileInfoFetching != null) {
      cacheProvider.setFileInfoFetching(true);
      //  CacheMemory.cacheProviderValue.clear();
      await CacheMemory.getProductsFile(snapshot);
      cacheProvider.setFileInfoFetching(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    CacheProvider cacheProvider =
        Provider.of<CacheProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    print("deviceWidth / 20 ${deviceWidth / 31}");
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: (kToolbarHeight + kToolbarHeight) - 40,
            title: Text("Products"),
            actions: <Widget>[
              Container(
                width: (deviceWidth / 16) + 4,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
                  badgeContent: Consumer<WishlistProvider>(
                      builder: (context, value, child) {
                    print("LENGTH OF FAV: ${value.favProductIds}");
                    return Text(
                      value.favProductIds.length.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (deviceWidth / 31) - 1),
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
                width: 24,
              ),
              Container(
                width: (deviceWidth / 16) + 4,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
                  badgeContent: Consumer<CartProvider>(
                      builder: (context, value, child) => Text(
                            value.cart.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: (deviceWidth / 31) - 1),
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
                width: 34,
              ),
            ],
            bottom: SearchProductsOfCategory(categoryId: widget.id)),
        body: SingleChildScrollView(
          child: Consumer<CategoryProvider>(
              builder: (context, categoryProviderValue, child) {
            print("product page ${MediaQuery.of(context).size.width}");
            print("widget.fromFetchHome ${widget.fromFetchHome}");
            return Column(
              children: [
                Consumer<FilterOptionsProvider>(
                  builder: (context, value, child) {
                    return value.list.isEmpty
                        ? SizedBox()
                        : SizedBox(
                            height: 70.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(5.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: value.list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Chip(
                                      padding: EdgeInsets.all(7.0),
                                      label: Text(
                                        value.list[index]["parent"] ==
                                                "price_range"
                                            ? "₹ ${value.list[index]["price_range"]["min_price"]} - ₹ ${value.list[index]["price_range"]["max_price"]}"
                                            : value.list[index]["label"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                deviceWidth > 600 ? 26.0 : 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      deleteIcon: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: deviceWidth > 600 ? 25.0 : 19.0,
                                        ),
                                      ),
                                      onDeleted: () async {
                                        print("ONDELETED CALLED");

                                        print("index to remove $index");

                                        value.removeFromList(index);

                                        print("_list ${value.list}");

                                        bool isThereInternet = await ApiService
                                            .checkInternetConnection(context);
                                        if (isThereInternet) {
                                          categoryProviderValue
                                              .setIsCategoryProductFetching(
                                                  true);

                                          ApiService.listOfProductsModel
                                              .clear();
                                          await ApiService.fetchProducts(
                                              categoryProviderValue.searchText,
                                              1,
                                              filterList: value.list);
                                          categoryProviderValue
                                              .setIsCategoryProductFetching(
                                                  false);
                                        }
                                      }),
                                );
                              },
                            ),
                          );
                  },
                ),
                // categoryProviderValue.isCategoryProductFetching
                //     ? SizedBox(
                //         width: MediaQuery.of(context).size.width,
                //         height: MediaQuery.of(context).size.height - 136,
                //         child: const Center(
                //           child: CircularProgressIndicator(
                //             backgroundColor: Colors.black,
                //             color: Colors.white,
                //           ),
                //         ),
                //       )
                //     :

                widget.fromFetchHome == false
                    ? productFileStream != null
                        ? StreamBuilder(
                            stream: productFileStream!,
                            builder: (context, snapshot) {
                              print(
                                  "cacheProvider.fileInfoFetching != true ${cacheProvider.fileInfoFetching != true}");
                              if (cacheProvider.fileInfoFetching != true) {
                                print("!snapshot.hasData ${!snapshot.hasData}");
                                if (snapshot.hasData) {
                                  getFile(snapshot, cacheProvider);
                                } else {
                                  cacheProvider.setIsProductListEmpty(true);
                                }
                              }

                              Widget body;

                              print(
                                  "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
                              final loading = !snapshot.hasData ||
                                  snapshot.data is DownloadProgress;
                              // DownloadProgress? progress =
                              //     snapshot.data as DownloadProgress?;
                              print("loading $loading");
                              if (snapshot.hasError) {
                                body = SizedBox();
                                print(
                                    "snapshot error ${snapshot.error.toString()}");
                              }
                              //   uncomment below code
                              else if (loading) {
                                body = SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height -
                                        136,
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
                                // print("productFileStream.length ${}");

                                if (cacheProvider.fileInfoFetching != null) {
                                  print(
                                      "cacheProvider.fileInfoFetching ${cacheProvider.fileInfoFetching!}");
                                  if (cacheProvider.fileInfoFetching!) {
                                    body = SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                136,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color:
                                                //Theme.of(context).primaryColor,
                                                Colors.yellow,
                                          ),
                                        ));
                                  } else {
                                    body = SizedBox();
                                  }
                                } else {
                                  print(
                                      "CacheMemory.listOfProducts.length ${CacheMemory.listOfProducts.length}");
                                  body = SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height -
                                        136,
                                    child: Scrollbar(
                                      child: GridView.builder(
                                          controller: _scrollController,
                                          itemCount: CacheMemory
                                                  .listOfProducts.length +
                                              (isLoading || !isThereMoreProducts
                                                  ? 1
                                                  : 0),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 0.64,
                                            crossAxisCount:
                                                MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        600
                                                    ? 3
                                                    : 2,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            print(
                                                "index < CacheMemory.listOfProducts.length ${index < CacheMemory.listOfProducts.length}");
                                            if (index <
                                                CacheMemory
                                                    .listOfProducts.length) {
                                              print(" productIndex: $index");
                                              return ProductItem(
                                                productIndex: index,
                                                productsModel: CacheMemory
                                                    .listOfProducts[index],
                                                fromFetchHome:
                                                    widget.fromFetchHome,
                                              );
                                            } else if (!isThereMoreProducts ||
                                                cacheProvider
                                                    .isProductListEmpty) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 10.0),
                                                child: Center(
                                                    child: Text(
                                                  "There are no more products",
                                                  style: TextStyle(
                                                      fontSize:
                                                          deviceWidth / 33,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              );
                                            } else {
                                              return const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 10.0),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Color(0xffCC868A),
                                                )),
                                              );
                                            }
                                          }),
                                    ),
                                  );
                                }
                                print("snapshot.data ${snapshot.data}");
                              }
                              return body;
                            },
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 136,
                        child: Scrollbar(
                          child: GridView.builder(
                              controller: _scrollController,
                              itemCount: ApiService.collectionList.length +
                                  (isLoading || !isThereMoreProducts ? 1 : 0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.64,
                                crossAxisCount:
                                    MediaQuery.of(context).size.width > 600
                                        ? 3
                                        : 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                if (index < ApiService.collectionList.length) {
                                  print(" productIndex: $index");
                                  return ProductItem(
                                    productIndex: index,
                                    productsModel:
                                        ApiService.collectionList[index],
                                    fromFetchHome: widget.fromFetchHome,
                                  );
                                } else if (!isThereMoreProducts ||
                                    categoryProviderValue.isProductListEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    child: Center(
                                        child: Text(
                                      "There are no more products",
                                      style: TextStyle(
                                          fontSize: deviceWidth / 33,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Color(0xffCC868A),
                                    )),
                                  );
                                }
                              }),
                        ),
                      ),
              ],
            );
          }),
        ));
  }
}
