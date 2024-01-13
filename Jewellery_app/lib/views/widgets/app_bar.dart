import 'package:flutter/material.dart';
import 'package:jwelery_app/views/pages/cart_page.dart';
import 'package:jwelery_app/views/widgets/custom_searchbar.dart';
import 'package:badges/badges.dart' as badges;

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final IconData menuIcon;
  final VoidCallback? onPressed;
  final bool isNeededForHome;

  const AppBarWidget(
      {super.key,
      required this.menuIcon,
      required this.onPressed,
      required this.isNeededForHome});

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
              "https://i.pinimg.com/564x/c3/6c/0d/c36c0d93ad3cb8779d3cc95b0b37a1cf.jpg",
              width: 70,
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
              IconButton(
                onPressed: () {
                  print("FAVOURITE CLICKED");
                },
                icon: const Icon(Icons.favorite_sharp, color: Colors.black),
              ),
              SizedBox(
                height: 40.0,
                width: 32.0,
                child: badges.Badge(
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.purple
                  ),
                  badgeContent: const Text('3', style: TextStyle(color: Colors.white),),
                  child: IconButton(
                    onPressed: () {
                      print("CART CLICKED");
                    },
                    icon: GestureDetector(
                      child: const Icon(Icons.shopping_cart),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartPage())),),
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
              const SizedBox(width: 5.0,)
            ],

      bottom: !isNeededForHome ? null : const CustomSearchBar(),
      elevation: 5.0,
    );
  }

  @override
  Size get preferredSize => isNeededForHome
      ? const Size.fromHeight(kToolbarHeight + kToolbarHeight)
      : const Size.fromHeight(kToolbarHeight);
}
