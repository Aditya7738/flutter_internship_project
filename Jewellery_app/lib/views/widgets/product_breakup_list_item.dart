import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/label_widget.dart';

class ProductBreakupListItem extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color labelColor;
  const ProductBreakupListItem({super.key, required this.label, this.backgroundColor, required this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: LabelWidget(
        label: label,
        color: labelColor,
      ),
    );
  }
}
