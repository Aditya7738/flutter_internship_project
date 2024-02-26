import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  bool _isCategoryProductFetching = false;
  bool get isCategoryProductFetching => _isCategoryProductFetching;

  bool _isProductListEmpty = false;
  bool get isProductListEmpty => _isProductListEmpty;

  String _searchText = "";
  String get searchText => _searchText;

  void setSearchText(String searchText) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
    _searchText = searchText;
    notifyListeners();
     });
  }

  void setIsProductListEmpty(bool isProductListEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isProductListEmpty = isProductListEmpty;
      notifyListeners();
    });
  }

  void setIsCategoryProductFetching(bool isCategoryProductFetching) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isCategoryProductFetching = isCategoryProductFetching;
      notifyListeners();
    });
  }
}
