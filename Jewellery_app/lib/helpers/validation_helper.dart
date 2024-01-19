class ValidationHelper{

  static String? nullOrEmptyString(String? input){
    if(input == null || input == ""){
      return "Input field is empty";
    }
    return null;
  }

static String? isFullAddress(String? input){
    if(nullOrEmptyString(input) == null){
      if(input!.length != 10){
        return "Please enter full address";
      }
      return null;
    }
  }


  static String? isPhoneNoValid(String? input){
    if(nullOrEmptyString(input) == null){
      if(input!.length != 10){
        return "Phone no is not valid";

      }

      
      return null;
    }

    return nullOrEmptyString(input);
  }

  static String? isEmailValid(String? input){
    if(nullOrEmptyString(input) == null){
      String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
      RegExp regExp = RegExp(pattern);

      if(!regExp.hasMatch(input!)){
        return "Email is not valid";
      }
      //return null;
    }

    return nullOrEmptyString(input);
  }

  static String? isPincodeValid(String? input){
    if(nullOrEmptyString(input) == null){
      if(input!.length != 6){
        return "Pincode is not valid";
      }
      
    }
    return nullOrEmptyString(input);
  }




}

