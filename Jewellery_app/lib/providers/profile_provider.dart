import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier{

  String? _nameError = "";
  String? get nameError => _nameError;

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;
  
  bool _phoneNoVerified = false;
  bool get phoneNoVerified => _phoneNoVerified;

  setNameError(String? error){
    _nameError = error;
    notifyListeners();
  }

  setEmailVerified(bool isVerified){
    _emailVerified = isVerified;
    notifyListeners();
  }

  setPhoneNoVerified(bool isVerified){
    _phoneNoVerified = isVerified;
    notifyListeners();
  }

  void getProfileSharedPrefs() {}
}

