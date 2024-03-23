import 'package:flutter/material.dart';

class CustomizeOptionsProvider with ChangeNotifier {
  Map<String, dynamic> _customizeOptionsdata = <String, dynamic>{};
  Map<String, dynamic> get customizeOptionsdata => _customizeOptionsdata;

  void setCustomizeOptionsdata(Map<String, dynamic> customizeOptionsdata) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _customizeOptionsdata = customizeOptionsdata;
      notifyListeners();
    });
  }

  bool _showTutorial = true;
  bool get showTutorial => _showTutorial;

  void setShowTutorial(bool showTutorial) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorial = showTutorial;
      print("_showTutorial  $_showTutorial");
      notifyListeners();
    });
  }
}
