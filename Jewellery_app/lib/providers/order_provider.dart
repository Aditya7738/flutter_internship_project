import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  Map<String, String> _billingData = <String, String>{};
  Map<String, String> _shippingData = <String, String>{};
  List<Map<String, dynamic>> _lineItems = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _metaData = <Map<String, dynamic>>[];

  int _customerId = -1;
  String _price = "";

  Map<String, String> get billingData => _billingData;
  Map<String, String> get shippingData => _shippingData;
  List<Map<String, dynamic>> get lineItems => _lineItems;
  List<Map<String, dynamic>> get metaData => _metaData;

  int get customerId => _customerId;
  String get price => _price;

  bool _isOrderCreating = false;
  bool get isOrderCreating => _isOrderCreating;

  void setBillingData(Map<String, String> billingData) {
    _billingData = billingData;
    notifyListeners();
  }

  void setShippingData(Map<String, String> shippingData) {
    _shippingData = shippingData;
    notifyListeners();
  }

  void setLineItems(List<Map<String, dynamic>> lineItems) {
    _lineItems = lineItems;
    notifyListeners();
  }

  void setCustomerId(int customerId) {
    _customerId = customerId;
    notifyListeners();
  }

  void setPrice(String price) {
    _price = price;
    notifyListeners();
  }

  void setMetaData(List<Map<String, dynamic>> meta_data) {
    _metaData = meta_data;
    notifyListeners();
  }

  void addToMetaData(List<Map<String,dynamic>> paymentData){
    _metaData.addAll(paymentData);
     notifyListeners();
  }



  void setIsOrderCreating(bool isOrderCreating) {
    _isOrderCreating = isOrderCreating;
  }
}
