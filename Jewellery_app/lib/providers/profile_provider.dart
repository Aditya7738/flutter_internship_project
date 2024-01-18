import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier{

  String? _nameError = "";
  String? get nameError => _nameError;

  setNameError(String? error){
    _nameError = error;
    notifyListeners();
  }

  void getProfileSharedPrefs() {}
}

