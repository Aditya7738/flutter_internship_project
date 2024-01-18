import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
     
      children: [
        Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            showMoney
                ? Row(
        children: [
          Image.asset(
            "assets/images/rupee.png",
            width: 19.0,
            height: 17.0,
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          )
        ],
                  )
                : Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),
                  )
        
      ],
    );
  }
}