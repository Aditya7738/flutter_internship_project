import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isNeededForHome;
  final bool isNeededForProductPage;

  const AppBarWidget(
      {super.key,
      //  required this.menuIcon,

      required this.isNeededForHome,
      required this.isNeededForProductPage});

  @override
  Widget build(BuildContext context) {
     double deviceWidth = MediaQuery.of(context).size.width;
    print("deviceWidth ${deviceWidth}");
    return AppBar(
      actionsIconTheme: IconThemeData(
        size: deviceWidth / 25
      ),
      automaticallyImplyLeading: false,
      title: Image.network(
              Constants.app_logo,
              width: 150,
              height: 80,
            )
          ,
      backgroundColor: Colors.white,
      actions: <Widget>[
           
              SizedBox(
                height: 40.0,
                width: 32.0,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
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
              Container(
                margin: EdgeInsets.only(top: 4.0),
                height: 40.0,
                width: 32.0,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
                  badgeContent:
                      Consumer<CartProvider>(builder: (context, value, child) {
                    if (value.isOrderCreating) {
                      return SizedBox(
                        width: 8.0,
                        height: 8.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.0,
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        value.cart.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      );
                    }
                  }),
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
            ]
          ,
      bottom: !isNeededForHome || isNeededForProductPage
          ? null
          : const CustomSearchBar(),
      elevation: 5.0,
    );
  }

  @override
  Size get preferredSize => isNeededForHome
      ? const Size.fromHeight(kToolbarHeight + kToolbarHeight)
      : const Size.fromHeight(kToolbarHeight);
}
