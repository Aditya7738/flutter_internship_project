import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/bottom_app_bar_cart.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool forCart;

  const CartAppBar({super.key, required this.title, required this.forCart});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        actions: const [
          Icon(Icons.call),
          SizedBox(width: 10.0,),
          Icon(Icons.live_help),
          SizedBox(width: 10.0,),
        ],
        bottom: forCart ? const BottomAppBarCart() : null,
        elevation: 5.0,
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => forCart ? const Size.fromHeight(kToolbarHeight + kToolbarHeight) : const Size.fromHeight(kToolbarHeight);
}