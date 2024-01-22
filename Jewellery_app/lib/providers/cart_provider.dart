import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwelery_app/model/cart_product_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  //DBHelper dbHelper = DBHelper();

  List<CartProductModel> _cart = [];

  // double _totalPrice = 0.0;
  // double get totalPrice => _totalPrice;

  List<CartProductModel> get cart => _cart;

  List<int> _cartProductIds = <int>[];
  List<int> get cartProductIds => _cartProductIds;



  double calculateTotalPrice() {
    var totalPrice = 0.0;
    for (int i = 0; i < _cart.length; i++) {
      var price = double.parse(_cart[i].price ?? "20000");
      var quantity = double.parse(_cart[i].quantity ?? "1");
      totalPrice += price * quantity;
    }
    return totalPrice;
    //_totalPrice = totalPrice;
    
  }

  void addToCartId(int id) {
    _cartProductIds.add(id);
    notifyListeners();

    _setSharedPrefs();
  }

  void removeFromCartId(int id) {
    bool remove = _cartProductIds.remove(id);
    print("CART REMOVED $remove");
    notifyListeners();

    _setSharedPrefs();
  }

  void addToCart(CartProductModel cartProductModel) {
    _cart.add(cartProductModel);
    notifyListeners();

    _setSharedPrefs();
  }

  void removeFromCart(CartProductModel cartProductModel) {
    _cart.remove(cartProductModel);
    notifyListeners();

    _setSharedPrefs();
  }

  void updateQuantity(int productId, String selectedQuantity) {
    for (int i = 0; i < _cart.length; i++) {
      if (_cart[i].cartProductid == productId) {
        _cart[i].quantity = selectedQuantity;
      }
    }

    notifyListeners();

    _setSharedPrefs();
  }

  void _setSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool savingDataRes = await sharedPreferences.setString(
        "cart_list", jsonEncode(cart.map((e) => e.toMap()).toList()));
    bool savingWishlist = await sharedPreferences.setString(
        "cartid_list", jsonEncode(cartProductIds));

    print("Saved data $savingDataRes");
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? res = sharedPreferences.getString("cart_list");
    String? cardtIds = sharedPreferences.getString("cartid_list");

    print("cartid_list $cardtIds");
    if (cardtIds != null) {
      var dynamicCartProductIds = jsonDecode(cardtIds) as List<dynamic>;

      _cartProductIds = dynamicCartProductIds.whereType<int>().toList();
      print("cartid_list : $_cartProductIds");
    } else {
      print("NULL cartid_list");
    }

    print("CART LIST $res");
    if (res != null) {
      var data = jsonDecode(res);
      _cart = data
          .map<CartProductModel>((e) => CartProductModel.fromMap(e))
          .toList();
    } else {
      _cart = [];
    }

    notifyListeners();
  }
}
