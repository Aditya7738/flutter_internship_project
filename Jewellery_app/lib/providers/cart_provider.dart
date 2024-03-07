import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  //DBHelper dbHelper = DBHelper();

  List<CartProductModel> _cart = [];

  bool _isOrderCreating = false;

  bool get isOrderCreating => _isOrderCreating;

  bool _isCouponApplied = false;

  bool get isCouponApplied => _isCouponApplied;

  void setIsCouponApplied(bool isCouponApplied) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isCouponApplied = isCouponApplied;
      notifyListeners();
    });
  }

  // String _totalPriceAfterCouponApplied = "";
  // String get totalPriceAfterCouponApplied => _totalPriceAfterCouponApplied;

  // void setTotalPriceAfterCouponApplied(String totalPriceAfterCouponApplied) {
  //   _totalPriceAfterCouponApplied = totalPriceAfterCouponApplied;
  //   notifyListeners();
  // }

  Map<String, dynamic>? _selectedCouponData;

  Map<String, dynamic>? get selectedCouponData => _selectedCouponData;

  void setSelectedCouponData(Map<String, dynamic>? selectedCouponData) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    _selectedCouponData = selectedCouponData;
    notifyListeners();
    //});
  }

  void setIsOrderCreating(bool isOrderCreating) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isOrderCreating = isOrderCreating;
      notifyListeners();
    });
  }

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

  double _totalAfterCouponApplied = 0.0;
  double get totalAfterCouponApplied => _totalAfterCouponApplied;

  void setTotalAfterCouponApplied(double totalAfterCouponApplied) {
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
    _totalAfterCouponApplied = totalAfterCouponApplied;
    notifyListeners();
    //   });
  }

  void addToCartId(int id) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    _cartProductIds.add(id);
    notifyListeners();

    _setSharedPrefs();
    // });
  }

  void removeFromCartId(int id) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    bool remove = _cartProductIds.remove(id);
    print("CartProductIds");
    _cartProductIds.forEach((element) {
      print(element);
    });
    print("CART REMOVED $remove");
    notifyListeners();
    print("removeFromCartId");
    _setSharedPrefs();
    // });
  }

  CartProductModel? oldCartModel;

  void addToCart(CartProductModel cartProductModel) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    oldCartModel = cartProductModel;
    _cart.add(cartProductModel);
    notifyListeners();

    _setSharedPrefs();
    // });
  }

  void removeFromCart(CartProductModel cartProductModel, int productId) {
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
    print("CartProductModel ${cartProductModel.toMap()}");

    int modelIndex = 0;
    for (var i = 0; i < _cart.length; i++) {
      if (_cart[i].cartProductid == productId) {
        modelIndex = i;
      }
    }

    print("modelIndex $modelIndex");

    _cart.removeAt(modelIndex);

    notifyListeners();
    print("cart length ${_cart.length}");

    _setSharedPrefs();
    // });
  }

  void clearCartList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cart.clear();
      notifyListeners();

      _setSharedPrefs();
    });
  }

  void clearCartProductIds() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartProductIds.clear();
      notifyListeners();

      _setSharedPrefs();
    });
  }

  void updateQuantity(int productId, String selectedQuantity) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _cart.length; i++) {
        if (_cart[i].cartProductid == productId) {
          _cart[i].quantity = selectedQuantity;
        }
      }

      notifyListeners();

      _setSharedPrefs();
    });
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
  }
}
