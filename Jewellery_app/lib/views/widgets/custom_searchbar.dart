import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    print("CustomSearchBar deviceWidth ${(deviceWidth / 35) + 1}");
    return GestureDetector(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: layoutDesignProvider.primary != ""
                  ? Color(int.parse(
                      "0xff${layoutDesignProvider.primary.substring(1)}"))
                  : Color(0xffCC868A)

              //const Color(0xFFE4B2FF),
              ),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(Icons.search_rounded,
                  size: deviceWidth > 600
                      ? (deviceWidth / 35) + 6
                      : (deviceWidth / 35) + 6,
                  color: Colors.white),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Search by category, product & more..",
                style: TextStyle(
                    color: //Color(0xFF4F3267),
                        Colors.white,
                    fontSize: (deviceWidth / 35) + 2,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SearchPage()));
        });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
