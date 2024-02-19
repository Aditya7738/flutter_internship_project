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
          style: Theme.of(context).textTheme.headline3,
          maxLines: 2,
        ),
        showMoney
            ? Row(
                children: [
                  Image.asset(
                    "assets/images/rupee.png",
                    width: 19.0,
                    height: 17.0,
                  ),
                  Text(value, style: Theme.of(context).textTheme.headline3)
                ],
              )
            : Text(value[0].toUpperCase() + value.substring(1).toLowerCase(), style: Theme.of(context).textTheme.headline3)
      ],
    );
  }
}
