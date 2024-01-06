import 'package:flutter/material.dart';

class FreePointsWidget extends StatelessWidget {
  final Color textColor;
  const FreePointsWidget({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "xClusive Points",
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 10.0),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Text(
        "xClusive Points",
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Divider(
        thickness: 5.0,
        color: textColor,
      ),
      const SizedBox(
        height: 20.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "xClusive Points",
            style: TextStyle(color: textColor, fontSize: 5.0),
          ),
          Container(
            color: Colors.white,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0.0, 1.0),
                      blurRadius: 1.0,
                      spreadRadius: 2.0)
                ],
                borderRadius: BorderRadius.circular(10.0),
                shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/right_arrow.png",
              color: textColor,
              width: 20.0,
              height: 20.0,
            ),
          )
        ],
      )
    ]);
  }
}
