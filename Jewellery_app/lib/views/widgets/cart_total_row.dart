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
          style: Theme.of(context).textTheme.headline2,
          maxLines: 2,
        ),
        showMoney
            ? Text("₹ $value", style: Theme.of(context).textTheme.headline2)
            : Text(value[0].toUpperCase() + value.substring(1).toLowerCase(), style: Theme.of(context).textTheme.headline2)
      ],
    );
  }
}
