import 'package:flutter/material.dart';

class BottomAppBarCart extends StatelessWidget implements PreferredSizeWidget {
  const BottomAppBarCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Text("Items "),
                Text("()")
              ],
            ),
            Image.asset(
              "assets/images/rupee.png",
              width: 20.0,
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
