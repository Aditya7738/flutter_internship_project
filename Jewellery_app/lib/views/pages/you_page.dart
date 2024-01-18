import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/wishlist_provider.dart';
import 'package:jwelery_app/views/pages/cart_page.dart';
import 'package:jwelery_app/views/pages/wishlist_page.dart';
import 'package:provider/provider.dart';

class YouPage extends StatelessWidget {
  YouPage({super.key});

  List<IconData> icons = [
    Icons.account_circle_outlined,
    Icons.qr_code_scanner_outlined,
    Icons.notifications_none_outlined,
    Icons.pin_drop_outlined
  ];
  List<String> title = [
    "Login",
    "Scan(at store)",
    "Notifications",
    "Track Order",
  ];

  List<IconData> icons2 = [
    Icons.send,
    Icons.share,
    Icons.star_rate_outlined,
  ];
  List<String> title2 = [
    "Send Feedback",
    "Share App",
    "Rate Us",
  ];

  List<String> title3 = [
    "Return",
    "Exchange",
    "Repair",
    "Shipping",
    "FAQ"

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.network(
            Strings.app_logo,
            width: 150,
            height: 80,
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Icon(
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
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
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
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "Hello, there!",
                  style: TextStyle(fontSize: 17.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 280.0,
              child: ListView.separated(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(icons[index]),
                    title: Text(title[index], style: TextStyle(fontSize: 17.0)),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1.0, color: Colors.grey),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "CONTACT US",
                  style: TextStyle(fontSize: 15.0),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: Icon(Icons.call),
                      ),
                      Text("Call")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: Icon(Icons.forum_sharp),
                      ),
                      Text("Chat")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: Image.asset("assets/images/whatsapp.png",),
                      ),
                      Text("Whatsapp")
                    ],
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "SPREAD THE WORD",
                  style: TextStyle(fontSize: 15.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(icons2[index]),
                    title:
                        Text(title2[index], style: TextStyle(fontSize: 17.0)),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1.0, color: Colors.grey),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "POLICIES",
                  style: TextStyle(fontSize: 15.0),
                )),
             SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: GridView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                  decoration: BoxDecoration(
                  
                    border: Border.all(
                              color: Colors.grey, style: BorderStyle.solid),

                  ),
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.0,
                    vertical: 10.0),
                    child: Text(title3[index]),
                    ),
                  );
                },
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.9,
                        crossAxisCount:
                            3,
                       
                        mainAxisSpacing: 0.0),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
