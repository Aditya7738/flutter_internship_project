import 'package:flutter/material.dart';

class DigiGoldPlanSubCard extends StatelessWidget {
  final String price;
  
  final bool isPlanAlreadyPurchased;
  const DigiGoldPlanSubCard(
      {super.key, required this.price, required this.isPlanAlreadyPurchased});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPlanAlreadyPurchased ?
      const Color.fromARGB(255, 255, 248, 180)
      : Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 180.0),
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
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }
}
