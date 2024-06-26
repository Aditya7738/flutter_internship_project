import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class BottomAppBarCart extends StatelessWidget implements PreferredSizeWidget {
  const BottomAppBarCart({super.key});

  @override
  Widget build(BuildContext context) {
    // var cartProvider = Provider.of<CartProvider>(context, listen: false);
    // cartProvider.calculateTotalPrice();

    return Expanded(
        child: Container(
      color: Colors.grey,
      child: Consumer<CartProvider>(
        builder: ((context, value, child) {
          var cartList = value.cart;
          //value.calculateTotalPrice();
          // var totalPrice = 0.0;
          
          // for (int i = 0; i < cartList.length; i++) {
          //   var price = double.parse(cartList[i].price ?? "20000");
          //   var quantity = double.parse(cartList[i].quantity ?? "1");
          //   totalPrice += price * quantity;
          // }

          // value.setTotalPrice(totalPrice);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [const Text("Items "), Text("(${cartList.length})")],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/rupee.png",
                      width: 20.0,
                      height: 20.0,
                    ),
                    Text("${value.calculateTotalPrice()}"),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
