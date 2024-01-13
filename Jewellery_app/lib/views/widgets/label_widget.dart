import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  const LabelWidget({super.key, required this.label, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? 20.0,
            color: color ?? Colors.black
            ));
  }
}
