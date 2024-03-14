import 'package:flutter/material.dart';

class PriceInfo extends StatelessWidget {
  final String label;
  final String price;
  const PriceInfo({super.key, required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            "₹ $price",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
