import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwelery_app/model/cart_product_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomerProvider with ChangeNotifier{
  Map<String, dynamic> _customerData = <String, dynamic>{};

  Map<String, dynamic> get customerData => _customerData;

  void setCustomerData(Map<String, dynamic> customerData){
    _customerData = customerData;
    notifyListeners();
    _setCustomerSharedPrefs();
  }

  void _setCustomerSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool savingCustomerData = await sharedPreferences.setString("customer_data", jsonEncode(customerData));
    print("Saved savingCustomerData $savingCustomerData");
  }

  Future<void> getCustomerSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? customerDataString =  sharedPreferences.getString("customer_data");

    if(customerDataString != null){
      try {
        _customerData = jsonDecode(customerDataString);
      } catch (e) {
        print("Error customer decoding ${e.toString()}");
      }
      
      
    }else{
      _customerData = <String, dynamic>{};
    }

    notifyListeners();

  }




}