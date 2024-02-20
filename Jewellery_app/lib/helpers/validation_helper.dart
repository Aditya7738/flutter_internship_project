class ValidationHelper {
  static String? nullOrEmptyString(String? input) {
    if (input == null || input == "") {
      return "Input field is empty";
    }
    return null;
  }

  static String? isFullAddress(String? input) {
    if (nullOrEmptyString(input) == null) {
      if (input!.length <= 10) {
        return "Please enter full address";
      }
      return null;
    }
    return null;
  }

  static String? isPhoneNoValid(String? input) {
    if (nullOrEmptyString(input) == null) {
      if (input!.length != 10) {
        return "Phone no is not valid";
      }

      return null;
    }

    return nullOrEmptyString(input);
  }

  static String? isEmailValid(String? input) {
    if (nullOrEmptyString(input) == null) {
      String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(input!)) {
        return "Email is not valid";
      }
      //return null;
    }

    return nullOrEmptyString(input);
  }

  static String? isPincodeValid(String? input) {
    if (nullOrEmptyString(input) == null) {
      if (input!.length != 6) {
        return "Pincode is not valid";
      }
    }
    return nullOrEmptyString(input);
  }

  static String? isPassAndConfirmPassSame(String pass, String confirmPass) {
    // if (isPasswordContain(pass) == null &&
    //     isPasswordContain(confirmPass) == null) {
    if (nullOrEmptyString(confirmPass) == null) {
      if (pass != confirmPass) {
        return "Passwords don't match.";
      }
      return null;
    }
    return nullOrEmptyString(confirmPass);
    // }
    // return isPasswordContain(pass);
  }

  static String? isPasswordContain(String? pass) {
    if (nullOrEmptyString(pass) == null) {
      //"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
      RegExp regExp = RegExp(
          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&-+=()])(?=\\S+$).{8, 20}$');
      print("${regExp.hasMatch(pass!)}");
      print(pass);
      if (regExp.hasMatch(pass)) {
        return "Password don't contain uppercase, lowercase, number, symbol and length is below 6";
      }
      return null;
    }
    return nullOrEmptyString(pass);
  }

  static String? isAadharCardNoValid(String? input) {
    if (nullOrEmptyString(input) != null) {
      return null;
    } else {
      if (input!.length != 12) {
        return "Aadhar card number is not valid";
      }
      return null;
    }
  }

  static String? isDrivingLicenseValid(String? input) {
    if (nullOrEmptyString(input) != null) {
      return null;
    } else {
      RegExp regExp = RegExp(
          r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$');
      print("${regExp.hasMatch(input!)}");
      print(input);
      if (!regExp.hasMatch(input)) {
        return "Driving license is not valid";
      }
      return null;
    }
  }

  static String? isPassportValid(String? input) {
    if (nullOrEmptyString(input) != null) {
      return null;
    } else {
      //RegExp regExp = RegExp(r'^[A-PR-WY-Z][1-9]\\d\\s?\\d{4}[1-9]$');
      // print("${regExp.hasMatch(input!)}");
      // print(input);
      // if (!regExp.hasMatch(input)) {
      if (input!.length != 9) {
        return "Passport is not valid";
      }
      return null;
    }
  }

  static String? isPanCardValid(String? input) {
    if (nullOrEmptyString(input) != null) {
      return null;
    } else {
      RegExp regExp = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
      print("${regExp.hasMatch(input!)}");
      print(input);
      if (!regExp.hasMatch(input)) {
        return "Pan card number is not valid";
      }
      return null;
    }
  }
}
