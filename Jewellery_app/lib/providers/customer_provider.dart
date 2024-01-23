import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CustomerProvider with ChangeNotifier {
  List<Map<String, dynamic>> _customerData = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> get customerData => _customerData;

  void setCustomerData(List<Map<String, dynamic>> customerData) {
    _customerData = customerData;
    notifyListeners();
    _setCustomerSharedPrefs();
  }

  void _setCustomerSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool savingCustomerData = await sharedPreferences.setString(
        "customer_data", jsonEncode(customerData));
    print("Saved savingCustomerData $savingCustomerData");
  }

  //String? customerDataString;

  Future<void> getCustomerSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? customerDataString = sharedPreferences.getString("customer_data");

    if (customerDataString != null) {
      try {
        _customerData = List<Map<String, dynamic>>.from(jsonDecode(customerDataString));
        print(_customerData.runtimeType);
       // _customerData = list as List<Map<String, dynamic>>;
       // print("CUSTOMERDATA ${_customerData.runtimeType}");
        

      } catch (e) {
        print("Error customer decoding ${e.toString()}");
      }
    } else {
      _customerData = <Map<String, dynamic>>[];
      
    }

    print("customerDataString $customerDataString");

    notifyListeners();
  }
}
