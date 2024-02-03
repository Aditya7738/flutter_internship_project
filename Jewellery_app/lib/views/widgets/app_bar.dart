import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final IconData menuIcon;
  final VoidCallback? onPressed;
  final bool isNeededForHome;
  final bool isNeededForProductPage;

  const AppBarWidget(
      {super.key,
      required this.menuIcon,
      required this.onPressed,
      required this.isNeededForHome,
      required this.isNeededForProductPage});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isNeededForHome
          ? IconButton(
              onPressed: onPressed,
              icon: Icon(
                menuIcon,
                color: Colors.black,
              ))
          : IconButton(
              onPressed: onPressed,
              icon: Icon(
                menuIcon,
                color: Colors.black,
              )),
      //leadingWidth: 15.0,
      title: isNeededForHome
          ? Image.network(
              Strings.app_logo,
               width: 150,
            height: 80,
            )
          : const TextField(
              showCursor: true,
              maxLines: 1,
              autofocus: true,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: Colors.grey,
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 24,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  )),
            ),

      backgroundColor: Colors.white,
      actions: isNeededForHome
          ? <Widget>[
              const CircleAvatar(
                radius: 12.0,

                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/b/bc/Flag_of_India.png"),
                  radius: 12,
                ), //CircleAvatar,
              ),
              const SizedBox(
                width: 10,
              ),
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
              SizedBox(
                height: 40.0,
                width: 32.0,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
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
            ]
          : [
              // const TextField(
              //   showCursor: true,
              //     maxLines: 1,
              //   autofocus: true,
              //   decoration: InputDecoration(
              //     icon: Icon(Icons.search_rounded),
              //     hintText: "Search",
              //     hintStyle: TextStyle(
              //       color: Colors.grey
              //     )
              //   ),
              // ),
              const Icon(Icons.mic_none_rounded),
              const SizedBox(
                width: 5.0,
              )
            ],

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
