import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceInfo extends StatelessWidget {
  final String label;
  final String price;
  const PriceInfo({super.key, required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    TextStyle labelHead = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.5.sp,
    );
    TextStyle sublabelHead = TextStyle(
      fontSize: 16.5.sp,
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.5.sp,
            ),
          ),
          Text(
            "₹ $price",
            style: TextStyle(
              fontSize: 16.5.sp,
            ),
          ),
        ],
      ),
    );
  }
}
