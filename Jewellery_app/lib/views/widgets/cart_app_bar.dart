import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/bottom_app_bar_cart.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text("Cart"),
        actions: [
          Icon(Icons.call),
          SizedBox(width: 10.0,),
          Icon(Icons.live_help),
          SizedBox(width: 10.0,),
        ],
        bottom: const BottomAppBarCart(),
        elevation: 5.0,
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kToolbarHeight);
}