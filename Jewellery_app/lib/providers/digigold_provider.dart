import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart';
import 'package:flutter/material.dart';

class DigiGoldProvider with ChangeNotifier {
  List<Map<String, dynamic>> _line_items = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _meta_data = <Map<String, dynamic>>[];
  int _customerId = -1;
  Map<String, dynamic> _billingData = <String, dynamic>{};

  bool _isOrderCreating = false;

  String _planPrice = "";

  String get planPrice => _planPrice;

  bool get isOrderCreating => _isOrderCreating;

  List<Map<String, dynamic>> get line_items => _line_items;
  List<Map<String, dynamic>> get meta_data => meta_data;
  int get customerId => customerId;
  Map<String, dynamic> get billingData => billingData;

  DigiGoldPlanModel? _digiGoldPlanModel;

  DigiGoldPlanModel? get digiGoldPlanModel => _digiGoldPlanModel;

  void setDigiGoldPlanModel(DigiGoldPlanModel digiGoldPlanModel) {
    _digiGoldPlanModel = digiGoldPlanModel;
  }

  void setPlanPrice(String planPrice) {
    _planPrice = planPrice;
  }

  void setIsOrderCreating(bool isOrderCreating) {
    _isOrderCreating = isOrderCreating;
  }

  void setLineItem(List<Map<String, dynamic>> line_items) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _line_items = line_items;
      notifyListeners();
    });
  }

  void setMetaData(List<Map<String, dynamic>> meta_data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _meta_data = meta_data;
      notifyListeners();
    });
  }

  void setBillingData(Map<String, dynamic> billingData) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _billingData = billingData;
      notifyListeners();
    });
  }

  void setCustomerId(int customerId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _customerId = customerId;
      notifyListeners();
    });
  }
}
