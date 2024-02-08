import 'package:flutter/material.dart';

class FilterOptionsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _filterCategoryOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterCategoryOptionsdata => _filterCategoryOptionsdata;

  void setCategoryFilterOptionsdata(List<Map<String, dynamic>> filteCategoryrOptionsdata) {
    _filterCategoryOptionsdata = filterCategoryOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterCollectionsOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterCollectionsOptionsdata => _filterCollectionsOptionsdata;

  void setCollectionsFilterOptionsdata(List<Map<String, dynamic>> filteCollectionsrOptionsdata) {
    _filterCollectionsOptionsdata = filterCollectionsOptionsdata;
    notifyListeners();
  }

    List<Map<String, dynamic>> _filterDiamondWtOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterDiamondWtOptionsdata => _filterDiamondWtOptionsdata;

  void setDiamondWtFilterOptionsdata(List<Map<String, dynamic>> filteDiamondWtrOptionsdata) {
    _filterDiamondWtOptionsdata = filterDiamondWtOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterGoldWtOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterGoldWtOptionsdata => _filterGoldWtOptionsdata;

  void setGoldWtFilterOptionsdata(List<Map<String, dynamic>> filteGoldWtrOptionsdata) {
    _filterGoldWtOptionsdata = filterGoldWtOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterGenderOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterGenderOptionsdata => _filterGenderOptionsdata;

  void setGenderFilterOptionsdata(List<Map<String, dynamic>> filteGenderrOptionsdata) {
    _filterGenderOptionsdata = filterGenderOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterTagsOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterTagsOptionsdata => _filterTagsOptionsdata;

  void setTagsFilterOptionsdata(List<Map<String, dynamic>> filteTagsOptionsdata) {
    _filterTagsOptionsdata = filterTagsOptionsdata;
    notifyListeners();
  }

  
}
