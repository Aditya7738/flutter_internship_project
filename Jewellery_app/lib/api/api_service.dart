import 'dart:convert';

import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwelery_app/model/products_of_category.dart';

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

      for(int i =0; i < json.length; i++){
        listOfCategory.add(CategoriesModel(id: json[i]['id'],
          name: json[i]['name'],
          slug: json[i]['slug'],
          parent: json[i]['parent'],
          description: json[i]['description'],
          display: json[i]['display'],
          image: json[i]["image"] == null ? null : CategoryImageModel.fromJson(json[i]["image"]),
          menuOrder: json[i]['menuOrder'],
          count: json[i]['count'],
          links: json[i]['links']));
      }
      
      return listOfCategory;
    }else{
      return [];
    }
  }

  static Future<List<ProductOfCategoryModel>> fetchProductsCategoryWise({required int id}) async {

    List<ProductOfCategoryModel> listOfProductsCategoryWise = [];
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

      for(int i =0; i < json.length; i++){
        listOfProductsCategoryWise.add(ProductOfCategoryModel(
    id: json[i]
    name:json[i]
    slug:json[i]
    permalink:json[i]
    dateCreated:json[i]
    dateCreatedGmt:json[i]
    dateModified:json[i]
    dateModifiedGmt:json[i]
    type:json[i]
    status:json[i]
    featured:json[i]
    catalogVisibility:json[i]
    description:json[i]
    shortDescription:json[i]
    sku:json[i]
    price:json[i]
    regularPrice:json[i]
    salePrice:json[i]
    dateOnSaleFrom:json[i]
    dateOnSaleFromGmt:json[i]
    dateOnSaleTo:json[i]
    dateOnSaleToGmt:json[i]
    onSale:json[i]
    purchasable:json[i]
    totalSales:json[i]
    virtual:json[i]
    downloadable:json[i]
    downloads:json[i]
    downloadLimit:json[i]
    downloadExpiry:json[i]
    externalUrl:json[i]
    buttonText:json[i]
    taxStatus:json[i]
    taxClass:json[i]
    manageStock:json[i]
    stockQuantity:json[i]
    backorders:json[i]
    backordersAllowed:json[i]
    backordered:json[i]
    lowStockAmount:json[i]
    soldIndividually:json[i]
    weight:json[i]
    dimensions:json[i]
    shippingRequired:json[i]
    shippingTaxable:json[i]
    shippingClass:json[i]
    shippingClassId:json[i]
    reviewsAllowed:json[i]
    averageRating:json[i]
    ratingCount:json[i]
    upsellIds:json[i]
    crossSellIds:json[i]
    parentId:json[i]
    purchaseNote:json[i]
    categories:json[i]
     tags:json[i]
    images:json[i]
    attributes:json[i]
    defaultAttributes:json[i]
    variations:json[i]
    groupedProducts:json[i]
    menuOrder:json[i]
    priceHtml:json[i]
    relatedIds:json[i]
    metaData:json[i]
    stockStatus:json[i]
    hasOptions:json[i]
    postPassword:json[i]
    subcategory:json[i]
    collections:json[i]
    links:json[i]));


          id: json[i]['id'],
          name: json[i]['name'],
          slug: json[i]['slug'],
          parent: json[i]['parent'],
          description: json[i]['description'],
          display: json[i]['display'],
          image: json[i]["image"] == null ? null : CategoryImageModel.fromJson(json[i]["image"]),
          menuOrder: json[i]['menuOrder'],
          count: json[i]['count'],
          links: json[i]['links']));
      }
      
      return listOfProductsCategoryWise;
    }else{
      return [];
    }
  }
}
