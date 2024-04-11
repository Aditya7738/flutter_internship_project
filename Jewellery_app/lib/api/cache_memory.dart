import 'dart:convert';

import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlans;
import 'package:Tiara_by_TJ/model/products_model.dart' as AllProducts;
import 'package:Tiara_by_TJ/model/products_of_category.dart'
    as ProductsRelatedToCategory;
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class CacheMemory {
  static List<CategoriesModel> listOfCategory = [];

  static Future<void> getCategoryFile(
      AsyncSnapshot<Object?> snapshot, List<int> nonEmptyCategoryIds) async {
    Object? data = snapshot.data;
    String result = "";
    print("data is FileInfo category ${data is FileInfo}");
    if (data is FileInfo) {
      FileInfo fileInfo = data;
      if (await fileInfo.file.exists()) {
        result = await fileInfo.file.readAsString();
      }
    }

    if (result.isNotEmpty) {
      final json = jsonDecode(http.Response(result, 200).body);
      print("getFile json $json");
      listOfCategory.clear();
      for (int i = 0; i < json.length; i++) {
        if (nonEmptyCategoryIds.contains(json[i]['id'])) {
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
      }

      print("listOfCategory length ${listOfCategory.length}");
    } else {
      print("Result is empty or incomplete.");
    }
  }

  static List<AllProducts.ProductsModel> listOfProducts = [];

  static Future<void> getProductsFile(AsyncSnapshot<Object?> snapshot) async {
    Object? data = snapshot.data;
    String result = "";
    print("data is FileInfo Product ${data is FileInfo}");
    if (data is FileInfo) {
      FileInfo fileInfo = data;
      result = await fileInfo.file.readAsString();
    }

    if (result.isNotEmpty) {
      final json = jsonDecode(http.Response(result, 200).body);
      print("getFile json $json");
      // listOfProducts.clear();
      print("listOfProducts length ${listOfProducts.length}");
      for (int i = 0; i < json.length; i++) {
        listOfProducts.add(AllProducts.ProductsModel(
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
              ? <AllProducts.ProductImage>[]
              : List<AllProducts.ProductImage>.from(json[i]["images"]!
                  .map((x) => AllProducts.ProductImage.fromJson(x))),
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

      print("listOfProducts length ${listOfProducts.length}");
    } else {
      print("Result is empty or incomplete.");
    }
  }

  static List<AllProducts.ProductsModel> listOfCollections = [];

  static Future<void> getCollectionsFile(
      AsyncSnapshot<Object?> snapshot) async {
    Object? data = snapshot.data;
    String result = "";
    print("data is FileInfo Collection ${data is FileInfo}");
    if (data is FileInfo) {
      FileInfo fileInfo = data;
      result = await fileInfo.file.readAsString();
    }

    print("Collection result $result");

    print("result.isNotEmpty ${result.isNotEmpty}");

    if (result.isNotEmpty) {
      String basicAuth = "Basic " +
          base64Encode(
              utf8.encode('${Constants.userName}:${Constants.password}'));

      print("collections basicAuth $basicAuth");

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': basicAuth
      };

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

      print("listOfCollections length ${listOfCollections.length}");
    } else {
      print("Result is empty or incomplete.");
    }
  }

  static List<DigiGoldPlans.DigiGoldPlanModel> listOfDigiGoldPlans = [];

  static Future<void> getDigiGoldFile(AsyncSnapshot<Object?> snapshot) async {
    Object? data = snapshot.data;
    String result = "";
    print("data is FileInfo DigiGold ${data is FileInfo}");
    if (data is FileInfo) {
      FileInfo fileInfo = data;
      result = await fileInfo.file.readAsString();
    }

    if (result.isNotEmpty) {
      final json = jsonDecode(http.Response(result, 200).body);
      print("getFileDigiGold json $json");
      listOfDigiGoldPlans.clear();
      for (int i = 0; i < json.length; i++) {
        listOfDigiGoldPlans.add(DigiGoldPlans.DigiGoldPlanModel(
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

      print("DigiGoldPlans length ${listOfDigiGoldPlans.length}");
    } else {
      print("Result is empty or incomplete.");
    }
  }

  // static Future<void> getCategoryImage(AsyncSnapshot<Object?> snapshot) async {
  //   FileInfo fileInfo = snapshot.requireData as FileInfo;

  //   String path = fileInfo.file.path;
  //   String result = String.fromCharCodes(bytes);

  //   print("image result $result");

  //   final body = http.Response(result, 200).body;

  //   print("image body $body");

  //   final json = jsonDecode(body);
  //   print("getImageFile json $json");
  // }
}
