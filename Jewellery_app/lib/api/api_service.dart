import 'dart:convert';

import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/banner_model.dart';
import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/model/coupons_model.dart' as Coupons;
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlans;
import 'package:Tiara_by_TJ/model/filter_options_model.dart' as FilterOptions;
import 'package:Tiara_by_TJ/model/layout_model.dart';
import 'package:Tiara_by_TJ/model/product_customization_option_model.dart'
    as CustomizationOption;
import 'package:Tiara_by_TJ/model/reviews_model.dart';
import 'package:Tiara_by_TJ/views/pages/no_internet_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Tiara_by_TJ/model/order_model.dart' as CustomersOrder;
import 'package:Tiara_by_TJ/model/payment_gatways_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart' as AllProducts;
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/model/products_of_category.dart'
    as ProductsRelatedToCategory;

class ApiService {
  static List<CategoriesModel> listOfCategory = [];

  static int categoriesPageNo = 1;

  static int responseofCategoriesPages = 1;

  static Future<bool> checkInternetConnection(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoInternetConnectionPage(),
          ));
      // return true;
    } else {
      return true;
    }
  }

  static Future<bool> showNextPageOfCategories() async {
    categoriesPageNo++;
    if (categoriesPageNo <= responseofCategoriesPages) {
      await fetchCategories(categoriesPageNo);
      return true;
    }

    return false;
  }

  static String categoryUri =
      "${Constants.baseUrl}/wp-json/wc/v3/products/categories?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&page=$pageNo&per_page=100";

  static Future<List<CategoriesModel>> fetchCategories(int pageNo) async {
    //${Constants.baseUrl}/wp-json/wc/v3/products/categories?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9
    //checkInternetConnection(context);

    Uri uri = Uri.parse(categoryUri);
    final response = await http.get(uri);

    responseofCategoriesPages = int.parse(response.headers['x-wp-totalpages']!);

    if (response.statusCode == 200) {
      print("category res $response");

      final body = response.body;
      final json = jsonDecode(body);
      print("category json $json");

      for (int i = 0; i < json.length; i++) {
        listOfCategory.add(CategoriesModel(
            id: json[i]['id'],
            name: json[i]['name'],
            slug: json[i]['slug'],
            parent: json[i]['parent'],
            description: json[i]['description'],
            display: json[i]['display'],
            image: json[i]["image"] == null
                ? null
                : CategoryImageModel.fromJson(json[i]["image"]),
            menuOrder: json[i]['menuOrder'],
            count: json[i]['count'],
            links: json[i]['links']));
      }

      print("listOfCategory length ${listOfCategory.length}");
      return listOfCategory;
    } else {
      return [];
    }
  }

  static List<ProductsModel> listOfProductsCategoryWise = [];

  static int categoryPageNo = 1;
  static int categoryId = 0;

  static int responseofCategoryPages = 1;
  static Future<bool> showNextPagesCategoryProduct() async {
    categoryPageNo++;
    print(
        "categoryPageNo <= responseofCategoryPages ${categoryPageNo <= responseofCategoryPages}");

    print("NextPage categoryId $categoryId");
    if (categoryPageNo <= responseofCategoryPages) {
      await fetchProductsCategoryWise(id: categoryId, pageNo: categoryPageNo);
      return true;
    }

    return false;
  }

  static String productsUri = "";

  static Future<List<ProductsModel>> fetchProductsCategoryWise(
      {required int id, required int pageNo}) async {
    print("categoryId $id");

    categoryId = id;
    //checkInternetConnection(context);
    //${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9&category=230
    productsUri =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&category=$id&per_page=100&page=$pageNo";
    Uri uri = Uri.parse(productsUri);
    final response = await http.get(uri);

    responseofCategoryPages = int.parse(response.headers['x-wp-totalpages']!);

    print("category responseofCategoryPages $responseofCategoryPages");

    print("category response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      print(response);

      final body = response.body;
      final json = jsonDecode(body);
      print(json);

      for (int i = 0; i < json.length; i++) {
        listOfProductsCategoryWise.add(ProductsModel(
          id: json[i]['id'],
          name: json[i]['name'],
          slug: json[i]['slug'],
          permalink: json[i]['permalink'],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
          dateModified: DateTime.tryParse(json[i]["date_modified"] ?? ""),
          dateModifiedGmt:
              DateTime.tryParse(json[i]["date_modified_gmt"] ?? ""),
          type: json[i]['type'],
          status: json[i]['status'],
          featured: json[i]['featured'],
          catalogVisibility: json[i]['catalog_visibility'],
          description: json[i]['description'],
          shortDescription: json[i]['short_description'],
          sku: json[i]['sku'],
          price: json[i]['price'],
          regularPrice: json[i]['regular_price'],
          salePrice: json[i]['sale_price'],
          dateOnSaleFrom: json[i]['date_on_sale_from'],
          dateOnSaleFromGmt: json[i]['date_on_sale_from_gmt'],
          dateOnSaleTo: json[i]['date_on_sale_to'],
          dateOnSaleToGmt: json[i]['date_on_sale_to_gmt'],
          onSale: json[i]['on_sale'],
          purchasable: json[i]['purchasable'],
          totalSales: json[i]['total_sales'],
          virtual: json[i]['virtual'],
          downloadable: json[i]['downloadable'],
          downloads: json[i]["downloads"] == null
              ? []
              : List<dynamic>.from(json[i]["downloads"]!.map((x) => x)),
          downloadLimit: json[i]['download_limit'],
          downloadExpiry: json[i]['download_expiry'],
          externalUrl: json[i]['external_url'],
          buttonText: json[i]['button_text'],
          taxStatus: json[i]['tax_status'],
          taxClass: json[i]['tax_class'],
          manageStock: json[i]['manage_stock'],
          stockQuantity: json[i]['stock_quantity'],
          backorders: json[i]['backorders'],
          backordersAllowed: json[i]['backorders_allowed'],
          backordered: json[i]['backorderedd'],
          lowStockAmount: json[i]['low_stock_amount'],
          soldIndividually: json[i]['sold_individually'],
          weight: json[i]['weight'],

          shippingRequired: json[i]['shipping_required'],
          shippingTaxable: json[i]['shipping_taxable'],
          shippingClass: json[i]['shipping_class'],
          shippingClassId: json[i]['shipping_class_id'],
          reviewsAllowed: json[i]['reviews_allowed'],
          averageRating: json[i]['average_rating'],
          ratingCount: json[i]['rating_count'],
          upsellIds: json[i]["upsell_ids"] == null
              ? []
              : List<dynamic>.from(json[i]["upsell_ids"]!.map((x) => x)),
          crossSellIds: json[i]["cross_sell_ids"] == null
              ? []
              : List<dynamic>.from(json[i]["cross_sell_ids"]!.map((x) => x)),
          parentId: json[i]['parent_id'],
          purchaseNote: json[i]['purchase_note'],
          categories: json[i]["categories"] == null
              ? []
              : List<AllProducts.Category>.from(json[i]["categories"]!
                  .map((x) => AllProducts.Category.fromJson(x))),
          // tags: json[i]["tags"] == null
          //     ? <ProductsRelatedToCategory.Category>[]
          //     : List<ProductsRelatedToCategory.Category>.from(json[i]["tags"]!
          //         .map((x) => ProductsRelatedToCategory.Category.fromJson(x))),
          images: json[i]["images"] == null
              ? <ProductImage>[]
              : List<ProductImage>.from(
                  json[i]["images"]!.map((x) => ProductImage.fromJson(x))),
          // attributes: json[i]["attributes"] == null
          //     ? <ProductsRelatedToCategory.Attribute>[]
          //     : List<ProductsRelatedToCategory.Attribute>.from(json[i]
          //             ["attributes"]!
          //         .map((x) => ProductsRelatedToCategory.Attribute.fromJson(x))
          //         ),
          defaultAttributes: json[i]["default_attributes"] == null
              ? []
              : List<dynamic>.from(
                  json[i]["default_attributes"]!.map((x) => x)),
          variations: json[i]["variations"] == null
              ? []
              : List<dynamic>.from(json[i]["variations"]!.map((x) => x)),
          groupedProducts: json[i]["grouped_products"] == null
              ? []
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
          menuOrder: json[i]['menu_order'],
          priceHtml: json[i]['price_html'],
          relatedIds: json[i]["related_ids"] == null
              ? []
              : List<int>.from(json[i]["related_ids"]!.map((x) => x)),
          // metaData: json[i]["meta_data"] == null
          //     ? <ProductsRelatedToCategory.MetaDatum>[]
          //     : List<ProductsRelatedToCategory.MetaDatum>.from(json[i]
          //             ["meta_data"]!
          //         .map((x) => ProductsRelatedToCategory.MetaDatum.fromJson(x))),
          stockStatus: json[i]['stock_status'],
          hasOptions: json[i]['has_options'],
          postPassword: json[i]['post_password'],
          subcategory: json[i]["subcategory"] == null
              ? <ProductsRelatedToCategory.SubcategoryElement>[]
              : List<ProductsRelatedToCategory.SubcategoryElement>.from(
                  json[i]["subcategory"]!.map((x) =>
                      ProductsRelatedToCategory.SubcategoryElement.fromJson(
                          x))),
          // collections: json[i]["collections"] == null
          //     ? <ProductsRelatedToCategory.SubcategoryElement>[]
          //     : List<ProductsRelatedToCategory.SubcategoryElement>.from(
          //         json[i]["collections"]!.map((x) =>
          //             ProductsRelatedToCategory.SubcategoryElement.fromJson(
          //                 x))),
          // links: json[i]["_links"] == null
          //     ? null
          //     : ProductsRelatedToCategory.ProductLinks.fromJson(
          //         json[i]["_links"]),
        ));
      }

      print("LENGTH OF CATEGORY PRODUCT: ${listOfProductsCategoryWise.length}");
      return listOfProductsCategoryWise;
    } else {
      return [];
    }
  }

  static Future<List<ProductsModel>> fetchSearchedProductCategoryWise(
      {required int id,
      required int pageNo,
      required String searchText,
      List<Map<String, dynamic>>? filterList}) async {
    categoryId = id;

    //${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9&category=230
    String endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&category=$id&per_page=100&search=$searchText&page=$pageNo";

    if (filterList != null) {
      //1/////////////////
      List<Map<String, dynamic>> collections = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "collection") {
          if (filterList[j]["count"] > 0) {
            collections.add(filterList[j]);
          }
        }
      }

      List<String> ids = <String>[];
      for (int k = 0; k < collections.length; k++) {
        ids.add(collections[k]["id"].toString());
      }

      print("join ids ${ids.join(",")}");

      endpoint += "&collections=${ids.join(",")}";

      //2////////////////////////////
      List<Map<String, dynamic>> categories = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "categories") {
          if (filterList[j]["count"] > 0) {
            categories.add(filterList[j]);
          }
        }
      }
      List<String> categoriesIds = <String>[];
      for (int k = 0; k < categories.length; k++) {
        categoriesIds.add(categories[k]["id"].toString());
      }

      print("join ids ${categoriesIds.join(",")}");

      endpoint += "&category=${categoriesIds.join(",")}";

      //3//////////////////////////////////////
      List<Map<String, dynamic>> subCategories = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "sub-categories") {
          if (filterList[j]["count"] > 0) {
            subCategories.add(filterList[j]);
          }
        }
      }
      List<String> subCategoriesIds = <String>[];
      for (int k = 0; k < subCategories.length; k++) {
        subCategoriesIds.add(subCategories[k]["id"].toString());
      }

      print("join ids ${subCategoriesIds.join(",")}");

      endpoint += "&subcategory=${subCategoriesIds.join(",")}";

      //4//////////////////////////////////////
      List<Map<String, dynamic>> tags = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "tags") {
          if (filterList[j]["count"] > 0) {
            tags.add(filterList[j]);
          }
        }
      }
      List<String> tagsIds = <String>[];
      for (int k = 0; k < tags.length; k++) {
        tagsIds.add(tags[k]["id"].toString());
      }

      print("join ids ${tagsIds.join(",")}");

      endpoint += "&tag=${tagsIds.join(",")}";

      //5//////////////////////////////////////
      List<Map<String, dynamic>> diamondWts = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "diamond_wt") {
          if (filterList[j]["count"] > 0) {
            diamondWts.add(filterList[j]);
          }
        }
      }
      List<String> diamondWtIds = <String>[];
      for (int k = 0; k < diamondWts.length; k++) {
        diamondWtIds.add(diamondWts[k]["id"].toString());
      }

      print("join ids ${diamondWtIds.join(",")}");

      endpoint +=
          "&diamondWt=${diamondWtIds.join(",")}"; //--chnage here endpoint

//6//////////////////////////////////////
      List<Map<String, dynamic>> goldWts = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "gold_wt") {
          if (filterList[j]["count"] > 0) {
            goldWts.add(filterList[j]);
          }
        }
      }
      List<String> goldWtIds = <String>[];
      for (int k = 0; k < goldWts.length; k++) {
        goldWtIds.add(goldWts[k]["id"].toString());
      }

      print("join ids ${goldWtIds.join(",")}");

      endpoint += "&goldWt=${goldWtIds.join(",")}"; //--chnage here endpoint

      //7//////////////////////////////////////
      List<Map<String, dynamic>> genders = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "gender") {
          if (filterList[j]["count"] > 0) {
            genders.add(filterList[j]);
          }
        }
      }
      List<String> genderIds = <String>[];
      for (int k = 0; k < genders.length; k++) {
        genderIds.add(genders[k]["id"].toString());
      }

      print("join ids ${genderIds.join(",")}");

      endpoint += "&gender=${genderIds.join(",")}"; //--chnage here endpoint

///////////////////////////////////////////////////////
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "price_range") {
          endpoint +=
              "&min_price=${filterList[j]["price_range"]["min_price"]}&max_price=${filterList[j]["price_range"]["max_price"]}";
        }
      }
    }

    print("filtered url $endpoint");
    Uri uri = Uri.parse(endpoint);
    final response = await http.get(uri);

    responseofCategoryPages = int.parse(response.headers['x-wp-totalpages']!);

    if (response.statusCode == 200) {
      print(response);

      final body = response.body;
      final json = jsonDecode(body);
      print(json);

      for (int i = 0; i < json.length; i++) {
        listOfProductsCategoryWise.add(ProductsModel(
          id: json[i]['id'],
          name: json[i]['name'],
          slug: json[i]['slug'],
          permalink: json[i]['permalink'],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
          dateModified: DateTime.tryParse(json[i]["date_modified"] ?? ""),
          dateModifiedGmt:
              DateTime.tryParse(json[i]["date_modified_gmt"] ?? ""),
          type: json[i]['type'],
          status: json[i]['status'],
          featured: json[i]['featured'],
          catalogVisibility: json[i]['catalog_visibility'],
          description: json[i]['description'],
          shortDescription: json[i]['short_description'],
          sku: json[i]['sku'],
          price: json[i]['price'],
          regularPrice: json[i]['regular_price'],
          salePrice: json[i]['sale_price'],
          dateOnSaleFrom: json[i]['date_on_sale_from'],
          dateOnSaleFromGmt: json[i]['date_on_sale_from_gmt'],
          dateOnSaleTo: json[i]['date_on_sale_to'],
          dateOnSaleToGmt: json[i]['date_on_sale_to_gmt'],
          onSale: json[i]['on_sale'],
          purchasable: json[i]['purchasable'],
          totalSales: json[i]['total_sales'],
          virtual: json[i]['virtual'],
          downloadable: json[i]['downloadable'],
          downloads: json[i]["downloads"] == null
              ? []
              : List<dynamic>.from(json[i]["downloads"]!.map((x) => x)),
          downloadLimit: json[i]['download_limit'],
          downloadExpiry: json[i]['download_expiry'],
          externalUrl: json[i]['external_url'],
          buttonText: json[i]['button_text'],
          taxStatus: json[i]['tax_status'],
          taxClass: json[i]['tax_class'],
          manageStock: json[i]['manage_stock'],
          stockQuantity: json[i]['stock_quantity'],
          backorders: json[i]['backorders'],
          backordersAllowed: json[i]['backorders_allowed'],
          backordered: json[i]['backorderedd'],
          lowStockAmount: json[i]['low_stock_amount'],
          soldIndividually: json[i]['sold_individually'],
          weight: json[i]['weight'],

          shippingRequired: json[i]['shipping_required'],
          shippingTaxable: json[i]['shipping_taxable'],
          shippingClass: json[i]['shipping_class'],
          shippingClassId: json[i]['shipping_class_id'],
          reviewsAllowed: json[i]['reviews_allowed'],
          averageRating: json[i]['average_rating'],
          ratingCount: json[i]['rating_count'],
          upsellIds: json[i]["upsell_ids"] == null
              ? []
              : List<dynamic>.from(json[i]["upsell_ids"]!.map((x) => x)),
          crossSellIds: json[i]["cross_sell_ids"] == null
              ? []
              : List<dynamic>.from(json[i]["cross_sell_ids"]!.map((x) => x)),
          parentId: json[i]['parent_id'],
          purchaseNote: json[i]['purchase_note'],
          categories: json[i]["categories"] == null
              ? []
              : List<AllProducts.Category>.from(json[i]["categories"]!
                  .map((x) => AllProducts.Category.fromJson(x))),
          // tags: json[i]["tags"] == null
          //     ? <ProductsRelatedToCategory.Category>[]
          //     : List<ProductsRelatedToCategory.Category>.from(json[i]["tags"]!
          //         .map((x) => ProductsRelatedToCategory.Category.fromJson(x))),
          images: json[i]["images"] == null
              ? <ProductImage>[]
              : List<ProductImage>.from(
                  json[i]["images"]!.map((x) => ProductImage.fromJson(x))),
          // attributes: json[i]["attributes"] == null
          //     ? <ProductsRelatedToCategory.Attribute>[]
          //     : List<ProductsRelatedToCategory.Attribute>.from(json[i]
          //             ["attributes"]!
          //         .map((x) => ProductsRelatedToCategory.Attribute.fromJson(x))
          //         ),
          defaultAttributes: json[i]["default_attributes"] == null
              ? []
              : List<dynamic>.from(
                  json[i]["default_attributes"]!.map((x) => x)),
          variations: json[i]["variations"] == null
              ? []
              : List<dynamic>.from(json[i]["variations"]!.map((x) => x)),
          groupedProducts: json[i]["grouped_products"] == null
              ? []
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
          menuOrder: json[i]['menu_order'],
          priceHtml: json[i]['price_html'],
          relatedIds: json[i]["related_ids"] == null
              ? []
              : List<int>.from(json[i]["related_ids"]!.map((x) => x)),
          // metaData: json[i]["meta_data"] == null
          //     ? <ProductsRelatedToCategory.MetaDatum>[]
          //     : List<ProductsRelatedToCategory.MetaDatum>.from(json[i]
          //             ["meta_data"]!
          //         .map((x) => ProductsRelatedToCategory.MetaDatum.fromJson(x))),
          stockStatus: json[i]['stock_status'],
          hasOptions: json[i]['has_options'],
          postPassword: json[i]['post_password'],
          subcategory: json[i]["subcategory"] == null
              ? <ProductsRelatedToCategory.SubcategoryElement>[]
              : List<ProductsRelatedToCategory.SubcategoryElement>.from(
                  json[i]["subcategory"]!.map((x) =>
                      ProductsRelatedToCategory.SubcategoryElement.fromJson(
                          x))),
          // collections: json[i]["collections"] == null
          //     ? <ProductsRelatedToCategory.SubcategoryElement>[]
          //     : List<ProductsRelatedToCategory.SubcategoryElement>.from(
          //         json[i]["collections"]!.map((x) =>
          //             ProductsRelatedToCategory.SubcategoryElement.fromJson(
          //                 x))),
          // links: json[i]["_links"] == null
          //     ? null
          //     : ProductsRelatedToCategory.ProductLinks.fromJson(
          //         json[i]["_links"]),
        ));
      }

      print("LENGTH OF CATEGORY PRODUCT: ${listOfProductsCategoryWise.length}");
      return listOfProductsCategoryWise;
    } else {
      return [];
    }
  }

  static List<AllProducts.ProductsModel> listOfProductsModel =
      <AllProducts.ProductsModel>[];

  static int pageNo = 1;
  static late String searchString;

  String temp = "";

  static int pagesOfResponse = 1;
  static Future<bool> showNextPagesProduct(BuildContext context) async {
    pageNo++;
    if (pageNo <= pagesOfResponse) {
      await fetchProducts(searchString, pageNo);
      return true;
    }

    return false;
  }

  static Future<List<AllProducts.ProductsModel>> fetchProducts(
      String searchText, int pageNo,
      {List<Map<String, dynamic>>? filterList}) async {
    searchString = searchText;
    // checkInternetConnection(context);

    String endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&per_page=100&search=$searchText&page=$pageNo";

    if (filterList != null) {
      //1/////////////////
      List<Map<String, dynamic>> collections = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "collection") {
          if (filterList[j]["count"] > 0) {
            collections.add(filterList[j]);
          }
        }
      }

      List<String> ids = <String>[];
      for (int k = 0; k < collections.length; k++) {
        ids.add(collections[k]["id"].toString());
      }

      print("join ids ${ids.join(",")}");

      endpoint += "&collections=${ids.join(",")}";

      //2////////////////////////////
      List<Map<String, dynamic>> categories = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "categories") {
          if (filterList[j]["count"] > 0) {
            categories.add(filterList[j]);
          }
        }
      }
      List<String> categoriesIds = <String>[];
      for (int k = 0; k < categories.length; k++) {
        categoriesIds.add(categories[k]["id"].toString());
      }

      print("join ids ${categoriesIds.join(",")}");

      endpoint += "&category=${categoriesIds.join(",")}";

      //3//////////////////////////////////////
      List<Map<String, dynamic>> subCategories = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "sub-categories") {
          if (filterList[j]["count"] > 0) {
            subCategories.add(filterList[j]);
          }
        }
      }
      List<String> subCategoriesIds = <String>[];
      for (int k = 0; k < subCategories.length; k++) {
        subCategoriesIds.add(subCategories[k]["id"].toString());
      }

      print("join ids ${subCategoriesIds.join(",")}");

      endpoint += "&subcategory=${subCategoriesIds.join(",")}";

      //4//////////////////////////////////////
      List<Map<String, dynamic>> tags = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "tags") {
          if (filterList[j]["count"] > 0) {
            tags.add(filterList[j]);
          }
        }
      }
      List<String> tagsIds = <String>[];
      for (int k = 0; k < tags.length; k++) {
        tagsIds.add(tags[k]["id"].toString());
      }

      print("join ids ${tagsIds.join(",")}");

      endpoint += "&tag=${tagsIds.join(",")}";

      //5//////////////////////////////////////
      List<Map<String, dynamic>> diamondWts = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "diamond_wt") {
          if (filterList[j]["count"] > 0) {
            diamondWts.add(filterList[j]);
          }
        }
      }
      List<String> diamondWtIds = <String>[];
      for (int k = 0; k < diamondWts.length; k++) {
        diamondWtIds.add(diamondWts[k]["id"].toString());
      }

      print("join ids ${diamondWtIds.join(",")}");

      endpoint +=
          "&diamondWt=${diamondWtIds.join(",")}"; //--chnage here endpoint

//6//////////////////////////////////////
      List<Map<String, dynamic>> goldWts = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "gold_wt") {
          if (filterList[j]["count"] > 0) {
            goldWts.add(filterList[j]);
          }
        }
      }
      List<String> goldWtIds = <String>[];
      for (int k = 0; k < goldWts.length; k++) {
        goldWtIds.add(goldWts[k]["id"].toString());
      }

      print("join ids ${goldWtIds.join(",")}");

      endpoint += "&goldWt=${goldWtIds.join(",")}"; //--chnage here endpoint

      //7//////////////////////////////////////
      List<Map<String, dynamic>> genders = <Map<String, dynamic>>[];
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "gender") {
          if (filterList[j]["count"] > 0) {
            genders.add(filterList[j]);
          }
        }
      }
      List<String> genderIds = <String>[];
      for (int k = 0; k < genders.length; k++) {
        genderIds.add(genders[k]["id"].toString());
      }

      print("join ids ${genderIds.join(",")}");

      endpoint += "&gender=${genderIds.join(",")}"; //--chnage here endpoint

///////////////////////////////////////////////////////
      for (int j = 0; j < filterList.length; j++) {
        if (filterList[j]["parent"] == "price_range") {
          endpoint +=
              "&min_price=${filterList[j]["price_range"]["min_price"]}&max_price=${filterList[j]["price_range"]["max_price"]}";
        }
      }
    }

    print("filtered url $endpoint");

    Uri uri = Uri.parse(endpoint);

    final response = await http.get(uri);

    pagesOfResponse = int.parse(response.headers['x-wp-totalpages']!);

    for (int i = 0; i <= response.headers.entries.length; i++) {
      print("MAP ENTRIES ${response.headers.toString()}");
    }

    if (response.statusCode == 200) {
      print(response.body);
      final body = response.body;

      final json = jsonDecode(body);

      for (int i = 0; i < json.length; i++) {
        listOfProductsModel.add(AllProducts.ProductsModel(
          id: json[i]["id"],
          name: json[i]["name"],
          slug: json[i]["slug"],
          permalink: json[i]["permalink"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
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
              ? <AllProducts.Category>[]
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
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
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
          collections: json[i]["collections"] == null
              ? []
              : List<AllProducts.ProductsModelCollection>.from(json[i]
                      ["collections"]!
                  .map((x) => AllProducts.ProductsModelCollection.fromJson(x))),
          links: json[i]["_links"] == null
              ? null
              : AllProducts.Links.fromJson(json[i]["_links"]),
        ));
      }
      print("LENGTH OF PRODUCT: ${listOfProductsModel.length}");
      return listOfProductsModel;
    } else {
      print("LENGTH OF PRODUCT: ${listOfProductsModel.length}");
      return [];
    }
  }

  static List<AllProducts.ProductsModel> onSaleProducts =
      <AllProducts.ProductsModel>[];

  static Future<List<AllProducts.ProductsModel>> getOnSaleProducts(
      int pageNo) async {
    String endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&per_page=100&on_sale=true";

    Uri uri = Uri.parse(endpoint);

    final response = await http.get(uri);

    pagesOfResponse = int.parse(response.headers['x-wp-totalpages']!);

    for (int i = 0; i <= response.headers.entries.length; i++) {
      print("MAP ENTRIES ${response.headers.toString()}");
    }

    if (response.statusCode == 200) {
      print(response.body);
      final body = response.body;

      final json = jsonDecode(body);

      for (int i = 0; i < json.length; i++) {
        onSaleProducts.add(AllProducts.ProductsModel(
          id: json[i]["id"],
          name: json[i]["name"],
          slug: json[i]["slug"],
          permalink: json[i]["permalink"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
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
              ? <AllProducts.Category>[]
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
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
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
          collections: json[i]["collections"] == null
              ? []
              : List<AllProducts.ProductsModelCollection>.from(json[i]
                      ["collections"]!
                  .map((x) => AllProducts.ProductsModelCollection.fromJson(x))),
          links: json[i]["_links"] == null
              ? null
              : AllProducts.Links.fromJson(json[i]["_links"]),
        ));
      }
      print("LENGTH OF PRODUCT: ${onSaleProducts.length}");
      return onSaleProducts;
    } else {
      print("LENGTH OF PRODUCT: ${onSaleProducts.length}");
      return [];
    }
  }

  static List<AllProducts.ProductsModel> newlyArrivalProducts =
      <AllProducts.ProductsModel>[];

  static Future<List<AllProducts.ProductsModel>> getNewlyArrivalProducts(
      int pageNo) async {
    //checkInternetConnection(context);
    //https: //tiarabytj.com/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9
    String endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&per_page=100&on_sale=true";

    Uri uri = Uri.parse(endpoint);

    final response = await http.get(uri);

    pagesOfResponse = int.parse(response.headers['x-wp-totalpages']!);

    for (int i = 0; i <= response.headers.entries.length; i++) {
      print("MAP ENTRIES ${response.headers.toString()}");
    }

    if (response.statusCode == 200) {
      print(response.body);
      final body = response.body;

      final json = jsonDecode(body);

      for (int i = 0; i < json.length; i++) {
        newlyArrivalProducts.add(AllProducts.ProductsModel(
          id: json[i]["id"],
          name: json[i]["name"],
          slug: json[i]["slug"],
          permalink: json[i]["permalink"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
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
              ? <AllProducts.Category>[]
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
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
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
          collections: json[i]["collections"] == null
              ? []
              : List<AllProducts.ProductsModelCollection>.from(json[i]
                      ["collections"]!
                  .map((x) => AllProducts.ProductsModelCollection.fromJson(x))),
          links: json[i]["_links"] == null
              ? null
              : AllProducts.Links.fromJson(json[i]["_links"]),
        ));
      }
      print("LENGTH OF PRODUCT: ${newlyArrivalProducts.length}");
      return newlyArrivalProducts;
    } else {
      print("LENGTH OF PRODUCT: ${newlyArrivalProducts.length}");
      return [];
    }
  }

  static List<AllProducts.ProductsModel> listOfFavProductsModel =
      <AllProducts.ProductsModel>[];

  static Future<List<AllProducts.ProductsModel>> fetchFavProducts(
      List<int> ids) async {
    // checkInternetConnection(context);
    var endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&include=";

    for (int i = 0; i < ids.length; i++) {
      endpoint += "${ids[i]},";
    }

    print(endpoint);

    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);

    pagesOfResponse = int.parse(response.headers['x-wp-totalpages']!);

    if (response.statusCode == 200) {
      print(response.body);
      final body = response.body;

      final json = jsonDecode(body);

      for (int i = 0; i < json.length; i++) {
        listOfFavProductsModel.add(AllProducts.ProductsModel(
          id: json[i]["id"],
          name: json[i]["name"],
          regularPrice: json[i]["regular_price"],
          permalink: json[i]["permalink"],
          images: json[i]["images"] == null
              ? []
              : List<ProductImage>.from(
                  json[i]["images"]!.map((x) => ProductImage.fromJson(x))),
        ));
      }

      print("LENGTH OF PRODUCT: ${listOfProductsModel.length}");

      return listOfFavProductsModel;
    } else {
      return [];
    }
  }

  static Future<http.Response> createCustomer(
      Map<String, dynamic> customerData) async {
    // checkInternetConnection(context);
    const endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/customers?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";

    Uri uri = Uri.parse(endpoint);

    http.Response response = await http.post(uri, body: customerData);

    print("STATUS ${response.statusCode}");
    print("BODY ${response.body}");

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      print("JSON $json");

      return response;
    } else {
      print("ERROR SIGNUP BODY ${response.body}");
      return response;
    }
  }

  static Future<http.StreamedResponse?> loginToken(
      String username, String password) async {
    final userNameEncoded = Uri.encodeComponent(username);
    final passwordEncoded = Uri.encodeComponent(password);
    final endpoint =
        "${Constants.baseUrl}/wp-json/jwt-auth/v1/token?username=${userNameEncoded}&password=${passwordEncoded}";

    // final encoded = Uri.encodeFull(endpoint);
    //  final encoded = Uri.encodeComponent(endpoint);

    print("encoded $endpoint");

    Uri uri = Uri.parse(endpoint);

    var request = http.Request('POST', uri);

    http.StreamedResponse response = await request.send();

    print("login STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      return response;
    } else {
      print("login REASON ${response.reasonPhrase}");
      return null;
    }
  }

  // static Future<void> signupCustomer(Map<String, String> customerData) async {
  //   String endpoint = "${Constants.baseUrl}/wp-json/wc/v3/customers";
  //   String basicAuth = base64Encode(utf8.encode(
  //       "${Constants.consumerKeySignup} : ${Constants.consumerSecretSignup}"));

  //   var headers = {
  //     HttpHeaders.authorizationHeader: "Basic $basicAuth",
  //     //   HttpHeaders.contentTypeHeader: "text/html"
  //   };

  //   Uri uri = Uri.parse(endpoint);

  //   http.Response response =
  //       await http.post(uri, headers: headers, body: customerData);

  //   print("signupCustomer statusCode ${response.statusCode}");

  //   print("signupCustomer body ${response.body}");

  //   print("signupCustomer headers ${response.headers}");

  //   print("signupCustomer reasonPhrase ${response.reasonPhrase}");

  //   if (response.statusCode == 201) {
  //     // try {
  //     //   final json = jsonDecode(response.body);
  //     //   print("signupCustomer json $json");
  //     // } catch (e) {
  //     //   print("${e.toString()}");
  //     // }
  //   }
  // }

  static Future<http.StreamedResponse?> getCustomerData(String email) async {
    // checkInternetConnection(context);
    final endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/customers?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&search=$email";

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("basicAuth $basicAuth");

    final headers = {
      'content-type': 'application/json',
      'Authorization': basicAuth
    };

    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization':
    //       'Basic cmFodWxtLnRhbmlrYXRlY2hAZ21haWwuY29tOnJhaHVsMTIjJA=='
    // };

    Uri uri = Uri.parse(endpoint);

    var request = http.Request('GET', uri);

    // request.body = json
    //     .encode({"email": email, "password": password, "username": username});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("get customer STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      return response;
    } else {
      print("get customer REASON ${response.reasonPhrase}");
      return null;
    }
  }

  static Future<http.StreamedResponse?> updateCustomer(int customerId,
      Map<String, String> billingData, Map<String, String> shippingData) async {
    //checkInternetConnection(context);
    final endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/customers/$customerId?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";

    var headers = {
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse(endpoint);

    var request = http.Request('PUT', uri);

    request.body = json.encode({
      "billing": {
        "first_name": billingData["first_name"],
        "last_name": billingData["last_name"],
        "company": billingData["company"],
        "address_1": billingData["address_1"],
        "address_2": billingData["address_2"],
        "city": billingData["city"],
        "postcode": billingData["postcode"],
        "country": billingData["country"],
        "state": billingData["state"],
        "email": billingData["email"],
        "phone": billingData["phone"]
      },
      "shipping": {
        "first_name": shippingData["first_name"],
        "last_name": shippingData["last_name"],
        "company": shippingData["company"],
        "address_1": shippingData["address_1"],
        "address_2": shippingData["address_2"],
        "city": shippingData["city"],
        "postcode": shippingData["postcode"],
        "country": shippingData["country"],
        "state": shippingData["state"],
        "phone": shippingData["phone"]
      },
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      print("$response");

      return response;
    } else {
      print("REASON ${response.reasonPhrase}");
      return null;
    }
  }

  static Future<http.StreamedResponse?> updateCustomerProfile(
      int customerId, Map<String, String> updatedProfileData) async {
    print("$customerId");
    //checkInternetConnection(context);
    final endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/customers/$customerId?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";

    var headers = {
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse(endpoint);

    var request = http.Request('PUT', uri);

    request.body = json.encode({
      "email": updatedProfileData["email"],
      "first_name": updatedProfileData["first_name"],
      "last_name": updatedProfileData["last_name"],
    });

    print("${request.body}");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("updateCustomer STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      return response;
    } else {
      print("updateCustomer REASON ${response.reasonPhrase}");
      return null;
    }
  }

  static Future<http.Response> createOrder(
      Map<String, String> billingData,
      Map<String, String> shippingData,
      List<Map<String, dynamic>> line_items,
      int customerId,
      String totalPrice,
      List<Map<String, dynamic>>? meta_data) async {
    print("CUSTOMERID $customerId");
    // checkInternetConnection(context);
    const endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/orders?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";

    Uri uri = Uri.parse(endpoint);

    http.Response response;

    if (meta_data != null) {
      response = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "customer_id": customerId,
            "total": totalPrice,
            "billing": billingData,
            "shipping": billingData,
            // "date_paid": DateTime.now().toIso8601String(),
            "line_items": line_items,
            "meta_data": meta_data
          }));
    } else {
      response = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "customer_id": customerId,
            "total": totalPrice,
            "billing": billingData,
            "shipping": shippingData,
            // "date_paid": DateTime.now().toIso8601String(),
            "line_items": line_items
          }));
    }

    print("STATUS ${response.statusCode}");

    print("RECIEVE BODY ${response.body}");

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      print("JSON $json");

      return response;
    } else {
      print("REASON ${response.reasonPhrase}");
      return response;
    }
  }

  static int tempCustomerId = 0;
  static int orderPageNo = 1;

  static int orderPagesOfResponse = 1;

  static Future<bool> showNextOrderPagesProduct() async {
    orderPageNo++;
    if (orderPageNo <= orderPagesOfResponse) {
      await fetchOrders(tempCustomerId, orderPageNo);
      return true;
    }

    return false;
  }

  static List<CustomersOrder.OrderModel> listOfOrders =
      <CustomersOrder.OrderModel>[];
  //${Constants.baseUrl}/wp-json/wc/v3/orders?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9&page=1&customer_id=230999&per_page=20

  static Future<List<CustomersOrder.OrderModel>> fetchOrders(
      int customerId, int pageNo) async {
    tempCustomerId = customerId;

    print("CUSTOMERID $customerId");

    String endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/orders?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&customer=$customerId&page=$pageNo&per_page=100";

    Uri uri = Uri.parse(endpoint);

    final response = await http.get(uri);

    pagesOfResponse = int.parse(response.headers['x-wp-totalpages']!);

    if (response.statusCode == 200) {
      print(response.body);
      final body = response.body;

      final json = jsonDecode(body);

      for (int i = 0; i < json.length; i++) {
        listOfOrders.add(CustomersOrder.OrderModel(
          id: json[i]["id"],
          parentId: json[i]["parent_id"],
          status: json[i]["status"],
          currency: json[i]["currency"],
          version: json[i]["version"],
          pricesIncludeTax: json[i]["prices_include_tax"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateModified: DateTime.tryParse(json[i]["date_modified"] ?? ""),
          discountTotal: json[i]["discount_total"],
          discountTax: json[i]["discount_tax"],
          shippingTotal: json[i]["shipping_total"],
          shippingTax: json[i]["shipping_tax"],
          cartTax: json[i]["cart_tax"],
          total: json[i]["total"],
          totalTax: json[i]["total_tax"],
          customerId: json[i]["customer_id"],
          orderKey: json[i]["order_key"],
          billing: json[i]["billing"] == null
              ? null
              : CustomersOrder.Ing.fromJson(json[i]["billing"]),
          shipping: json[i]["shipping"] == null
              ? null
              : CustomersOrder.Ing.fromJson(json[i]["shipping"]),
          paymentMethod: json[i]["payment_method"],
          paymentMethodTitle: json[i]["payment_method_title"],
          transactionId: json[i]["transaction_id"],
          customerIpAddress: json[i]["customer_ip_address"],
          customerUserAgent: json[i]["customer_user_agent"],
          createdVia: json[i]["created_via"],
          customerNote: json[i]["customer_note"],
          dateCompleted: DateTime.tryParse(json[i]["date_completed"] ?? ""),
          datePaid: DateTime.tryParse(json[i]["date_paid"] ?? ""),
          cartHash: json[i]["cart_hash"],
          number: json[i]["number"],
          metaData: json[i]["meta_data"] == null
              ? []
              : List<CustomersOrder.OrderModelMetaDatum>.from(json[i]
                      ["meta_data"]!
                  .map((x) => CustomersOrder.OrderModelMetaDatum.fromJson(x))),
          lineItems: json[i]["line_items"] == null
              ? []
              : List<CustomersOrder.LineItem>.from(json[i]["line_items"]!
                  .map((x) => CustomersOrder.LineItem.fromJson(x))),
          taxLines: json[i]["tax_lines"] == null
              ? []
              : List<CustomersOrder.TaxLine>.from(json[i]["tax_lines"]!
                  .map((x) => CustomersOrder.TaxLine.fromJson(x))),
          shippingLines: json[i]["shipping_lines"] == null
              ? []
              : List<CustomersOrder.ShippingLine>.from(json[i]
                      ["shipping_lines"]!
                  .map((x) => CustomersOrder.ShippingLine.fromJson(x))),
          feeLines: json[i]["fee_lines"] == null
              ? []
              : List<dynamic>.from(json[i]["fee_lines"]!.map((x) => x)),
          couponLines: json[i]["coupon_lines"] == null
              ? []
              : List<dynamic>.from(json[i]["coupon_lines"]!.map((x) => x)),
          refunds: json[i]["refunds"] == null
              ? []
              : List<CustomersOrder.Refund>.from(json[i]["refunds"]!
                  .map((x) => CustomersOrder.Refund.fromJson(x))),
          paymentUrl: json[i]["payment_url"],
          isEditable: json[i]["is_editable"],
          needsPayment: json[i]["needs_payment"],
          needsProcessing: json[i]["needs_processing"],
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
          dateModifiedGmt:
              DateTime.tryParse(json[i]["date_modified_gmt"] ?? ""),
          dateCompletedGmt:
              DateTime.tryParse(json[i]["date_completed_gmt"] ?? ""),
          datePaidGmt: DateTime.tryParse(json[i]["date_paid_gmt"] ?? ""),
          currencySymbol: json[i]["currency_symbol"],
          links: json[i]["_links"] == null
              ? null
              : CustomersOrder.Links.fromJson(json[i]["_links"]),
        ));
      }

      print("LENGTH OF ORDER: ${listOfOrders.length}");

      return listOfOrders;
    } else {
      return [];
    }
  }

  static Future<void> cancelOrder(int orderId) async {
    String endpoint =
        "${Constants.baseUrl}/wp-json/wc/v3/orders/$orderId?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";
    Uri uri = Uri.parse(endpoint);

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };

    final body = json.encode({"status": "cancelled"});

    final response = await http.put(uri, headers: headers, body: body);

    print("cancel response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      final body = response.body;

      final json = jsonDecode(body);

      print("cancel json $json");

      // for (int i = 0; i < json.length; i++) {
      //   listOfOrders.add(CustomersOrder.OrderModel(
      //     id: json[i]["id"],
      //     parentId: json[i]["parent_id"],
      //     status: json[i]["status"],
      //     currency: json[i]["currency"],
      //     version: json[i]["version"],
      //     pricesIncludeTax: json[i]["prices_include_tax"],
      //     dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
      //     dateModified: DateTime.tryParse(json[i]["date_modified"] ?? ""),
      //     discountTotal: json[i]["discount_total"],
      //     discountTax: json[i]["discount_tax"],
      //     shippingTotal: json[i]["shipping_total"],
      //     shippingTax: json[i]["shipping_tax"],
      //     cartTax: json[i]["cart_tax"],
      //     total: json[i]["total"],
      //     totalTax: json[i]["total_tax"],
      //     customerId: json[i]["customer_id"],
      //     orderKey: json[i]["order_key"],
      //     billing: json[i]["billing"] == null
      //         ? null
      //         : CustomersOrder.Ing.fromJson(json[i]["billing"]),
      //     shipping: json[i]["shipping"] == null
      //         ? null
      //         : CustomersOrder.Ing.fromJson(json[i]["shipping"]),
      //     paymentMethod: json[i]["payment_method"],
      //     paymentMethodTitle: json[i]["payment_method_title"],
      //     transactionId: json[i]["transaction_id"],
      //     customerIpAddress: json[i]["customer_ip_address"],
      //     customerUserAgent: json[i]["customer_user_agent"],
      //     createdVia: json[i]["created_via"],
      //     customerNote: json[i]["customer_note"],
      //     dateCompleted: DateTime.tryParse(json[i]["date_completed"] ?? ""),
      //     datePaid: DateTime.tryParse(json[i]["date_paid"] ?? ""),
      //     cartHash: json[i]["cart_hash"],
      //     number: json[i]["number"],
      //     metaData: json[i]["meta_data"] == null
      //         ? []
      //         : List<CustomersOrder.OrderModelMetaDatum>.from(json[i]
      //                 ["meta_data"]!
      //             .map((x) => CustomersOrder.OrderModelMetaDatum.fromJson(x))),
      //     lineItems: json[i]["line_items"] == null
      //         ? []
      //         : List<CustomersOrder.LineItem>.from(json[i]["line_items"]!
      //             .map((x) => CustomersOrder.LineItem.fromJson(x))),
      //     taxLines: json[i]["tax_lines"] == null
      //         ? []
      //         : List<CustomersOrder.TaxLine>.from(json[i]["tax_lines"]!
      //             .map((x) => CustomersOrder.TaxLine.fromJson(x))),
      //     shippingLines: json[i]["shipping_lines"] == null
      //         ? []
      //         : List<CustomersOrder.ShippingLine>.from(json[i]
      //                 ["shipping_lines"]!
      //             .map((x) => CustomersOrder.ShippingLine.fromJson(x))),
      //     feeLines: json[i]["fee_lines"] == null
      //         ? []
      //         : List<dynamic>.from(json[i]["fee_lines"]!.map((x) => x)),
      //     couponLines: json[i]["coupon_lines"] == null
      //         ? []
      //         : List<dynamic>.from(json[i]["coupon_lines"]!.map((x) => x)),
      //     refunds: json[i]["refunds"] == null
      //         ? []
      //         : List<CustomersOrder.Refund>.from(json[i]["refunds"]!
      //             .map((x) => CustomersOrder.Refund.fromJson(x))),
      //     paymentUrl: json[i]["payment_url"],
      //     isEditable: json[i]["is_editable"],
      //     needsPayment: json[i]["needs_payment"],
      //     needsProcessing: json[i]["needs_processing"],
      //     dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
      //     dateModifiedGmt:
      //         DateTime.tryParse(json[i]["date_modified_gmt"] ?? ""),
      //     dateCompletedGmt:
      //         DateTime.tryParse(json[i]["date_completed_gmt"] ?? ""),
      //     datePaidGmt: DateTime.tryParse(json[i]["date_paid_gmt"] ?? ""),
      //     currencySymbol: json[i]["currency_symbol"],
      //     links: json[i]["_links"] == null
      //         ? null
      //         : CustomersOrder.Links.fromJson(json[i]["_links"]),
      //   ));
      // }

      // print("LENGTH OF ORDER: ${listOfOrders.length}");

      // return listOfOrders;
    } else {
      // return [];
      print("cancel response.reasonPhrase ${response.reasonPhrase}");
    }
  }

  static List<Map<String, dynamic>> woocommerce_razorpay_settings =
      <Map<String, dynamic>>[];

  static Future<void> generateBasicAuthForRazorPay() async {
    final endpoint =
        "${Constants.baseUrl}/wp-json/store/v1/settings?options=woocommerce_razorpay_settings";

    Uri uri = Uri.parse(endpoint);

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    final headers = {
      'content-type': 'application/json',
      'Authorization': basicAuth
    };

    var request = http.Request('GET', uri);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      try {
        final jsonBody = jsonDecode(body);
        print(jsonBody.runtimeType);
        woocommerce_razorpay_settings.clear();
        woocommerce_razorpay_settings.add(jsonDecode(body));

        print("JSON DECODE DATA $woocommerce_razorpay_settings");
      } catch (e) {
        print('Error decoding: $e');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<http.StreamedResponse?> createRazorpayOrder() async {
    final endpoint = "https://api.razorpay.com/v1/orders";

    Uri uri = Uri.parse(endpoint);

    print(woocommerce_razorpay_settings);

    final key_id = woocommerce_razorpay_settings[0]["data"]
        ["woocommerce_razorpay_settings"]["key_id"];
    final key_secret = woocommerce_razorpay_settings[0]["data"]
        ["woocommerce_razorpay_settings"]["key_secret"];

    print("key_id $key_id , key_secret $key_secret");

    String basicAuth =
        "Basic " + base64Encode(utf8.encode('$key_id:$key_secret'));

    print("basicAuth $basicAuth");

    final headers = {
      'content-type': 'application/json',
      'Authorization': basicAuth
    };

    var request = http.Request('POST', uri);

    request.body =
        jsonEncode({"amount": 100, "currency": "INR", "receipt": "rcptid_11"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      //print("PAYMENT ${await response.stream.bytesToString()}");
      return response;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static String cashFreeProductionUrl = "https://api.cashfree.com/pg/orders";
  static String cashFreeSandBoxUrl = "https://sandbox.cashfree.com/pg/orders";

  static String x_Client_Secret = '32b58214b2122f105cd95ceb200ab3fa3ce31cef';
  static String x_Client_Id = '25374ad9549ebbd8ac34a363647352';

  static Future<http.StreamedResponse?> createCashFreeOrder() async {
    String url = 'https://sandbox.cashfree.com/pg/orders';

    Uri uri = Uri.parse(url);

    var headers = {
      'X-Client-Secret': x_Client_Secret,
      'X-Client-Id': x_Client_Id,
      'x-api-version': '2023-08-01',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var request = http.Request('POST', uri);
    request.body = json.encode({
      "order_amount": 1.0,
      "order_currency": "INR",
      "customer_details": {
        "customer_id": "USER123",
        "customer_name": "joe",
        "customer_email": "joe.s@cashfree.com",
        "customer_phone": "+919876543210"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print("cashfree response ${await response.stream.bytesToString()}");
      return response;
    } else {
      print(" cashfree error${response.reasonPhrase}");
      return null;
    }
  }

  static List<PaymentGatewaysModel> paymentGateways = <PaymentGatewaysModel>[];
  static Future<List<PaymentGatewaysModel>?> getPaymentGateways() async {
    final endpoint = "${Constants.baseUrl}/wp-json/wc/v3/payment_gateways";
    Uri uri = Uri.parse(endpoint);
    // String userName = "tiarabytj@gmail.com";
    // String password = "October@Jwero";

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("basicAuthgetPaymentGateways $basicAuth");

    final headers = {
      'content-type': 'application/json',
      'Authorization': basicAuth
    };

    var request = http.Request('GET', uri);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      try {
        final jsonBody = jsonDecode(body);

        print("paymentbody $jsonBody");

        paymentGateways.clear();

        for (var i = 0; i < jsonBody.length; i++) {
          if (jsonBody[i]["enabled"] == true) {
            paymentGateways.add(PaymentGatewaysModel(
              id: jsonBody[i]["id"],
              title: jsonBody[i]["title"],
              description: jsonBody[i]["description"],
              order: jsonBody[i]["order"],
              enabled: jsonBody[i]["enabled"],
              methodTitle: jsonBody[i]["method_title"],
              methodDescription: jsonBody[i]["method_description"],
              methodSupports: jsonBody[i]["method_supports"] == null
                  ? []
                  : List<String>.from(
                      jsonBody[i]["method_supports"]!.map((x) => x)),
              settings: jsonBody[i]["settings"],
              needsSetup: jsonBody[i]["needs_setup"],
              postInstallScripts: jsonBody[i]["post_install_scripts"] == null
                  ? []
                  : List<dynamic>.from(
                      jsonBody[i]["post_install_scripts"]!.map((x) => x)),
              settingsUrl: jsonBody[i]["settings_url"],
              connectionUrl: jsonBody[i]["connection_url"],
              setupHelpText: jsonBody[i]["setup_help_text"],
              requiredSettingsKeys:
                  jsonBody[i]["required_settings_keys"] == null
                      ? []
                      : List<String>.from(
                          jsonBody[i]["required_settings_keys"]!.map((x) => x)),
            ));
          }
        }

        print("paymentGateways.length ${paymentGateways.length}");
        //print("paymentGateways $paymentGateways");
        return paymentGateways;
      } catch (e) {
        print(e.toString());
      }
      return null;
    }
    return null;
  }

  static Future<http.Response> createProductReview(
      Map<String, dynamic> reviewData) async {
    final url =
        "${Constants.baseUrl}/wp-json/wc/v3/products/reviews?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";

    Uri uri = Uri.parse(url);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "product_id": reviewData["product_id"],
          "review": reviewData["review"],
          "reviewer": reviewData["reviewer"],
          "reviewer_email": reviewData["reviewer_email"],
          "rating": reviewData["rating"]
        }));

    print({"REVIEW response.body ${response.body}"});

    return response;
  }

  static List<ReviewsModel> reviewsList = <ReviewsModel>[];

  static Future<List<ReviewsModel>> getReviews(String productId) async {
    final url =
        "${Constants.baseUrl}/wp-json/wc/v3/products/reviews?consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&product=$productId";

    print("current productId $productId");
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    print("REVIEW response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      print("JSON REVIEW $json");

      for (var i = 0; i < json.length; i++) {
        reviewsList.add(ReviewsModel(
          id: json[i]["id"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
          productId: json[i]["product_id"],
          productName: json[i]["product_name"],
          productPermalink: json[i]["product_permalink"],
          status: json[i]["status"],
          reviewer: json[i]["reviewer"],
          reviewerEmail: json[i]["reviewer_email"],
          review: json[i]["review"],
          rating: json[i]["rating"],
          verified: json[i]["verified"],
          reviewerAvatarUrls: Map.from(json[i]["reviewer_avatar_urls"])
              .map((k, v) => MapEntry<String, String>(k, v)),
        ));
      }
      return reviewsList;
    }

    return reviewsList;
  }

  static CustomizationOption.ProductCustomizationOptionsModel?
      productCustomizationOptionsModel;

  static Future<CustomizationOption.ProductCustomizationOptionsModel?>
      getProductCustomizeOptions() async {
    final url =
        "${Constants.baseUrl}/wp-json/store/v1/settings/Show_product_customize";

    Uri uri = Uri.parse(url);

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    final response = await http.get(uri, headers: {
      'authorization': basicAuth,
      'content-type': 'application/json',
    });

    if (response.statusCode == 200) {
      print("CUSTOM BODY ${response.body}");

      final json = jsonDecode(response.body);

      print("CUSTOM JSON $json");

      productCustomizationOptionsModel =
          CustomizationOption.ProductCustomizationOptionsModel(
        type: json["type"],
        data: json["data"] == null
            ? null
            : CustomizationOption.Data.fromJson(json["data"]),
      );

      return productCustomizationOptionsModel;
    }
    return productCustomizationOptionsModel;
  }

  static FilterOptions.FilterOptionsModel? filterOptionsModel;
  static Future<FilterOptions.FilterOptionsModel?> getFilterOptions() async {
    String url = "${Constants.baseUrl}/wp-json/store/v1/taxonomies";

    Uri uri = Uri.parse(url);
    // String userName = "tiarabytj@gmail.com";
    // String password = "October@Jwero";

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("filterOptions basicAuth $basicAuth");

    final response = await http.get(uri, headers: {
      'Authorization': basicAuth,
      //'Cookie': 'shop_per_page=100'
    });

    print("filter response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      print("filterOptions BODY ${response.body}");

      try {
        final json = jsonDecode(response.body);

        print("filterOptions JSON $json");

        filterOptionsModel = FilterOptions.FilterOptionsModel(
          collections: json["collections"] == null
              ? []
              : List<FilterOptions.Category>.from(json["collections"]!
                  .map((x) => FilterOptions.Category.fromJson(x))),
          categories: json["categories"] == null
              ? []
              : List<FilterOptions.Category>.from(json["categories"]!
                  .map((x) => FilterOptions.Category.fromJson(x))),
          subCategories: json["sub-categories"] == null
              ? []
              : List<FilterOptions.Category>.from(json["sub-categories"]!
                  .map((x) => FilterOptions.Category.fromJson(x))),
          tags: json["tags"] == null
              ? []
              : List<FilterOptions.Category>.from(
                  json["tags"]!.map((x) => FilterOptions.Category.fromJson(x))),
          diamondWt: json["diamond_wt"] == null
              ? []
              : List<FilterOptions.Category>.from(json["diamond_wt"]!
                  .map((x) => FilterOptions.Category.fromJson(x))),
          goldWt: json["gold_wt"] == null
              ? []
              : List<FilterOptions.Category>.from(json["gold_wt"]!
                  .map((x) => FilterOptions.Category.fromJson(x))),
          gender: json["gender"] == null
              ? []
              : List<FilterOptions.Category>.from(json["gender"]!
                  .map((x) => FilterOptions.Category.fromJson(x))),
        );

        print(
            "filterOptionsModel!.categories.length ${filterOptionsModel!.categories.length}");
      } catch (e) {
        print("filter json error ${e.toString()}");
      }

      return filterOptionsModel;
    }
    return null;
  }

  // static List<DigiGoldPlans.DigiGoldPlanModel> listOfFilteredDigiGoldPlan =
  //     <DigiGoldPlans.DigiGoldPlanModel>[];

  // static late DigiGoldPlans.DigiGoldPlanModel flexiPlanModel;

  static String digiGoldUrl =
      "${Constants.baseUrl}/wp-json/wc/v3/products?custom_filter[0][key]=_visibility&custom_filter[0][value]=hidden&per_page=100&consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}";

  static Future<List<DigiGoldPlans.DigiGoldPlanModel>>
      getListOfDigiGoldPlan() async {
    List<DigiGoldPlans.DigiGoldPlanModel> listOfAllDigiGoldPlan =
        <DigiGoldPlans.DigiGoldPlanModel>[];

    Uri uri = Uri.parse(digiGoldUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print("response.body listOfDigiGoldPlan ${response.body}");
      final json = jsonDecode(response.body);

      for (var i = 0; i < json.length; i++) {
        listOfAllDigiGoldPlan.add(DigiGoldPlans.DigiGoldPlanModel(
          id: json[i]["id"],
          name: json[i]["name"],
          slug: json[i]["slug"],
          permalink: json[i]["permalink"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
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
              : DigiGoldPlans.Dimensions.fromJson(json[i]["dimensions"]),
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
              ? <DigiGoldPlans.Category>[]
              : List<DigiGoldPlans.Category>.from(json[i]["categories"]!
                  .map((x) => DigiGoldPlans.Category.fromJson(x))),
          tags: json[i]["tags"] == null
              ? []
              : List<dynamic>.from(json[i]["tags"]!.map((x) => x)),
          images: json[i]["images"] == null
              ? <DigiGoldPlans.Image>[]
              : List<DigiGoldPlans.Image>.from(json[i]["images"]!
                  .map((x) => DigiGoldPlans.Image.fromJson(x))),
          attributes: json[i]["attributes"] == null
              ? <DigiGoldPlans.Attribute>[]
              : List<DigiGoldPlans.Attribute>.from(json[i]["attributes"]!
                  .map((x) => DigiGoldPlans.Attribute.fromJson(x))),
          defaultAttributes: json[i]["default_attributes"] == null
              ? []
              : List<dynamic>.from(
                  json[i]["default_attributes"]!.map((x) => x)),
          variations: json[i]["variations"] == null
              ? []
              : List<dynamic>.from(json[i]["variations"]!.map((x) => x)),
          groupedProducts: json[i]["grouped_products"] == null
              ? []
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
          menuOrder: json[i]["menu_order"],
          priceHtml: json[i]["price_html"],
          relatedIds: json[i]["related_ids"] == null
              ? []
              : List<int>.from(json[i]["related_ids"]!.map((x) => x)),
          metaData: json[i]["meta_data"] == null
              ? <DigiGoldPlans.MetaDatum>[]
              : List<DigiGoldPlans.MetaDatum>.from(json[i]["meta_data"]!
                  .map((x) => DigiGoldPlans.MetaDatum.fromJson(x))),
          stockStatus: json[i]["stock_status"],
          hasOptions: json[i]["has_options"],
          postPassword: json[i]["post_password"],
          subcategory: json[i]["subcategory"] == null
              ? []
              : List<dynamic>.from(json[i]["subcategory"]!.map((x) => x)),
          collections: json[i]["collections"] == null
              ? []
              : List<dynamic>.from(json[i]["collections"]!.map((x) => x)),
          links: json[i]["_links"] == null
              ? null
              : DigiGoldPlans.Links.fromJson(json[i]["_links"]),
        ));
      }

      return listOfAllDigiGoldPlan;
    } else {
      print("response.body listOfDigiGoldPlan null");
      return listOfAllDigiGoldPlan;
    }
  }

  static Future<http.StreamedResponse> uploadDocumentImage(
      String imagePath) async {
    final url = "${Constants.baseUrl}/wp-json/wp/v2/media";
    Uri uri = Uri.parse(url);

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("image upload basicAuth $basicAuth");

    var headers = {
      'Authorization': basicAuth,
    };

    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("upload status ${response.statusCode}");

    if (response.statusCode == 201) {
      print("upload response ${await response.stream.bytesToString()}");
    } else {
      print(response.reasonPhrase);
    }
    return response;
  }

  // static late GoldRateModel goldRateModel;

  static Future<http.Response> getGoldRate() async {
    final url = "${Constants.baseUrl}/wp-json/store/v1/settings/master_pricing";
    Uri uri = Uri.parse(url);

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("getGoldRate basicAuth $basicAuth");

    var headers = {
      'Authorization': basicAuth,
    };

    http.Response response = await http.get(uri, headers: headers);

    print("gold rate response.statusCode ${response.statusCode}");
    print("gold rate response.body ${response.body}");

    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);

    //   print("gold json $json");
    //   return GoldRateModel(
    //     type: json["type"],
    //     data: json["data"] == null ? null : Data.fromJson(json["data"]),
    //   );
    // }
    return response;
  }

  static List<Coupons.CouponsModel> listOfCoupons = <Coupons.CouponsModel>[];

  static Future<void> getCoupons() async {
    final url =
        "${Constants.baseUrl}/wp-json/wc/v3/coupons?&consumer_key=${Constants.consumerKey}&consumer_secret=${Constants.consumerSecret}&per_page=100";

    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);
    print("coupons response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      for (var i = 0; i < json.length; i++) {
        print(
            "DateExpires ${DateTime.tryParse(json[i]["date_expires"] ?? "")}");
        if (DateTime.tryParse(json[i]["date_expires"] ?? "") != null) {
          if (DateTime.now()
              .isBefore(DateTime.tryParse(json[i]["date_expires"])!)) {
            listOfCoupons.add(Coupons.CouponsModel(
              id: json[i]["id"],
              code: json[i]["code"],
              amount: json[i]["amount"],
              status: json[i]["status"],
              dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
              dateCreatedGmt:
                  DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
              dateModified: DateTime.tryParse(json[i]["date_modified"] ?? ""),
              dateModifiedGmt:
                  DateTime.tryParse(json[i]["date_modified_gmt"] ?? ""),
              discountType: json[i]["discount_type"],
              description: json[i]["description"],
              dateExpires: DateTime.tryParse(json[i]["date_expires"] ?? ""),
              dateExpiresGmt:
                  DateTime.tryParse(json[i]["date_expires_gmt"] ?? ""),
              usageCount: json[i]["usage_count"],
              individualUse: json[i]["individual_use"],
              productIds: json[i]["product_ids"] == null
                  ? []
                  : List<dynamic>.from(json[i]["product_ids"]!.map((x) => x)),
              excludedProductIds: json[i]["excluded_product_ids"] == null
                  ? []
                  : List<dynamic>.from(
                      json[i]["excluded_product_ids"]!.map((x) => x)),
              usageLimit: json[i]["usage_limit"],
              usageLimitPerUser: json[i]["usage_limit_per_user"],
              limitUsageToXItems: json[i]["limit_usage_to_x_items"],
              freeShipping: json[i]["free_shipping"],
              productCategories: json[i]["product_categories"] == null
                  ? []
                  : List<int>.from(
                      json[i]["product_categories"]!.map((x) => x)),
              excludedProductCategories: json[i]
                          ["excluded_product_categories"] ==
                      null
                  ? []
                  : List<dynamic>.from(
                      json[i]["excluded_product_categories"]!.map((x) => x)),
              excludeSaleItems: json[i]["exclude_sale_items"],
              minimumAmount: json[i]["minimum_amount"],
              maximumAmount: json[i]["maximum_amount"],
              emailRestrictions: json[i]["email_restrictions"] == null
                  ? []
                  : List<dynamic>.from(
                      json[i]["email_restrictions"]!.map((x) => x)),
              usedBy: json[i]["used_by"] == null
                  ? []
                  : List<String>.from(json[i]["used_by"]!.map((x) => x)),
              metaData: json[i]["meta_data"] == null
                  ? []
                  : List<Coupons.MetaDatum>.from(json[i]["meta_data"]!
                      .map((x) => Coupons.MetaDatum.fromJson(x))),
              links: json[i]["_links"] == null
                  ? null
                  : Coupons.Links.fromJson(json[i]["_links"]),
            ));
          }
        }
      }

      print("listOfCoupons.length ${listOfCoupons.length}");
    }
  }

  static List<BannerModel> listOfBanners = <BannerModel>[];

  static Future<void> getBanners() async {
    final url = "${Constants.baseUrl}/wp-json/wp/v2/slider";

    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);
    print("coupons response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      for (var i = 0; i < json.length; i++) {
        listOfBanners.add(BannerModel(
          id: json[i]["id"],
          date: DateTime.tryParse(json[i]["date"] ?? ""),
          dateGmt: DateTime.tryParse(json[i]["date_gmt"] ?? ""),
          guid: json[i]["guid"] == null ? null : Guid.fromJson(json[i]["guid"]),
          modified: DateTime.tryParse(json[i]["modified"] ?? ""),
          modifiedGmt: DateTime.tryParse(json[i]["modified_gmt"] ?? ""),
          slug: json[i]["slug"],
          status: json[i]["status"],
          type: json[i]["type"],
          link: json[i]["link"],
          title:
              json[i]["title"] == null ? null : Guid.fromJson(json[i]["title"]),
          content: json[i]["content"] == null
              ? null
              : Content.fromJson(json[i]["content"]),
          featuredMedia: json[i]["featured_media"],
          menuOrder: json[i]["menu_order"],
          template: json[i]["template"],
          //  meta: json[i]["meta"] == null ? null : Meta.fromJson(json[i]["meta"]),
          metadata: json[i]["metadata"] == null
              ? null
              : Metadata.fromJson(json[i]["metadata"]),
          // links: json[i]["_links"] == null ? null : Links.fromJson(json[i]["_links"]),
        ));
      }
    }
  }

  static int homeLayoutStatusCode = 0;

  static Future<LayoutModel?> getHomeLayout() async {
    final endpoint = "https://websockets.tanika.tech/frontend/mobile";

    //final endpoint = "http://192.168.1.7:8082/frontend/mobile";
    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("getHomeLayout basicAuth $basicAuth");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };

    final uri = Uri.parse(endpoint);

    try {
      final response = await http.post(uri,
          headers: headers,
          body: json.encode({"website": "${Constants.baseUrl}"}));
      print("layout body ${response.body}");

      print("layout statusCode ${response.statusCode}");

      homeLayoutStatusCode = response.statusCode;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return LayoutModel(
          success: json["success"],
          data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
      } else {
        return null;
      }
    } catch (e) {
      print("client exception layout design ${e.toString()}");
      return null;
    }
  }

  static List<AllProducts.ProductsModel> collectionList =
      <AllProducts.ProductsModel>[];

  static int collectionPageNo = 1;
  static int collectionId = 0;

  static int responseofCollectionPages = 1;
  static Future<bool> showNextPagesCollectionProduct() async {
    collectionPageNo++;
    if (collectionPageNo <= responseofCollectionPages) {
      await getCollections(
          collectionId: collectionId, pageNo: collectionPageNo);
      return true;
    }

    return false;
  }

  static Future<void> getCollections(
      {required int collectionId, required int pageNo}) async {
    final endPoint =
        "${Constants.baseUrl}/wp-json/wc/v3/products?consumer_key=${Constants.consumerKey}&cosumer_secret=${Constants.consumerSecret}&per_page=100&page=$pageNo&collections=$collectionId";

    Uri uri = Uri.parse(endPoint);

    String basicAuth = "Basic " +
        base64Encode(
            utf8.encode('${Constants.userName}:${Constants.password}'));

    print("getHomeLayout basicAuth $basicAuth");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };

    final response = await http.get(uri, headers: headers);

    responseofCollectionPages = int.parse(response.headers['x-wp-totalpages']!);

    print("Collection body ${response.body}");

    print("Collection statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      for (var i = 0; i < json.length; i++) {
        collectionList.add(AllProducts.ProductsModel(
          id: json[i]["id"],
          name: json[i]["name"],
          slug: json[i]["slug"],
          permalink: json[i]["permalink"],
          dateCreated: DateTime.tryParse(json[i]["date_created"] ?? ""),
          dateCreatedGmt: DateTime.tryParse(json[i]["date_created_gmt"] ?? ""),
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
              : List<dynamic>.from(json[i]["grouped_products"]!.map((x) => x)),
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
    }
  }
}
