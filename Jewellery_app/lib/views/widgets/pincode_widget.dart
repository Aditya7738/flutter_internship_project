import 'package:flutter/material.dart';

class PincodeWidget extends StatelessWidget {
  const PincodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFE5D3F6),
        ),
        height: 40,
        
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    color: Colors.deepPurple,
                    "assets/images/aim.png",
                    width: 20.0,
                    height: 20.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Text(
                    "Entry Delivery Pincode",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),
              const Icon(
                Icons.help_outline_rounded,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ));
  }
}
