import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/pages/my_account_page.dart';
import 'package:Tiara_by_TJ/views/pages/notification_page.dart';
import 'package:Tiara_by_TJ/views/pages/orders_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:provider/provider.dart';

class YouPage extends StatelessWidget {
  YouPage({super.key});

  List<IconData> icons = [
    Icons.account_circle_outlined,
    Icons.qr_code_scanner_outlined,
    Icons.notifications_none_outlined,
    Icons.pin_drop_outlined
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

  List<String> title3 = ["Return", "Exchange", "Repair", "Shipping", "FAQ"];

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    bool isDataEmpty = customerProvider.customerData.isEmpty;
    print("isDataEmpty $isDataEmpty");
    print("CUSTOMERDATA ${customerProvider.customerData.length}");
    List<String> title = [
      isDataEmpty ? "Login" : "My Account",
      "Scan(at store)",
      "Notifications",
      "Track Order",
    ];
    return Scaffold(
      appBar: AppBar(
          title: Image.network(
            Strings.app_logo,
            width: 150,
            height: 80,
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ));
              },
              child: const Icon(
                Icons.search_rounded,
                size: 30.0,
              ),
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
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: const Text(
                  "Hello, there!",
                  style: TextStyle(fontSize: 17.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 280.0,
              child: ListView.separated(
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          isDataEmpty
                              ? MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                    isComeFromCart: false,
                                  ),
                                )
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyAccountPage(),
                                ));

                          break;
                        case 2:
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ));

                          break;
                        case 3:
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OrderPage(),
                          ));
                          break;
                        default:
                      }
                    },
                    leading: Icon(icons[index]),
                    title: Text(title[index],
                        style: const TextStyle(fontSize: 17.0)),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.0, color: Colors.grey),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: const Text(
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
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: 50.0,
                        height: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: const Icon(Icons.call),
                      ),
                      const Text(
                        "Call",
                        style: TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: 50.0,
                        height: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: const Icon(Icons.forum_sharp),
                      ),
                      const Text("Chat", style: TextStyle(fontSize: 17.0))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: 50.0,
                        height: 50.0,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(255, 230, 230, 230),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        child: Image.asset(
                          "assets/images/whatsapp.png",
                        ),
                      ),
                      const Text("Whatsapp", style: TextStyle(fontSize: 17.0))
                    ],
                  ),
                )
              ],
            ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: const Text(
                  "SPREAD THE WORD",
                  style: TextStyle(fontSize: 15.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: ListView.separated(
                itemCount: icons2.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          // isDataEmpty
                          //     ? MaterialPageRoute(
                          //         builder: (context) => LoginPage(
                          //           isComeFromCart: false,
                          //         ),
                          //       )
                          //     : Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => MyAccountPage(),
                          //       ));

                          break;
                        case 2:
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const NotificationPage(),
                          // ));

                          break;
                        case 3:
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const OrderPage(),
                          // ));
                          break;
                        default:
                      }
                    },
                    child: ListTile(
                      leading: Icon(icons2[index]),
                      title: Text(title2[index],
                          style: const TextStyle(fontSize: 17.0)),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.0, color: Colors.grey),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: const Text(
                  "POLICIES",
                  style: TextStyle(fontSize: 15.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: GridView.builder(
                itemCount: title3.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Text(title3[index]),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.9,
                    crossAxisCount: 3,
                    mainAxisSpacing: 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
