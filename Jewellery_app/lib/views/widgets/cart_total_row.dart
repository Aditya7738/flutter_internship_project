import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartTotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showMoney;

  const CartTotalRow(
      {super.key,
      required this.label,
      required this.value,
      required this.showMoney});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: deviceWidth > 600 ? 26.5.sp : 16.5.sp,
          ),
          maxLines: 2,
        ),
        showMoney
            ? Text("₹ $value",
                style: TextStyle(
                  fontSize: deviceWidth > 600 ? 26.5.sp : 16.5.sp,
                ))
            : Text(value[0].toUpperCase() + value.substring(1).toLowerCase(),
                style: TextStyle(
                  fontSize: deviceWidth > 600 ? 26.5.sp : 16.5.sp,
                ))
      ],
    );
  }
}
