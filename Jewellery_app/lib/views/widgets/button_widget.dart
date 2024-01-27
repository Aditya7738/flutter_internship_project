import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? imagePath;
  final String btnString;
  final Function()? onTap;
  const ButtonWidget(
      {super.key, this.imagePath, required this.btnString,  this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        // margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          // gradient: const LinearGradient(
          //     colors: [Color(0xFFDC58E6), Color(0xFF9062F9)],
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight),
          color: Theme.of(context).primaryColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnString,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            imagePath != null 
            ?
            Image.asset(
              imagePath!,
              width: 17.0,
              height: 17.0,
              color: Colors.white,
            )
            :
            SizedBox()
          ],
        ),
      ),
    );
  }
}
