import 'package:Tiara_by_TJ/model/layout_model.dart' as LayoutModel;

import 'package:flutter/material.dart';

class LayoutDesignProvider with ChangeNotifier {
  Map<String, dynamic> defaultLayoutDesign = {
    "theme": {
      "colors": {
        "primary": "#CC868A",
        "secondary": "#33FF57",
        "background": "#FFFFFF",
      },
      "fontFamily": "Roboto",
    },
    "pages": [
      {
        "name": "HomePage",
        "layout": "column",
        "children": [
          {
            "type": "image_slider",
            "layout": {
              "item_per_row": 1,
            },
          },
          {
            "type": "header",
            "text": "Tiarabytj",
            "style": {
              "color": "#333333",
              "fontSize": 24,
            },
            "layout": {},
          },
          {
            "type": "categories",
            "layout": {
              "direction": "horizontal",
              "item_per_row": 1,
            },
          },
          {
            "type": "collections",
            "meta": {
              "label": "Diamond Collection",
              "id": 12,
            },
            "layout": {
              "direction": "horizontal",
              "item_per_row": 1,
            },
          },
        ],
      },
    ],
    "placeholders": {
      "product_image":
          "https://i0.wp.com/mikeyarce.com/wp-content/uploads/2021/09/woocommerce-placeholder.png"
    }
  };
  String _primary = "";

  String get primary => _primary;

  String _secondary = "";
  String get secondary => _secondary;

  String _background = "";
  String get background => _background;

  LayoutModel.LayoutModel? _layoutModel;

  LayoutModel.LayoutModel? get layoutModel => _layoutModel;

  void setLayoutModel(LayoutModel.LayoutModel layoutModel) {
    _layoutModel = layoutModel;
    notifyListeners();
  }

  void setPrimary(String primary) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _primary = primary;
      notifyListeners();
    });
  }

  void setSecondary(String secondary) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _secondary = secondary;
      notifyListeners();
    });
  }

  void setBackground(String background) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _background = background;
      notifyListeners();
    });
  }

  String _placeHolder = "";
  String get placeHolder => _placeHolder;

  void setPlaceHolder(String placeHolder) {
    _placeHolder = placeHolder;
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
