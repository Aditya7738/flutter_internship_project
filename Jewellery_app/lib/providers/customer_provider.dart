import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CustomerProvider with ChangeNotifier {
  List<Map<String, dynamic>> _customerData = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> get customerData => _customerData;

  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;

  void setIsUserLoggedIn(bool isUserLoggedIn) {
    _isUserLoggedIn = isUserLoggedIn;
    notifyListeners();
  }

  // void setCustomerData(List<Map<String, dynamic>> customerData) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _customerData = customerData;
  //     notifyListeners();
  //     _setCustomerSharedPrefs();
  //   });
  // }

  void addCustomerData(Map<String, dynamic> customerData) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // customerData.forEach((key, value) {
    //   _customerData[0][key] = value;
    // });

    _customerData.add(customerData);

    notifyListeners();
    _setCustomerSharedPrefs();
    //});
  }

  void addToFirst(List<Map<String, dynamic>> customerData) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // customerData.forEach((key, value) {
    //   _customerData[0][key] = value;
    // });

    print(
        "customerData[0].containsKey mobile_no ${customerData[0].containsKey("mobile_no")}");

    print(
        "customerProvider.customerData[0].containsKey fulladdress ${customerData[0].containsKey("fulladdress")}");

    print(
        "customerProvider.customerData[0].containsKey pincode ${customerData[0].containsKey("pincode")}");

    customerData.forEach((element) {
      _customerData[0].addAll(element);
    });

    // _customerData.add(customerData);

    notifyListeners();
    _setCustomerSharedPrefs();
    //});
  }

  void addMapToFirst(Map<String, dynamic> updatedData) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // customerData.forEach((key, value) {
    //   _customerData[0][key] = value;
    // });

    print(
        "customerData[0].containsKey mobile_no ${customerData[0].containsKey("mobile_no")}");

    print(
        "customerProvider.customerData[0].containsKey fulladdress ${customerData[0].containsKey("fulladdress")}");

    print(
        "customerProvider.customerData[0].containsKey pincode ${customerData[0].containsKey("pincode")}");

    _customerData[0].addAll(updatedData);

    // _customerData.add(customerData);

    notifyListeners();
    _setCustomerSharedPrefs();
    //});
  }

  void addMapToBilling(Map<String, String> billingData) {
    _customerData[0]["billing"] = billingData;
    notifyListeners();
    _setCustomerSharedPrefs();
  }

  void _setCustomerSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool savingCustomerData = await sharedPreferences.setString(
        "customer_data", jsonEncode(customerData));
    print("SET CUSTOMERDATA ${_customerData.length}");
    print("Saved savingCustomerData $savingCustomerData");
  }

  //String? customerDataString;

  Future<bool> getCustomerSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isThereCustomerData = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? customerDataString = sharedPreferences.getString("customer_data");

      if (customerDataString != null) {
        try {
          _customerData =
              List<Map<String, dynamic>>.from(jsonDecode(customerDataString));
          //print(_customerData.runtimeType);
          // _customerData = list as List<Map<String, dynamic>>;
          print("CUSTOMERDATA ${_customerData[0]}");
          print("CUSTOMERDATA ${_customerData.length}");
          isThereCustomerData = true;
        } catch (e) {
          print("Error customer decoding ${e.toString()}");
        }
      } else {
        _customerData = <Map<String, dynamic>>[];
      }

      print("customerDataString $customerDataString");

      notifyListeners();
    });
    return false;
  }

  Future<void> removeSharePreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool removed = await sharedPreferences.remove("customer_data");

      print("isCustomerSharedpreference removed $removed");
    });
  }
}
