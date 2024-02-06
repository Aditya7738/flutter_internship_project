import 'package:flutter/material.dart';

class CustomizeOptionsProvider with ChangeNotifier {
  Map<String, dynamic> _customizeOptionsdata = <String, dynamic>{};
  Map<String, dynamic> get customizeOptionsdata => _customizeOptionsdata;

  void setCustomizeOptionsdata(Map<String, dynamic> customizeOptionsdata) {
    _customizeOptionsdata = customizeOptionsdata;
    notifyListeners();
  }
}
