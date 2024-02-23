import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistProvider with ChangeNotifier {
  // List<WishlistProductModel> _wishlist = [];
  // List<WishlistProductModel> get wishlist => _wishlist;

  List<int> _favProductIds = <int>[];
  List<int> get favProductIds => _favProductIds;

  List<ProductsModel> _wishlistProducts = <ProductsModel>[];
  List<ProductsModel> get wishlistProducts => _wishlistProducts;

  bool listLoading = false;

  setWishlistProducts(List<ProductsModel> wishedProductList) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wishlistProducts = wishedProductList;
      notifyListeners();
    });
  }

  // void addToWishlist(ProductOfCategoryModel productOfCategoryModel) {
  //   WishlistProductModel wishlistProductModel = WishlistProductModel(
  //       productName: productOfCategoryModel.name ?? "Jewellery",
  //       productPrice: productOfCategoryModel.regularPrice ?? "20,000",
  //       imageUrl: productOfCategoryModel.images.isEmpty
  //           ? Strings.defaultImageUrl
  //           : productOfCategoryModel.images[0].src ?? Strings.defaultImageUrl);

  //   _wishlist.add(wishlistProductModel);

  //   notifyListeners();

  //   _setWishListSharedPrefs();
  // }

  void addToWishlist(int productId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favProductIds.add(productId);
      notifyListeners();

      _setWishListSharedPrefs();
    });
  }

  void removeFromWishlist(int productId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favProductIds.remove(productId);
      notifyListeners();

      print("start removeFromWishlist");
      _setWishListSharedPrefs();
      print("end removeFromWishlist");
    });
  }

  void addToLocalWishlist(ProductsModel productsModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wishlistProducts.add(productsModel);
      notifyListeners();

      _setWishListSharedPrefs();
    });
  }

  void removeFromLocalWishlist(int id) {
    //  _wishlistProducts.remove(productsModel);

    //bool isRevomed= listOfWish.remove(productsModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _wishlistProducts.length; i++) {
        if (_wishlistProducts[i].id == id) {
          _wishlistProducts.removeAt(i);
        }
      }
      // print("isRevomed $isRevomed");

      //  _wishlistProducts = listOfWish;

      // setWishlistProducts(_wishlistProducts);
      notifyListeners();

      print("start removeFromLocalWishlist");
    });
  }

  // void removeFromWishlist(ProductOfCategoryModel productOfCategoryModel) {
  //   WishlistProductModel wishlistProductModel = WishlistProductModel(
  //       productName: productOfCategoryModel.name ?? "Jewellery",
  //       productPrice: productOfCategoryModel.regularPrice ?? "20,000",
  //       imageUrl: productOfCategoryModel.images.isEmpty
  //           ? Strings.defaultImageUrl
  //           : productOfCategoryModel.images[0].src ?? Strings.defaultImageUrl);
  //   _wishlist.remove(wishlistProductModel);
  //   notifyListeners();

  //   _setWishListSharedPrefs();
  // }

  void _setWishListSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool savingWishlist = await sharedPreferences.setString(
        "wish_list", jsonEncode(favProductIds));
    print("Saved wishlist $savingWishlist");
  }

  Future<void> getWishListSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? wishlist = sharedPreferences.getString("wish_list");

      print("WISHLIST LIST $wishlist");
      if (wishlist != null) {
        var dynamicfavProductIds = jsonDecode(wishlist) as List<dynamic>;

        _favProductIds = dynamicfavProductIds.whereType<int>().toList();
        print("FAV IDS : $_favProductIds");
      } else {
        print("NULL WISHLIST");
      }

      notifyListeners();
    });
  }
}
