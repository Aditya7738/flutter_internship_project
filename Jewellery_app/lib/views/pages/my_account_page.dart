import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/views/pages/cart_page.dart';
import 'package:jwelery_app/views/pages/orders_page.dart';
import 'package:jwelery_app/views/pages/payment_page.dart';
import 'package:jwelery_app/views/pages/profile_page.dart';
import 'package:jwelery_app/views/pages/wishlist_page.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class MyAccountPage extends StatelessWidget {
  MyAccountPage({super.key});

  List<String> icons = [
    "assets/images/to_do_list.png",
    "assets/images/credit_card.png",
    //"assets/images/refund.png",
    "assets/images/wishlist.png",
  //  "assets/images/home.png",
    //"assets/images/discount.png",
  //  "assets/images/pin.png",
    "assets/images/logout.png"
  ];
  List<String> titles = [
    "My Orders",
    "Payment",
   // "Manage Refunds",
    "My Wishlist",
   // "My Free Try at Home",
   // "My Offers",
   // "Address",
    "Logout"
  ];

   void showCouponDialog(BuildContext context) {
    //TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text("Confirm Logout"),
          content: Text("Please click on confirm button for logout else cance"),
          actions: [
            
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (context) => SearchPage()));
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
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (context) => SearchPage()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffCC868A),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  )),
            ),

          ],        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("My Account"),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Icon(
              Icons.search_rounded,
              size: 30.0,
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
      body: Container(
        color: Color.fromARGB(255, 236, 236, 236),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Row(children: [
                Container(
                  color: Colors.red,
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
                  child: Text(
                    "A",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FIRST NAME",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "LAST NAME",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProfilePage())),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                )
              ]),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height:
                  MediaQuery.of(context).size.height - (kToolbarHeight + 190.0),
              child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: (){
                          switch (index) {
                            case 0:
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage()));
                              break;
                              case 1:
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentPage()));
                              break;
                              case 2:
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishListPage()));
                              break;
                              case 3:
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishListPage()));
                              break;
                              case 4:
                              showCouponDialog(context);
                              break;
                            default:
                          }
                          
                          },
                        leading: Image.asset(
                                icons[index],
                                width: 40.0,
                                height: 40.0,
                              ),
                            title: Text(titles[index], style: TextStyle(fontSize: 18.0)),
                            trailing: Icon(Icons.chevron_right_outlined),  
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Card MyAccountListItem(int index) {
    return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Image.asset(
                            icons[index],
                            width: 40.0,
                            height: 40.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(titles[index], style: TextStyle(fontSize: 18.0))
                        ],
                      ),
                    ),
                  );
  }
}
