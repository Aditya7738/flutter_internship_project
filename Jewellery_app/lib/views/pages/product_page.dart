import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/products_model.dart' as AllProducts;
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_modal.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
import 'package:Tiara_by_TJ/views/widgets/search_products_category.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductPage extends StatefulWidget {
  final int id;
  final bool forCollections;
  static List<AllProducts.ProductsModel> listOfCollections =
      <AllProducts.ProductsModel>[];
  const ProductPage(
      {super.key, required this.id, required this.forCollections});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //List<ProductOfCategoryModel> listOfProductsCategoryWise = [];
  final ScrollController _scrollController = ScrollController();
  File? collectionFile;
  bool isLoading = true;

  bool isThereMoreProducts = false;

  bool newListLoading = false;

  late CategoryProvider categoryProvider;
  late FilterOptionsProvider filterOptionsProvider;

  bool isCollectionLoading = false;

  //Stream<FileResponse>? productFileStream;
  Stream<FileResponse>? collectionFileStream;

  @override
  void initState() {
    super.initState();

    categoryProvider = Provider.of(context, listen: false);
    filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    if (widget.forCollections == false) {
      getProducts();
    }
    // if (widget.forCollections == false) {
    //   print("productFileStream == null ${productFileStream == null}");
    //   if (productFileStream == null) {
    //     _downloadFile();
    //   }
    // } else {
    if (widget.forCollections) {
      if (collectionFile == null) {
        _downloadCollectionFile(1);
      }
    }

    _scrollController.addListener(() async {
      print(
          "CONDITION ${_scrollController.position.pixels == _scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("REACHED END OF LIST");
          _downloadNextCollectionsFile();
        //loadMoreData();
      }
    });
  }

  int responseofCollectionPages = 1;
  int increasingCollectionPageNo = 1;

  _downloadCollectionFile(int pageNo) async {
    CacheProvider cacheProvider =
        Provider.of<CacheProvider>(context, listen: false);

    String collectionsUri =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&cosumer_secret=${Constants.consumerSecret}&per_page=100&collections=${widget.id}&page=$pageNo";

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("collections basicAuth $basicAuth");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };

    if (pageNo > 1) {
      print("pageNo $pageNo");
      // RandomAccessFile randomAccessFile = await collectionFile!.open(mode: FileMode.append);
      print("collectionFile != null ${collectionFile != null}");
      if (collectionFile != null) {
        bool isPathExist = false;
        try {
          File file = File(collectionFile!.path);
          isPathExist = await file.exists();
        } catch (e) {
          print("doFileExist error ${e.toString()}");
          isPathExist = false;
        }

        print("isPathExist $isPathExist");

        if (isPathExist) {
          print(
              "jsonDecode(collectionFile!.readAsStringSync()) ${jsonDecode(collectionFile!.readAsStringSync())}");

          List<dynamic> oldList =
              jsonDecode(collectionFile!.readAsStringSync());

          cacheProvider.setIsMoreProductLoading(true);

          File file = await DefaultCacheManager()
              .getSingleFile(collectionsUri, headers: headers);

          List<dynamic> newList = jsonDecode(file.readAsStringSync());

          oldList.addAll(newList);

          print("oldList length ${oldList.length}");

          String json = jsonEncode(oldList);

          print("new josn $json");

          for (var i = 0; i < oldList.length; i++) {
            collectionFile!.writeAsStringSync(json, mode: FileMode.write);
          }
          cacheProvider.setIsMoreProductLoading(false);
        }
      }
    } else {
      cacheProvider.setCollectionsProductFileInfoFetching(true);

      collectionFile = await DefaultCacheManager()
          .getSingleFile(collectionsUri, headers: headers);

      cacheProvider.setCollectionsProductFileInfoFetching(false);
    }

    print("collectionFile != null ${collectionFile != null}");
    if (collectionFile != null) {
      if (await collectionFile!.exists()) {
        String result = await collectionFile!.readAsString();
        print("collectionFile result $result");
        final json =
            jsonDecode(http.Response(result, 200, headers: headers).body);
        print("getCollectionsFile json $json");

        ProductPage.listOfCollections.clear();
        for (int i = 0; i < json.length; i++) {
          ProductPage.listOfCollections.add(AllProducts.ProductsModel(
            id: json[i]["id"],
            name: json[i]["name"],
            slug: json[i]["slug"],
            permalink: json[i]["permalink"],
            dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
            dateCreatedGmt:
                DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
            dateModified: DateTime.tryParse(json[i]["date_modified"] ?? ""),
            dateModifiedGmt:
                DateTime.tryParse(json[i]["date_modified_gmt"] ?? ""),
            type: json[i]["type"],
            status: json[i]["status"],
            featured: json[i]["featured"],
            catalogVisibility: json[i]["catalog_visibility"],
            description: json[i]["description"],
            shortDescription: json[i]["short_description"],
            sku: json[i]["sku"],
            price: json[i]["price"],
            regularPrice: json[i]["regular_price"],
            salePrice: json[i]["sale_price"],
            dateOnSaleFrom: json[i]["date_on_sale_from"],
            dateOnSaleFromGmt: json[i]["date_on_sale_from_gmt"],
            dateOnSaleTo: json[i]["date_on_sale_to"],
            dateOnSaleToGmt: json[i]["date_on_sale_to_gmt"],
            onSale: json[i]["on_sale"],
            purchasable: json[i]["purchasable"],
            totalSales: json[i]["total_sales"],
            virtual: json[i]["virtual"],
            downloadable: json[i]["downloadable"],
            downloads: json[i]["downloads"] == null
                ? []
                : List<dynamic>.from(json[i]["downloads"]!.map((x) => x)),
            downloadLimit: json[i]["download_limit"],
            downloadExpiry: json[i]["download_expiry"],
            externalUrl: json[i]["external_url"],
            buttonText: json[i]["button_text"],
            taxStatus: json[i]["tax_status"],
            taxClass: json[i]["tax_class"],
            manageStock: json[i]["manage_stock"],
            stockQuantity: json[i]["stock_quantity"],
            backorders: json[i]["backorders"],
            backordersAllowed: json[i]["backorders_allowed"],
            backordered: json[i]["backordered"],
            lowStockAmount: json[i]["low_stock_amount"],
            soldIndividually: json[i]["sold_individually"],
            weight: json[i]["weight"],
            dimensions: json[i]["dimensions"] == null
                ? null
                : AllProducts.Dimensions.fromJson(json[i]["dimensions"]),
            shippingRequired: json[i]["shipping_required"],
            shippingTaxable: json[i]["shipping_taxable"],
            shippingClass: json[i]["shipping_class"],
            shippingClassId: json[i]["shipping_class_id"],
            reviewsAllowed: json[i]["reviews_allowed"],
            averageRating: json[i]["average_rating"],
            ratingCount: json[i]["rating_count"],
            upsellIds: json[i]["upsell_ids"] == null
                ? []
                : List<dynamic>.from(json[i]["upsell_ids"]!.map((x) => x)),
            crossSellIds: json[i]["cross_sell_ids"] == null
                ? []
                : List<dynamic>.from(json[i]["cross_sell_ids"]!.map((x) => x)),
            parentId: json[i]["parent_id"],
            purchaseNote: json[i]["purchase_note"],
            categories: json[i]["categories"] == null
                ? []
                : List<AllProducts.Category>.from(json[i]["categories"]!
                    .map((x) => AllProducts.Category.fromJson(x))),
            tags: json[i]["tags"] == null
                ? []
                : List<AllProducts.Category>.from(json[i]["tags"]!
                    .map((x) => AllProducts.Category.fromJson(x))),
            images: json[i]["images"] == null
                ? []
                : List<AllProducts.ProductImage>.from(json[i]["images"]!
                    .map((x) => AllProducts.ProductImage.fromJson(x))),
            attributes: json[i]["attributes"] == null
                ? []
                : List<AllProducts.Attribute>.from(json[i]["attributes"]!
                    .map((x) => AllProducts.Attribute.fromJson(x))),
            defaultAttributes: json[i]["default_attributes"] == null
                ? []
                : List<dynamic>.from(
                    json[i]["default_attributes"]!.map((x) => x)),
            variations: json[i]["variations"] == null
                ? []
                : List<dynamic>.from(json[i]["variations"]!.map((x) => x)),
            groupedProducts: json[i]["grouped_products"] == null
                ? []
                : List<dynamic>.from(
                    json[i]["grouped_products"]!.map((x) => x)),
            menuOrder: json[i]["menu_order"],
            priceHtml: json[i]["price_html"],
            relatedIds: json[i]["related_ids"] == null
                ? []
                : List<int>.from(json[i]["related_ids"]!.map((x) => x)),
            metaData: json[i]["meta_data"] == null
                ? []
                : List<AllProducts.MetaDatum>.from(json[i]["meta_data"]!
                    .map((x) => AllProducts.MetaDatum.fromJson(x))),
            stockStatus: json[i]["stock_status"],
            hasOptions: json[i]["has_options"],
            postPassword: json[i]["post_password"],
            subcategory: json[i]["subcategory"] == null
                ? []
                : List<dynamic>.from(json[i]["subcategory"]!.map((x) => x)),
            // collections: json["collections"] == null ? [] : List<ProductsModelCollection>.from(json["collections"]!.map((x) => ProductsModelCollection.fromJson(x))),
            // links: json["_links"] == null ? null : AllProducts.Links.fromJson(json["_links"])
          ));
        }

        if (responseofCollectionPages == 1) {
          Uri uri = Uri.parse(collectionsUri);

          final response = await http.get(uri, headers: headers);

          print("response.statusCode == 200 ${response.statusCode == 200}");

          if (response.statusCode == 200) {
            responseofCollectionPages =
                int.parse(response.headers['x-wp-totalpages']!);

            print("responseofCollectionPages $responseofCollectionPages");
          }
        }
      } else {
        print("error 404, 401");
      }
    }
  }

  _downloadNextCollectionsFile() async {
    CacheProvider cacheProvider =
        Provider.of<CacheProvider>(context, listen: false);
    increasingCollectionPageNo++;
    print("increasingCollectionPageNo ${increasingCollectionPageNo}");
    print("responseofCollectionPages $responseofCollectionPages");
    print(
        "increasingCollectionPageNo <= responseofCollectionPages ${increasingCollectionPageNo <= responseofCollectionPages}");
    if (increasingCollectionPageNo <= responseofCollectionPages) {
      //  cacheProvider.setIsMoreProductLoading(true);
      await _downloadCollectionFile(increasingCollectionPageNo);
      //  cacheProvider.setIsMoreProductLoading(false);
    } else {
      cacheProvider.setIsProductListEmpty(false);
    }
  }

  // void _downloadFile() {
  //   String productsUri =
  //       "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&category=${widget.id}&per_page=100&page=1";
  //   if (mounted) {
  //     setState(() {
  //       productFileStream = DefaultCacheManager()
  //           .getFileStream(productsUri, withProgress: true);
  //     });
  //     print("productFileStream == null ${productFileStream == null}");
  //   }
  // }

  // void loadMoreData() async {
  //   if (widget.forCollections == false) {
  //     isThereMoreProducts = await ApiService.showNextPagesCategoryProduct();
  //   } else {
  //     isThereMoreProducts = await ApiService.showNextPagesCollectionProduct();
  //   }
  // }

  Future<void> getProducts() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      categoryProvider.setIsCategoryProductFetching(true);
      ApiService.listOfProductsCategoryWise.clear();
      print("categoryId ${widget.id}");
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

  // void getFile(
  //     AsyncSnapshot<Object?> snapshot, CacheProvider cacheProvider) async {
  //   if (cacheProvider.fileInfoFetching != null) {
  //     cacheProvider.setFileInfoFetching(true);
  //     CacheMemory.listOfProducts.clear();
  //     await CacheMemory.getProductsFile(snapshot);
  //     cacheProvider.setFileInfoFetching(null);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    CacheProvider cacheProvider =
        Provider.of<CacheProvider>(context, listen: false);

    FilterOptionsProvider filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context);

    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);

    CategoryProvider categoryProvider = Provider.of(context, listen: false);

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    print("deviceWidth / 20 ${deviceWidth / 31}");

    print("forCollection ${widget.forCollections}");
    double reduceSize = widget.forCollections
        ? kToolbarHeight - 30
        : (kToolbarHeight + kToolbarHeight) + 70;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: widget.forCollections
                ? kToolbarHeight
                : (kToolbarHeight + kToolbarHeight) - 40,
            title: Text("Products"),
            actions: <Widget>[
              Container(
                width: (deviceWidth / 16) + 4,
                child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                      badgeColor:
                          //    Colors.purple
                          Color(int.parse(
                              "0xff${layoutDesignProvider.primary.substring(1)}"))),
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
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: Color(int.parse(
                          "0xff${layoutDesignProvider.primary.substring(1)}"))),
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
            bottom: widget.forCollections
                ? null
                : SearchProductsOfCategory(categoryId: widget.id)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<FilterOptionsProvider>(
                builder: (context, value, child) {
                  return value.list.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          height: 70.0,
                          width: deviceWidth,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(5.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: value.list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        categoryProvider
                                            .setIsCategoryProductFetching(true);

                                        ApiService.listOfProductsModel.clear();
                                        await ApiService.fetchProducts(
                                            categoryProvider.searchText, 1,
                                            filterList: value.list);
                                        categoryProvider
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
              widget.forCollections == false
                  // ?
                  // filterOptionsProvider.haveSubmitClicked == false
                  // ? productFileStream != null
                  // false
                  //     ? StreamBuilder(
                  //         stream: productFileStream!,
                  //         builder: (context, snapshot) {
                  //           print(
                  //               "cacheProvider.fileInfoFetching != true ${cacheProvider.fileInfoFetching != true}");
                  //           if (cacheProvider.fileInfoFetching != true) {
                  //             print(
                  //                 "!snapshot.hasData ${!snapshot.hasData}");
                  //             if (snapshot.hasData) {
                  //               getFile(snapshot, cacheProvider);
                  //             } else {
                  //               cacheProvider.setIsProductListEmpty(true);
                  //             }
                  //           }

                  //           Widget body;

                  //           print(
                  //               "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
                  //           final loading = !snapshot.hasData ||
                  //               snapshot.data is DownloadProgress;
                  //           // DownloadProgress? progress =
                  //           //     snapshot.data as DownloadProgress?;
                  //           print("loading $loading");
                  //           if (snapshot.hasError) {
                  //             body = SizedBox();
                  //             print(
                  //                 "snapshot error ${snapshot.error.toString()}");
                  //           }
                  //           //   uncomment below code

                  //           else if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             body = SizedBox(
                  //                 width: deviceWidth,
                  //                 height: deviceHeight - 176,
                  //                 child: Center(
                  //                   child: CircularProgressIndicator(
                  //                     color:
                  //                         // Colors.red,
                  //                         Theme.of(context).primaryColor,
                  //                   ),
                  //                 ));
                  //             print("snapshot.loading");
                  //           }
                  //           // else if (loading) {
                  //           //   body = SizedBox(
                  //           //       width: deviceWidth,
                  //           //       height: deviceHeight -
                  //           //           176,
                  //           //       child: Center(
                  //           //         child: CircularProgressIndicator(
                  //           //           color:
                  //           //               // Colors.red,
                  //           //               Theme.of(context).primaryColor,
                  //           //         ),
                  //           //       ));
                  //           //   print("snapshot.loading");
                  //           //   //  p_i.ProgressIndicator(
                  //           //   //   progress: snapshot.data as DownloadProgress?,
                  //           //   // );
                  //           // }
                  //           else {
                  //             // print("productFileStream.length ${}");

                  //             if (cacheProvider.fileInfoFetching != null) {
                  //               print(
                  //                   "cacheProvider.fileInfoFetching ${cacheProvider.fileInfoFetching!}");
                  //               if (cacheProvider.fileInfoFetching!) {
                  //                 body = SizedBox(
                  //                     width: deviceWidth,
                  //                     height: MediaQuery.of(context)
                  //                             .size
                  //                             .height -
                  //                         176,
                  //                     child: Center(
                  //                       child: CircularProgressIndicator(
                  //                         color: Theme.of(context)
                  //                             .primaryColor,
                  //                         // Colors.yellow,
                  //                       ),
                  //                     ));
                  //               } else {
                  //                 body = SizedBox(
                  //                     width: deviceWidth,
                  //                     height: MediaQuery.of(context)
                  //                             .size
                  //                             .height -
                  //                         176,
                  //                     child: Center(
                  //                       child: CircularProgressIndicator(
                  //                         color: Theme.of(context)
                  //                             .primaryColor,
                  //                         // Colors.yellow,
                  //                       ),
                  //                     ));
                  //               }
                  //             } else {
                  //               print(
                  //                   "CacheMemory.listOfProducts.length ${CacheMemory.listOfProducts.length}");
                  //               body = SizedBox(
                  //                 width: deviceWidth,
                  //                 height: deviceHeight - 176,
                  //                 child: Scrollbar(
                  //                   child: GridView.builder(
                  //                       controller: _scrollController,
                  //                       itemCount:
                  //                           CacheMemory
                  //                                   .listOfProducts.length +
                  //                               (isLoading ||
                  //                                       !isThereMoreProducts
                  //                                   ? 1
                  //                                   : 0),
                  //                       gridDelegate:
                  //                           SliverGridDelegateWithFixedCrossAxisCount(
                  //                         childAspectRatio: 0.64,
                  //                         crossAxisCount:
                  //                             MediaQuery.of(context)
                  //                                         .size
                  //                                         .width >
                  //                                     600
                  //                                 ? 3
                  //                                 : 2,
                  //                       ),
                  //                       itemBuilder: (BuildContext context,
                  //                           int index) {
                  //                         print(
                  //                             "index < CacheMemory.listOfProducts.length ${index < CacheMemory.listOfProducts.length}");
                  //                         if (index <
                  //                             CacheMemory
                  //                                 .listOfProducts.length) {
                  //                           print(" productIndex: $index");
                  //                           return ProductItem(
                  //                             productIndex: index,
                  //                             productsModel: CacheMemory
                  //                                 .listOfProducts[index],
                  //                             forCollections:
                  //                                 widget.forCollections,
                  //                           );
                  //                         } else if (!isThereMoreProducts ||
                  //                             cacheProvider
                  //                                 .isProductListEmpty) {
                  //                           return Padding(
                  //                             padding: EdgeInsets.symmetric(
                  //                                 vertical: 15.0,
                  //                                 horizontal: 10.0),
                  //                             child: Center(
                  //                                 child: Text(
                  //                               "There are no more products",
                  //                               style: TextStyle(
                  //                                   fontSize:
                  //                                       deviceWidth / 33,
                  //                                   fontWeight:
                  //                                       FontWeight.bold),
                  //                             )),
                  //                           );
                  //                         } else {
                  //                           return Padding(
                  //                             padding: EdgeInsets.symmetric(
                  //                                 vertical: 15.0,
                  //                                 horizontal: 10.0),
                  //                             child: Center(
                  //                                 child:
                  //                                     CircularProgressIndicator(
                  //                               color: Theme.of(context)
                  //                                   .primaryColor,
                  //                             )),
                  //                           );
                  //                         }
                  //                       }),
                  //                 ),
                  //               );
                  //             }
                  //             print("snapshot.data ${snapshot.data}");
                  //           }
                  //           return body;
                  //         },
                  //       )
                  //     : SizedBox(
                  //         width: deviceWidth,
                  //         height: deviceHeight - 176,
                  //         child: Center(
                  //           child: CircularProgressIndicator(
                  //             color: Theme.of(context).primaryColor,
                  //           ),
                  //         ),
                  //       )
                  // :
                  ? Consumer<CategoryProvider>(
                      builder: (context, value, child) {
                        print("search reduceSize $reduceSize");
                        return value.isCategoryProductFetching
                            ? SizedBox(
                                width: deviceWidth,
                                height: deviceHeight - reduceSize,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(int.parse(
                                        "0xff${layoutDesignProvider.primary.substring(1)}")),
                                  ),
                                ))
                            : SizedBox(
                                width: deviceWidth,
                                height: deviceHeight - reduceSize,
                                child: Scrollbar(
                                  child: GridView.builder(
                                      controller: _scrollController,
                                      itemCount: ApiService
                                              .listOfProductsCategoryWise
                                              .length +
                                          (isLoading || !isThereMoreProducts
                                              ? 1
                                              : 0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.64,
                                        crossAxisCount:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 3
                                                : 2,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index <
                                            ApiService
                                                .listOfProductsCategoryWise
                                                .length) {
                                          print(" productIndex: $index");
                                          return ProductItem(
                                            productIndex: index,
                                            productsModel: ApiService
                                                    .listOfProductsCategoryWise[
                                                index],
                                            forCollections:
                                                widget.forCollections,
                                          );
                                        } else if (ApiService
                                                .listOfProductsCategoryWise
                                                .isEmpty
                                            //value.isProductListEmpty
                                            ) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                            child: Center(
                                                child: Text(
                                              "There are no more products",
                                              style: TextStyle(
                                                  fontSize: deviceWidth / 33,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          );
                                        } else {
                                          // return Padding(
                                          //   padding: EdgeInsets.symmetric(
                                          //       vertical: 15.0,
                                          //       horizontal: 10.0),
                                          //   child: Center(
                                          //       child: CircularProgressIndicator(
                                          //           color:
                                          //               //Theme.of(context).primaryColor,
                                          //               Colors.red)),
                                          // );
                                          return SizedBox();
                                        }
                                      }),
                                ),
                              );
                      },
                    )
                  //     // child:
                  //   )
                  //:
                  : collectionFile != null
                      ? Container(
                          width: deviceWidth,
                          height: deviceHeight - 104,
                          child: Scrollbar(
                            child: Consumer<CacheProvider>(
                              builder: (context, value, child) {
                                return GridView.builder(
                                  controller: _scrollController,
                                  itemCount: //ProductPage.listOfCollections.length,
                                      // ProductPage.listOfCollections.length +
                                      // (isLoading || !isThereMoreProducts ? 1 : 0),
                                      ProductPage.listOfCollections.length +
                                          //(isLoading ||!isThereMoreProducts? 1: 0),
                                          (value.isMoreProductLoading ||
                                                  value.isProductListEmpty
                                              ? 1
                                              : 0),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.64,
                                          crossAxisCount:
                                              deviceWidth > 600 ? 3 : 2),
                                  itemBuilder: (context, index) {
                                    print("reduceSize $reduceSize");
                                    print(
                                        "ProductPage.listOfCollections.length ${ProductPage.listOfCollections.length}");
                                    if (index <
                                        ProductPage.listOfCollections.length) {
                                      AllProducts.ProductsModel
                                          collectionsModel =
                                          ProductPage.listOfCollections[index];
                                      print(" productIndex: $index");
                                      return ProductItem(
                                        productIndex: index,
                                        productsModel: collectionsModel,
                                        forCollections: true,
                                      );
                                    } else if (!isThereMoreProducts ||
                                        cacheProvider.isProductListEmpty) {
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
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: Color(int.parse(
                                              "0xff${layoutDesignProvider.primary.substring(1)}")),
                                        )),
                                      );
                                    }
                                  },
                                );
                              },
                              //  child:                            ),
                            ),
                          ))
                      : Consumer<CacheProvider>(
                          builder: (context, value, child) {
                          print("reduceSize $reduceSize");
                          return value.collectionsProductFileInfoFetching
                              ? Container(
                                  width: deviceWidth,
                                  height: deviceHeight - 104,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Color(int.parse(
                                          "0xff${layoutDesignProvider.primary.substring(1)}")),
                                    ),
                                  ))
                              : Container(
                                  width: deviceWidth,
                                  height: deviceHeight - 104,
                                  child: Scrollbar(
                                    child: GridView.builder(
                                      controller: _scrollController,
                                      itemCount:
                                          // ProductPage.listOfCollections.length,
                                          ProductPage.listOfCollections.length +
                                              //(isLoading ||!isThereMoreProducts? 1: 0),
                                              (value.isMoreProductLoading ||
                                                      value.isProductListEmpty
                                                  ? 1
                                                  : 0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.64,
                                              crossAxisCount:
                                                  deviceWidth > 600 ? 3 : 2),
                                      itemBuilder: (context, index) {
                                        if (index <
                                            ProductPage
                                                .listOfCollections.length) {
                                          AllProducts.ProductsModel
                                              collectionsModel = ProductPage
                                                  .listOfCollections[index];
                                          print(" productIndex: $index");
                                          return ProductItem(
                                            productIndex: index,
                                            productsModel: collectionsModel,
                                            forCollections: true,
                                          );
                                        } else if (value.isProductListEmpty) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                            child: Center(
                                                child: Text(
                                              "There are no more products",
                                              style: TextStyle(
                                                  fontSize: deviceWidth / 33,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          );
                                        } else if (value.isMoreProductLoading) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Color(int.parse(
                                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                                            )),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                );
                        }

                          //child:
                          )
            ],
          ),
        ));
  }
}
