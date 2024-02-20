import 'package:flutter/material.dart';

class PriceInfo extends StatelessWidget {
  final String label;
  final String price;
  const PriceInfo({super.key, required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return  Row(
                    children: [
                      Text(
                        
                        label,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    
                      Text(
                        "₹ $price",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  );
  }
}