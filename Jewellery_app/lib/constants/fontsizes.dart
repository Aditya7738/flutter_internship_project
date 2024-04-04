import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fontsizes {
  static double textFormInputFieldSize = 16.sp;
  static double tabletTextFormInputFieldSize = 25.sp;
  static double errorTextSize = 14.sp;
  static double tabletErrorTextSize = 20.sp;
  static double headingSize = 19.sp;
  static double tabletHeadingSize = 27.sp;
  static TextStyle buttonTextStyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.sp);

  static TextStyle headlineTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp);

  // static TextStyle? getHeadlineTextStyle(double deviceWidth) {
  //   return TextStyle(fontWeight: FontWeight.bold, 
  //   fontSize: deviceWidth > 600 ? 27.sp : 19.sp);
  // }
}
