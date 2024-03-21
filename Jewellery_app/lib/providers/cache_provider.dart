import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheProvider with ChangeNotifier {
  bool? _fileInfoFetching = false;
  bool? get fileInfoFetching => _fileInfoFetching;

  void setFileInfoFetching(bool? fileInfoFetching) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fileInfoFetching = fileInfoFetching;
      notifyListeners();
    });
  }

  bool? _collectionsfileInfoFetching = false;
  bool? get collectionsfileInfoFetching => _collectionsfileInfoFetching;

  void setCollectionsFileInfoFetching(bool? collectionsfileInfoFetching) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _collectionsfileInfoFetching = collectionsfileInfoFetching;
      notifyListeners();
    });
  }

  bool _isProductListEmpty = false;
  bool get isProductListEmpty => _isProductListEmpty;

  void setIsProductListEmpty(bool isProductListEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isProductListEmpty = isProductListEmpty;
      notifyListeners();
    });
  }
  // Stream<FileResponse>? _categoryFileStream;

  // Stream<FileResponse>? get categoryFileStream => _categoryFileStream;

  // void setCategoryFileStream(Stream<FileResponse>? categoryFileStream) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _categoryFileStream = categoryFileStream;
  //     notifyListeners();
  //   });
  // }

  // Stream<FileResponse>? _categoryImageFileStream;

  // Stream<FileResponse>? get categoryImageFileStream => _categoryImageFileStream;

  // void setCategoryImageFileStream(
  //     Stream<FileResponse>? categoryImageFileStream) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _categoryImageFileStream = categoryImageFileStream;
  //     notifyListeners();
  //   });
  // }
}
