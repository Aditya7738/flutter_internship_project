import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/my_gold_plans.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/pages/orders_page.dart';
import 'package:Tiara_by_TJ/views/pages/active_payment_page.dart';
import 'package:Tiara_by_TJ/views/pages/edit_profile_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class MyProfilePage extends StatelessWidget {
  MyProfilePage({super.key});

  List<String> icons = [
    "assets/images/order_delivery.png",
    // "assets/images/credit_card.png",
    //"assets/images/refund.png",
    // "assets/images/wishlist.png",
    "assets/images/heart_outlined.png",
    "assets/images/gold_bars_menu.png",
    //  "assets/images/home.png",
    //"assets/images/discount.png",
    //  "assets/images/pin.png",
    "assets/images/logout.png"
  ];
  List<String> titles = [
    "My Orders",
    // "Payment",
    // "Manage Refunds",
    "My Wishlist",
    "My Gold plans",
    // "My Free Try at Home",
    // "My Offers",
    // "Address",
    "Logout"
  ];

  void showLogoutDialog(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //TextEditingController textEditingController = TextEditingController();
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(
            "Confirm Logout",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Text(
            "Please click on confirm button for logout else cancel",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: deviceWidth > 600 ? 25.0 : 17.0),
                  )),
            ),
            SizedBox(
              width: 10.0,
            ),
            GestureDetector(
              onTap: () {
                customerProvider.customerData.clear();
                print(
                    "customerProvider.customerData.length ${customerProvider.customerData.length}");
                print(
                    "customerProvider.customerData ${customerProvider.customerData}");
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const LoginPage(
                            isComeFromCart: false,
                          )),
                  (route) => false,
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffCC868A),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: deviceWidth > 600 ? 25.0 : 17.0),
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    customerProvider.customerData.forEach((element) {
      print("profile customerData $element");
    });
    String name = customerProvider.customerData[0]["first_name"];
    print(name);

    String firstCharacter = name.substring(0, 1);

    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: kToolbarHeight + 20,
          title: const Text("My Account"),
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
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              width: (deviceWidth / 16) + 4,
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
                badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                          value.cart.length.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (deviceWidth / 31) - 1),
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
              width: 34,
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 236, 236, 236),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Row(children: [
                  Container(
                    height: deviceWidth > 600 ? 150.0 : 90.0,
                    width: deviceWidth > 600 ? 150.0 : 90.0,
                    color: Colors.red,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 35.0, vertical: 20.0),
                    child: Text(
                      firstCharacter,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: deviceWidth > 600 ? 70.0 : 30.0),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("Aditya",
                      //     style: deviceWidth > 600
                      //         ? TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: deviceWidth / 28,
                      //           )
                      //         : TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: (deviceWidth / 30) + 3,
                      //           )),

                      // // SizedBox(
                      // //   height: 5.0,
                      // // ),
                      // Text("Shigwan",
                      //     style: deviceWidth > 600
                      //         ? TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: deviceWidth / 28,
                      //           )
                      //         : TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: (deviceWidth / 30) + 3,
                      //           )),

                      Text(customerProvider.customerData[0]["first_name"],
                          style: Theme.of(context).textTheme.headline1),
                      Text(customerProvider.customerData[0]["last_name"],
                          style: Theme.of(context).textTheme.headline1),
                      const SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage())),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                  size: deviceWidth > 600 ? 28.0 : 23.0,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context).primaryColor,
                                    style: BorderStyle.solid),
                                shape: BoxShape.rectangle),
                          ))
                    ],
                  )
                ]),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    (kToolbarHeight + 190.0),
                child: ListView.builder(
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const OrderPage()));
                                break;

                              case 1:
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const WishListPage()));
                                break;
                              case 2:
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const MyGoldPlans()));
                                break;
                              case 3:
                                showLogoutDialog(context);
                                break;
                              default:
                            }
                          },
                          leading: Image.asset(
                            icons[index],
                            width: deviceWidth > 600 ? 55.0 : 40.0,
                            height: deviceWidth > 600 ? 55.0 : 40.0,
                          ),
                          title: Text(titles[index],
                              style: TextStyle(
                                  fontSize: deviceWidth > 600 ? 27.0 : 18.0,
                                  fontWeight: FontWeight.normal)),
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
