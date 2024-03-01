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
    //TextEditingController textEditingController = TextEditingController();
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: const Text("Confirm Logout"),
          content: const Text(
              "Please click on confirm button for logout else cancel", style: TextStyle(fontSize: 17.0),),
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
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black, fontSize: 17.0),
                  )),
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
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
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
    String name = customerProvider.customerData[0]["first_name"];
    print(name);
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Account"),
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
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 20.0),
                    child: const Text(
                      "A",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30.0),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  builder: (context) => const EditProfilePage())),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(Icons.edit, color: Theme.of(context).primaryColor,)
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
                          horizontal: 10.0, vertical: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const OrderPage()));
                                break;
                              // case 1:
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: (context) => const ActivePayments()));
                              //   break;
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
                            width: 40.0,
                            height: 40.0,
                          ),
                          title: Text(titles[index],
                              style: const TextStyle(fontSize: 18.0)),
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