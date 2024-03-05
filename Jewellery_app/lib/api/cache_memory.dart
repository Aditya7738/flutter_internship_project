import 'dart:convert';

import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class CacheMemory {
  static List<CategoriesModel> listOfCategory = [];

  static Future<void> getFile(AsyncSnapshot<Object?> snapshot) async {
    Object? data = snapshot.data;
    String result = "";
    print("data is FileInfo category ${data is FileInfo}");
    if (data is FileInfo) {
      FileInfo fileInfo = data;
      result = await fileInfo.file.readAsString();
    }

    final json = jsonDecode(http.Response(result, 200).body);
    print("getFile json $json");
    listOfCategory.clear();
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
