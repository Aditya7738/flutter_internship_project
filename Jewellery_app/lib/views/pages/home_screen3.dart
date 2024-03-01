import 'package:Tiara_by_TJ/views/widgets/product_list_in_tab.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/category_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  @override
  Widget build(BuildContext context) {
    List<Widget> newArrivalTabs = [
      const Tab(
        text: "Nose pin",
      ),
      const Tab(
        text: "Bracelets",
      ),
      const Tab(
        text: "Rings",
      )
    ];

    List<Widget> diamondJewelleryTabs = [
      const Tab(
        text: "Earrings",
      ),
      const Tab(
        text: "Pendant",
      ),
      const Tab(
        text: "Rings",
      )
    ];

    List<Widget> goldenJewelleryTabs = [
      const Tab(
        text: "Earrings",
      ),
      const Tab(
        text: "Pendant",
      ),
      const Tab(
        text: "Rings",
      )
    ];

    List<Widget> silverJewelleryTabs = [
      const Tab(
        text: "Earrings",
      ),
      const Tab(
        text: "Pendant",
      ),
      const Tab(
        text: "Rings",
      )
    ];



    return Scaffold(
        appBar: AppBar(
            title: CachedNetworkImage(
              imageUrl: Constants.app_logo,
              width: 150,
              height: 70,
              placeholder: (context, url) {
                return SizedBox(
                  width: 150,
                  height: 70,
                  child: const Center(
                    child: LinearProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
                },
                child: Icon(
                  Icons.search_rounded,
                  size: 30.0,
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
            ]),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            // SizedBox(
            //   height: 10.0,
            // ),

            SizedBox(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: DefaultTabController(
                  length: newArrivalTabs.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "NEW ARRIVALS",
                        style: TextStyle(fontSize: 27.0),
                      ),
                      bottom: TabBar(tabs: newArrivalTabs, labelColor: Theme.of(context).primaryColor,indicatorColor: Theme.of(context).primaryColor,),
                    ),
                    body: TabBarView(children: [
                      Container(
                        color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.yellow,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.blue,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                    ]),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: DefaultTabController(
                  length: diamondJewelleryTabs.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "Diamond Jewellery",
                        style: TextStyle(fontSize: 27.0),
                      ),
                      bottom: TabBar(tabs: diamondJewelleryTabs, labelColor: Theme.of(context).primaryColor,indicatorColor: Theme.of(context).primaryColor),
                    ),
                    body: TabBarView(children: [
                      Container(
                        color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.yellow,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.blue,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                    ]),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: DefaultTabController(
                  length: goldenJewelleryTabs.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "Golden Jewellery",
                        style: TextStyle(fontSize: 27.0),
                      ),
                      bottom: TabBar(tabs: goldenJewelleryTabs,labelColor: Theme.of(context).primaryColor, indicatorColor: Theme.of(context).primaryColor),
                    ),
                    body: TabBarView(children: [
                      Container(
                        color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.yellow,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.blue,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                    ]),
                  )),
            ),
             SizedBox(
              height: 10.0,
            ),
            SizedBox(
              //color: Colors.red,
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: DefaultTabController(
                  length: silverJewelleryTabs.length,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "Silver Jewellery",
                        style: TextStyle(fontSize: 27.0),
                      ),
                      bottom: TabBar(tabs: silverJewelleryTabs, 
                      labelColor: Theme.of(context).primaryColor,
                      indicatorColor: Theme.of(context).primaryColor),
                    ),
                    body: TabBarView(children: [
                      Container(
                        color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.yellow,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                      Container(
                        color: Colors.blue,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ProductListInTab(),
                      ),
                    ]),
                  )),
            ),

          ]),
        )));
  }
}
