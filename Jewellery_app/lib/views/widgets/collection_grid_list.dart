import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/collections_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart' as AllProducts;
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class CollectionGridList extends StatefulWidget {
  final int collectionId;
  const CollectionGridList({super.key, required this.collectionId});

  @override
  State<CollectionGridList> createState() => _CollectionGridListState();
}

class _CollectionGridListState extends State<CollectionGridList> {
  bool isCollectionLoading = false;

  int currentIndex = 0;
  File? collectionFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("collectionFile == null ${collectionFile == null}");
    if (collectionFile == null) {
      _downloadFile();
    }

    //getCollections();
  }

  List<AllProducts.ProductsModel> listOfCollections =
      <AllProducts.ProductsModel>[];

  _downloadFile() async {
    //https: //tiarabytj.com/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&cosumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9&per_page=100&collections=12
    // String collectionsUri =
    //     "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&cosumer_secret=${Constants.consumerSecret}&per_page=100&collections=${widget.collectionId}&page=1";
    String collectionsUri =
        "https://tiarabytj.com/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&cosumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9&per_page=100&collections=12&page=1";

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("collections basicAuth $basicAuth");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };

    collectionFile = await DefaultCacheManager()
        .getSingleFile(collectionsUri, headers: headers);

    print("collectionFile != null ${collectionFile != null}");
    if (collectionFile != null) {
      if (await collectionFile!.exists()) {
        String result = await collectionFile!.readAsString();
        final json =
            jsonDecode(http.Response(result, 200, headers: headers).body);
        print("getCollectionsFile json $json");

        listOfCollections.clear();
        for (int i = 0; i < json.length; i++) {
          listOfCollections.add(AllProducts.ProductsModel(
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
      } else {
        print("error 404, 401");
      }
    }

    // if (mounted) {

    //   setState(() async {
    //     // collectionFile = DefaultCacheManager()
    //     //     .getFileStream(collectionsUri, withProgress: true);
    //       collectionFile = await DefaultCacheManager().getSingleFile(collectionsUri, headers: headers);

    //   });
    //   print("collectionFile == null ${collectionFile == null}");
    // }
  }

  // void getFile(
  //     AsyncSnapshot<Object?> snapshot, CacheProvider cacheProvider) async {
  //   print(
  //       "cacheProvider.collectionsfileInfoFetching != null ${cacheProvider.collectionsfileInfoFetching != null}");
  //   if (cacheProvider.collectionsfileInfoFetching != null) {
  //     cacheProvider.setCollectionsFileInfoFetching(true);
  //     //  CacheMemory.cacheProviderValue.clear();
  //     await CacheMemory.getCollectionsFile(snapshot);
  //     cacheProvider.setCollectionsFileInfoFetching(null);
  //   }
  // }

  // getCollections() async {
  //   setState(() {
  //     isCollectionLoading = true;
  //   });
  //   CacheMemory.listOfCollections.clear();
  //   await ApiService.getCollections(
  //       collectionId: widget.collectionId, pageNo: 1);
  //   if (mounted) {
  //     setState(() {
  //       isCollectionLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // CacheProvider cacheProvider = Provider.of(context, listen: false);

    return FutureBuilder(
            future: _downloadFile(),
            builder: (context, snapshot) {
              Widget body;
              print("!snapshot.hasData ${!snapshot.hasData}");
              print(
                  "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
              final loading =
                  !snapshot.hasData || snapshot.data is DownloadProgress;
              print("loading $loading");
              if (snapshot.hasError) {
                body = SizedBox();
                print("snapshot error ${snapshot.error.toString()}");
              }
              //   uncomment below code
              else if (loading) {
                body = SizedBox(
                    width: MediaQuery.of(context).size.width,
                   height: (MediaQuery.of(context).size.height / 2) + 220,
                    child: Center(
                      child: CircularProgressIndicator(
                        color:
                            Colors.red,
                            // Theme.of(context).primaryColor,
                      ),
                    ));
                print("snapshot.loading");
              } else {
                body = Container(
                  width: deviceWidth,
                  height: (MediaQuery.of(context).size.height / 2) + 220,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.64,
                        crossAxisCount: deviceWidth > 600 ? 3 : 2),
                    itemBuilder: (context, index) {
                      AllProducts.ProductsModel collectionsModel =
                          listOfCollections[index];
                      print(
                          "index < listOfCollections.length ${index < listOfCollections.length}");
                      if (index < listOfCollections.length) {
                        print(" productIndex: $index");
                        return ProductItem(
                          productIndex: index,
                          productsModel: collectionsModel,
                          fromFetchHome: true,
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
                    },
                  ),
                );
              }
              return body;
            },
          );
        //  StreamBuilder(
        //     stream: collectionFile!,
        //     builder: (context, snapshot) {
        //       print(
        //           "cacheProvider.collectionsfileInfoFetching != true ${cacheProvider.collectionsfileInfoFetching != true}");
        //       if (cacheProvider.collectionsfileInfoFetching != true) {
        //         print("!snapshot.hasData ${!snapshot.hasData}");
        //         if (snapshot.hasData) {
        //           getFile(snapshot, cacheProvider);
        //         }
        //         //  else {
        //         //   cacheProvider.setIsProductListEmpty(true);
        //         // }
        //       }

        //       Widget body;
        //       print("!snapshot.hasData ${!snapshot.hasData}");
        //       print(
        //           "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
        //       final loading =
        //           !snapshot.hasData || snapshot.data is DownloadProgress;
        //       // DownloadProgress? progress =
        //       //     snapshot.data as DownloadProgress?;
        //       print("loading $loading");
        //       if (snapshot.hasError) {
        //         body = SizedBox();
        //         print("snapshot error ${snapshot.error.toString()}");
        //       }
        //       //   uncomment below code
        //       else if (loading) {
        //         body = SizedBox(
        //             width: MediaQuery.of(context).size.width,
        //             height: MediaQuery.of(context).size.height - 200,
        //             child: Center(
        //               child: CircularProgressIndicator(
        //                 color:
        //                     // Colors.red,
        //                     Theme.of(context).primaryColor,
        //               ),
        //             ));
        //         print("snapshot.loading");
        //       } else {
        //         if (cacheProvider.collectionsfileInfoFetching != null) {
        //           print(
        //               "cacheProvider.collectionsfileInfoFetching ${cacheProvider.collectionsfileInfoFetching!}");
        //           if (cacheProvider.collectionsfileInfoFetching!) {
        //             body = SizedBox(
        //                 width: MediaQuery.of(context).size.width,
        //                 height: MediaQuery.of(context).size.height - 200,
        //                 child: Center(
        //                   child: CircularProgressIndicator(
        //                     color:
        //                         //Theme.of(context).primaryColor,
        //                         Colors.yellow,
        //                   ),
        //                 ));
        //           } else {
        //             body = SizedBox();
        //           }
        //         } else {
        //           print(
        //               "listOfCollections.length ${CacheMemory.listOfCollections.length}");
        // body = Container(
        //   width: deviceWidth,
        //   height: (MediaQuery.of(context).size.height / 2) + 220,
        //   child: GridView.builder(
        //     physics: NeverScrollableScrollPhysics(),
        //     itemCount: 4,
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         childAspectRatio: 0.64,
        //         crossAxisCount: deviceWidth > 600 ? 3 : 2),
        //     itemBuilder: (context, index) {
        //       AllProducts.ProductsModel collectionsModel =
        //           CacheMemory.listOfCollections[index];
        //       print(
        //           "index < CacheMemory.listOfCollections.length ${index < CacheMemory.listOfCollections.length}");
        //       if (index < CacheMemory.listOfCollections.length) {
        //         print(" productIndex: $index");
        //         return ProductItem(
        //           productIndex: index,
        //           productsModel: collectionsModel,
        //           fromFetchHome: true,
        //         );
        //       } else {
        //         return const Padding(
        //           padding: EdgeInsets.symmetric(
        //               vertical: 15.0, horizontal: 10.0),
        //           child: Center(
        //               child: CircularProgressIndicator(
        //             color: Color(0xffCC868A),
        //           )),
        //         );
        //       }
        //     },
        //   ),
        // );
        // }
        //         print("snapshot.data ${snapshot.data}");
        //       }
        //       return body;
        //     },
        //   )

        // : SizedBox(
        //     height: (MediaQuery.of(context).size.height / 2) + 220,
        //     child: Center(
        //       child: CircularProgressIndicator(
        //         color: Colors.yellow,
        //       ),
        //     ),
        //   );
  }
}
