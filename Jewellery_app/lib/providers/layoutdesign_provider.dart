import 'package:flutter/material.dart';

class LayoutDesignProvider with ChangeNotifier {
  String _primary = "";

  String get primary => _primary;

  String _secondary = "";
  String get secondary => _secondary;

  String _background = "";
  String get background => _background;

  void setPrimary(String primary) {
    _primary = primary;
    notifyListeners();
  }

  void setSecondary(String secondary) {
    _secondary = secondary;
    notifyListeners();
  }

  void setBackground(String background) {
    _background = background;
    notifyListeners();
  }

  String _fontFamily = "";
  String get fontFamily => _fontFamily;

  void setfontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    notifyListeners();
  }

  Widget _parentWidget = SizedBox();
  Widget get parentWidget => _parentWidget;

  void setParentWidget(Widget parentWidget) {
    _parentWidget = parentWidget;
    notifyListeners();
  }
}
