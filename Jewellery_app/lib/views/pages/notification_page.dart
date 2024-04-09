import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
     LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Image.network(
            Constants.app_logo,
            width: 150,
            height: 80,
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            const Icon(
              Icons.search_rounded,
              size: 30.0,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 40.0,
              width: 32.0,
              child: badges.Badge(
                badgeStyle:  badges.BadgeStyle(badgeColor:Color(int.parse("0xff${layoutDesignProvider.primary.substring(1)}"))),
                badgeContent: Consumer<WishlistProvider>(
                    builder: (context, value, child) {
                  print("LENGTH OF FAV: ${value.favProductIds}");
                  return Text(
                    value.favProductIds.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WishListPage()));
                  },
                  icon: const Icon(Icons.favorite_sharp, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              height: 40.0,
              width: 32.0,
              child: badges.Badge(
                badgeStyle:  badges.BadgeStyle(badgeColor:Color(int.parse("0xff${layoutDesignProvider.primary.substring(1)}"))),
                badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                          value.cart.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                child: IconButton(
                  onPressed: () {
                    print("CART CLICKED");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ]),
          body: EmptyListWidget(imagePath: "assets/images/remove.png", message: "You don't have any notification", forCancelledOrder: true,),

    );
  }
}