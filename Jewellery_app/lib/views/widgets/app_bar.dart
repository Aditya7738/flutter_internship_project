import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/custom_searchbar.dart';


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
          ? [
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
                height: 65.0,
                width: 50.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("CART CLICKED");
                      },
                      icon: const Icon(Icons.shopping_cart),
                      color: Colors.black,
                    ),
                    const Positioned(
                        bottom: 15.0,
                        right: 9.0,
                        child: Icon(
                          Icons.add_circle,
                          size: 15.0,
                          color: Colors.purple,
                        )),
                  ],
                ),
              )
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
