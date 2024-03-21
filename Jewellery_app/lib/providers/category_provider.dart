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

  bool? _fileInfoFetching = false;
  bool? get fileInfoFetching => _fileInfoFetching;

  void setFileInfoFetching(bool? fileInfoFetching) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fileInfoFetching = fileInfoFetching;
      notifyListeners();
    });
  }

  bool _isFilePathExist = false;
  bool get isFilePathExist => _isFilePathExist;

  void setIsFilePathExist(bool isFilePathExist) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilePathExist = isFilePathExist;
      notifyListeners();
    });
  }

  bool _isPathChecking = false;
  bool get isPathChecking => _isPathChecking;

  void setIsPathChecking(bool isFisPathCheckingilePathExist) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isPathChecking = isPathChecking;
      notifyListeners();
    });
  }
}
