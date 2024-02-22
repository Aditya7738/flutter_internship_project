import 'package:flutter/material.dart';

class DigiGoldPlanSubCard extends StatelessWidget {
  final String price;
  const DigiGoldPlanSubCard({super.key, required this.price });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/rupee.png",
                  width: 47.0,
                  height: 47.0,
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 45.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Per Month",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}