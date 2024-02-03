import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/widgets/bottom_app_bar_cart.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;


  const CartAppBar({super.key, required this.title});

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
        
        elevation: 5.0,
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);
}