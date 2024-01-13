import 'dart:convert';
import 'dart:ffi';

import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwelery_app/model/products_model.dart' as AllProducts;
import 'package:jwelery_app/model/products_of_category.dart'
    as ProductsRelatedToCategory;

class ApiService {
  static Future<List<CategoriesModel>> fetchCategories() async {
    List<CategoriesModel> listOfCategory = [];
    //https://tiarabytj.com/wp-json/wc/v3/products/categories?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9
    String categoryUri =
        "${Strings.baseUrl}/wp-json/wc/v3/products/categories?consumer_key=${Strings.consumerKey}&consumer_secret=${Strings.consumerSecret}";
    Uri uri = Uri.parse(categoryUri);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response);

      final body = response.body;
      final json = jsonDecode(body);
      print(json);

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

      return listOfCategory;
    } else {
      return [];
    }
  }

  static Future<List<ProductsRelatedToCategory.ProductOfCategoryModel>>
      fetchProductsCategoryWise({required int? id}) async {
    List<ProductsRelatedToCategory.ProductOfCategoryModel>
        listOfProductsCategoryWise = [];
    //https://tiarabytj.com/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9&category=230
    String categoryUri =
        "${Strings.baseUrl}/wp-json/wc/v3/products?consumer_key=${Strings.consumerKey}&consumer_secret=${Strings.consumerSecret}&category=$id";
    Uri uri = Uri.parse(categoryUri);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response);

      final body = response.body;
      final json = jsonDecode(body);
      print(json);

      for (int i = 0; i < json.length; i++) {
        listOfProductsCategoryWise
            .add(ProductsRelatedToCategory.ProductOfCategoryModel(
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
          dimensions: json[i]["dimensions"] == null
              ? null
              : ProductsRelatedToCategory.Dimensions.fromJson(
                  json[i]["dimensions"]),
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
              ? <ProductsRelatedToCategory.Category>[]
              : List<ProductsRelatedToCategory.Category>.from(json[i]
                      ["categories"]!
                  .map((x) => ProductsRelatedToCategory.Category.fromJson(x))),
          tags: json[i]["tags"] == null
              ? <ProductsRelatedToCategory.Category>[]
              : List<ProductsRelatedToCategory.Category>.from(json[i]["tags"]!
                  .map((x) => ProductsRelatedToCategory.Category.fromJson(x))),
          images: json[i]["images"] == null
              ? <ProductsRelatedToCategory.CategoryWiseProductImage>[]
              : List<ProductsRelatedToCategory.CategoryWiseProductImage>.from(
                  json[i]["images"]!.map((x) => ProductsRelatedToCategory
                      .CategoryWiseProductImage.fromJson(x))),
          attributes: json[i]["attributes"] == null
              ? <ProductsRelatedToCategory.Attribute>[]
              : List<ProductsRelatedToCategory.Attribute>.from(json[i]
                      ["attributes"]!
                  .map((x) => ProductsRelatedToCategory.Attribute.fromJson(x))),
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
          metaData: json[i]["meta_data"] == null
              ? <ProductsRelatedToCategory.MetaDatum>[]
              : List<ProductsRelatedToCategory.MetaDatum>.from(json[i]
                      ["meta_data"]!
                  .map((x) => ProductsRelatedToCategory.MetaDatum.fromJson(x))),
          stockStatus: json[i]['stock_status'],
          hasOptions: json[i]['has_options'],
          postPassword: json[i]['post_password'],
          subcategory: json[i]["subcategory"] == null
              ? <ProductsRelatedToCategory.SubcategoryElement>[]
              : List<ProductsRelatedToCategory.SubcategoryElement>.from(
                  json[i]["subcategory"]!.map((x) =>
                      ProductsRelatedToCategory.SubcategoryElement.fromJson(
                          x))),
          collections: json[i]["collections"] == null
              ? <ProductsRelatedToCategory.SubcategoryElement>[]
              : List<ProductsRelatedToCategory.SubcategoryElement>.from(
                  json[i]["collections"]!.map((x) =>
                      ProductsRelatedToCategory.SubcategoryElement.fromJson(
                          x))),
          links: json[i]["_links"] == null
              ? null
              : ProductsRelatedToCategory.ProductLinks.fromJson(
                  json[i]["_links"]),
        ));
      }

      return listOfProductsCategoryWise;
    } else {
      return [];
    }
  }

  AllProducts.ProductsModel searchedProduct = AllProducts.ProductsModel(
      id: null,
      name: null,
      slug: null,
      permalink: null,
      dateCreated: null,
      dateCreatedGmt: null,
      dateModified: null,
      dateModifiedGmt: null,
      type: null,
      status: null,
      featured: null,
      catalogVisibility: null,
      description: null,
      shortDescription: null,
      sku: null,
      price: null,
      regularPrice: null,
      salePrice: null,
      dateOnSaleFrom: null,
      dateOnSaleFromGmt: null,
      dateOnSaleTo: null,
      dateOnSaleToGmt: null,
      onSale: null,
      purchasable: null,
      totalSales: null,
      virtual: null,
      downloadable: null,
      downloads: <dynamic>[],
      downloadLimit: null,
      downloadExpiry: null,
      externalUrl: null,
      buttonText: null,
      taxStatus: null,
      taxClass: null,
      manageStock: null,
      stockQuantity: null,
      backorders: null,
      backordersAllowed: null,
      backordered: null,
      lowStockAmount: null,
      soldIndividually: null,
      weight: null,
      dimensions: null,
      shippingRequired: null,
      shippingTaxable: null,
      shippingClass: null,
      shippingClassId: null,
      reviewsAllowed: null,
      averageRating: null,
      ratingCount: null,
      upsellIds: <dynamic>[],
      crossSellIds: <dynamic>[],
      parentId: null,
      purchaseNote: null,
      categories: <AllProducts.Category>[],
      tags: <AllProducts.Category>[],
      images: <AllProducts.ProductImage>[],
      attributes: <AllProducts.Attribute>[],
      defaultAttributes: <dynamic>[],
      variations: <dynamic>[],
      groupedProducts: <dynamic>[],
      menuOrder: null,
      priceHtml: null,
      relatedIds: <int>[],
      metaData: <AllProducts.MetaDatum>[],
      stockStatus: null,
      hasOptions: null,
      postPassword: null,
      subcategory: <dynamic>[],
      collections: <AllProducts.ProductsModelCollection>[],
      links: null);

  static List<AllProducts.ProductsModel> listOfProductsModel =
      <AllProducts.ProductsModel>[];
  static List<AllProducts.ProductsModel> listOfSearchProductsModel =
      <AllProducts.ProductsModel>[];

  static int pageNo = 1;
  static late String searchString;

  String temp = "";

  static int pagesOfResponse = 1;
  static Future<bool> showNextPagesProduct() async {

    pageNo++;
    if (pageNo <= pagesOfResponse) {
      
      await fetchProducts(searchString, pageNo);
      return true;
    }

    return false;
  

  }

  static Future<List<AllProducts.ProductsModel>?> fetchProducts(
      String searchText, int pageNo) async {
    searchString = searchText;
    
    //https: //tiarabytj.com/wp-json/wc/v3/products?consumer_key=ck_33882e17eeaff38b20ac7c781156024bc2d6af4a&consumer_secret=cs_df67b056d05606c05275b571ab39fa508fcdd7b9
    final endpoint =
        "${Strings.baseUrl}/wp-json/wc/v3/products?consumer_key=${Strings.consumerKey}&consumer_secret=${Strings.consumerSecret}&per_page=13&search=$searchText&page=$pageNo";

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
      return [];
    }
  }

  // static String searchText = "";
  // static void searchProduct(String value) {
  //   searchText = value;

  //   updateSearchList();

  // }

  // static void updateSearchList() {
  //   if (searchText.isEmpty) {
  //     listOfSearchProductsModel.addAll(listOfProductsModel);
  //   } else {
  //     listOfSearchProductsModel.addAll(listOfProductsModel
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchText.toLowerCase()))
  //         .toList());
  //   }
  // }
}

class CartOperation {
  static List<AllProducts.ProductsModel> listOfProductsAddedToCart =
      <AllProducts.ProductsModel>[];

  static void addProductToCart(int id) {
    listOfProductsAddedToCart.addAll(ApiService.listOfProductsModel
        .where((element) => element.id == id)
        .toList());
  }

  static void removeProductFromCart(int id) {
    listOfProductsAddedToCart.remove(ApiService.listOfProductsModel
        .where((element) => element.id == id)
        .toList());
  }
}