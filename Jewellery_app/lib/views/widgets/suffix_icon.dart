import 'package:flutter/material.dart';

class SuffixIcon extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const SuffixIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.5,
                blurRadius: 0.1,
                offset: const Offset(0, 0.5),
              ),
            ],
          ),
          child: Icon(icon)),
    );
  }
}
