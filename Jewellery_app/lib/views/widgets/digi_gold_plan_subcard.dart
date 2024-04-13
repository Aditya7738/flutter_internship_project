import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DigiGoldPlanSubCard extends StatelessWidget {
  final String price;

  final bool isPlanAlreadyPurchased;
  const DigiGoldPlanSubCard(
      {super.key, required this.price, required this.isPlanAlreadyPurchased});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      color: isPlanAlreadyPurchased
          ? const Color.fromARGB(255, 255, 248, 180)
          : Colors.yellow,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.symmetric(vertical: deviceWidth > 600 ? 180.0 : 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/gold_coin.png",
              width: 45.0,
              height: 45.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "₹ $price",
              style: const TextStyle(
                fontSize: 45.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Per Month",
              style: TextStyle(
                 
                  fontSize:deviceWidth > 600 ? 28.sp : 16.sp,
                ),
            )
          ],
        ),
      ),
    );
  }
}
