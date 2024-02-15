import 'package:flutter/material.dart';

class FilterOptionsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _filterCategoryOptionsdata =
      <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterCategoryOptionsdata =>
      _filterCategoryOptionsdata;

  void setCategoryFilterOptionsdata(
      List<Map<String, dynamic>> filterCategoryOptionsdata) {
    _filterCategoryOptionsdata = filterCategoryOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterCollectionsOptionsdata =
      <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterCollectionsOptionsdata =>
      _filterCollectionsOptionsdata;

  void setCollectionsFilterOptionsdata(
      List<Map<String, dynamic>> filterCollectionsOptionsdata) {
    _filterCollectionsOptionsdata = filterCollectionsOptionsdata;
    print(
        "filterCollectionsOptionsdata length ${filterCollectionsOptionsdata.length}");
    print(
        "private filterCollectionsOptionsdata length ${_filterCollectionsOptionsdata.length}");
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterDiamondWtOptionsdata =
      <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterDiamondWtOptionsdata =>
      _filterDiamondWtOptionsdata;

  void setDiamondWtFilterOptionsdata(
      List<Map<String, dynamic>> filterDiamondWtOptionsdata) {
    _filterDiamondWtOptionsdata = filterDiamondWtOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterGoldWtOptionsdata =
      <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterGoldWtOptionsdata =>
      _filterGoldWtOptionsdata;

  void setGoldWtFilterOptionsdata(
      List<Map<String, dynamic>> filterGoldWtOptionsdata) {
    _filterGoldWtOptionsdata = filterGoldWtOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterGenderOptionsdata =
      <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterGenderOptionsdata =>
      _filterGenderOptionsdata;

  void setGenderFilterOptionsdata(
      List<Map<String, dynamic>> filterGenderOptionsdata) {
    _filterGenderOptionsdata = filterGenderOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterTagsOptionsdata = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterTagsOptionsdata =>
      _filterTagsOptionsdata;

  void setTagsFilterOptionsdata(
      List<Map<String, dynamic>> filterTagsOptionsdata) {
    _filterTagsOptionsdata = filterTagsOptionsdata;
    notifyListeners();
  }

  List<Map<String, dynamic>> _filterSubCategoriesOptionsdata =
      <Map<String, dynamic>>[];
  List<Map<String, dynamic>> get filterSubCategoriesOptionsdata =>
      _filterSubCategoriesOptionsdata;

  void setSubCategoriesFilterOptionsdata(
      List<Map<String, dynamic>> filterSubCategoriesOptionsdata) {
    _filterSubCategoriesOptionsdata = filterSubCategoriesOptionsdata;
    notifyListeners();
  }

  // "price_range": "Price",
  //   "collection": "Collections",
  //   "categories": "Categories",
  //   "sub-categories": "Sub-categories",
  //   "tags": "Tags",
  //   "diamond_wt": "Diamond weight",
  //   "gold_wt": "Gold weight",
  //   "gender":"",

  Map<String, dynamic> _selectedSubOptionsdata = <String, dynamic>{};
  Map<String, dynamic> get selectedSubOptionsdata => _selectedSubOptionsdata;

  List<Map<String, dynamic>> _list = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> get list => _list;

  void addSelectedSubOptionsdataInList(
      Map<String, dynamic> selectedSubOptionsdata) {
    _list.add(selectedSubOptionsdata);
    // _selectedSubOptionsdata.addAll(selectedSubOptionsdata);
    notifyListeners();
  }

  void setSelectedSubOptionsdata(Map<String, dynamic> selectedSubOptionsdata) {
    if (_list.length > 0) {
      for (var i = 0; i < _list.length; i++) {
        print(
            "_list[i].containsValue(selectedSubOptionsdataid ${_list[i].containsValue(selectedSubOptionsdata["id"])}");

        print(
            "_list[i].containsValue(selectedSubOptionsdataparent) ${_list[i].containsValue(selectedSubOptionsdata["parent"])}");
        if (_list[i].containsValue(selectedSubOptionsdata["id"]) &&
            _list[i].containsValue(selectedSubOptionsdata["parent"])) {
          print("list $_list");
          removeFromList(i);

          return;
        }
      }
    }

    if (selectedSubOptionsdata["parent"] == "price_range") {
      if (_list.length > 0) {
        for (var i = 0; i < _list.length; i++) {
          if (_list[i].containsValue(selectedSubOptionsdata["parent"])) {
            removeFromList(i);
          }
        }
      }
    }

    _list.add(selectedSubOptionsdata);
    // print("before $_list");
    // dynamic temp = _list;
    // temp.add(selectedSubOptionsdata);
    // _list = temp;
    // print("after $_list");
    //_selectedSubOptionsdata.addAll(selectedSubOptionsdata);
    notifyListeners();
  }

  bool _isFilteredListLoading = false;
  bool get isFilteredListLoading => _isFilteredListLoading;

  void setFilteredListLoading(bool listLoading) {
    _isFilteredListLoading = listLoading;
    print("_isFilteredListLoading $_isFilteredListLoading");
    notifyListeners();
  }

  void removeFromList(int index) {
    print("index to remove $index");

    _list.removeAt(index);

    print("_list $_list");

    notifyListeners();
  }

  void clearFilterList() {
    try {
      print("filter list ${_list.length}");
      if (_list.length > 0) {
        _list.clear();
      }

      print("filter list cleared ${_list.length}");
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
