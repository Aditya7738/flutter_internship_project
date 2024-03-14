import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/pages/my_profile_page.dart';
import 'package:Tiara_by_TJ/views/pages/notification_page.dart';
import 'package:Tiara_by_TJ/views/pages/orders_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  final InAppReview inAppReview = InAppReview.instance;

  // List<IconData> icons = [

  //   // Icons.qr_code_scanner_outlined,
  //   // Icons.notifications_none_outlined,
  //   Icons.pin_drop_outlined
  // ];

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

  void _launchGmailCompose(
      {required String to,
      String? subject,
      String? body,
      required BuildContext context}) async {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: to,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body
        });
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        throw 'Could not launch $emailLaunchUri';
      }
    }
  }

  Future<void> onLinkClicked(String url, BuildContext context) async {
    Uri uri = Uri.parse(url);
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        print("Could not launch Terms and condition's URL");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    bool isDataEmpty = customerProvider.customerData.isEmpty;
    print("isDataEmpty $isDataEmpty");
    print("CUSTOMERDATA ${customerProvider.customerData.length}");
    double deviceWidth = MediaQuery.of(context).size.width;
    print("deviceWidth / 20 ${deviceWidth / 31}");

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: kToolbarHeight + 20,
          automaticallyImplyLeading: false,
          title: Image.network(
            Constants.app_logo,
            width: 260,
            height: kToolbarHeight,
            fit: BoxFit.fitWidth,
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
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
            
              width: (deviceWidth / 16) + 4,
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
                badgeContent: Consumer<WishlistProvider>(
                    builder: (context, value, child) {
                  print("LENGTH OF FAV: ${value.favProductIds}");
                  return Text(
                    value.favProductIds.length.toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: (deviceWidth / 31) - 1),
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
              width: 24,
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
          ]
          ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: Text("Hello, there!",
                    style: TextStyle(
                      fontSize: deviceWidth > 600 ? 26.0 : 17.0,
                    ))),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              onTap: () {
                false
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginPage(isComeFromCart: false),
                        ))
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyProfilePage(),
                      ));
              },
              leading: Icon(
                Icons.account_circle_outlined,
                size: deviceWidth > 600 ? 40.0 : 30.0,
              ),
              title: Text(false ? "Login" : "My profile",
                  style: TextStyle(
                      fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                      fontWeight: FontWeight.normal)),
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: 135.0,
            //   child: ListView.separated(
            //     itemCount: icons.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         onTap: () {
            //           switch (index) {
            //             case 0:
            //               isDataEmpty
            //                   ? Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) =>
            //                             LoginPage(isComeFromCart: false),
            //                       ))
            //                   : Navigator.of(context).push(MaterialPageRoute(
            //                       builder: (context) => MyProfilePage(),
            //                     ));

            //               break;
            //             // case 2:
            //             //   Navigator.of(context).push(MaterialPageRoute(
            //             //     builder: (context) => const NotificationPage(),
            //             //   ));

            //             //   break;
            //             case 1:
            //               Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (context) => const OrderPage(),
            //               ));
            //               break;
            //             default:
            //           }
            //         },
            //         leading: Icon(icons[index]),
            //         title: Text(title[index],
            //             style: const TextStyle(fontSize: 17.0)),
            //       );
            //     },
            //     separatorBuilder: (context, index) =>
            //         const Divider(thickness: 1.0, color: Colors.grey),
            //   ),
            // ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 10.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "CONTACT US",
                  style: TextStyle(fontSize: deviceWidth > 600 ? 24.0 : 15.0),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String url = 'tel:9833566117';
                          Uri uri = Uri.parse(url);

                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: deviceWidth > 600 ? 100.0 : 50.0,
                          height: deviceWidth > 600 ? 100.0 : 50.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromARGB(255, 230, 230, 230),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              )),
                          child: Icon(
                            Icons.call,
                            size: deviceWidth > 600 ? 50.0 : 30.0,
                          ),
                        ),
                      ),
                      Text(
                        "Call",
                        style: TextStyle(
                            fontSize: deviceWidth > 600 ? 27.0 : 17.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          onLinkClicked("https://tiarabytj.com/", context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: deviceWidth > 600 ? 100.0 : 50.0,
                          height: deviceWidth > 600 ? 100.0 : 50.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromARGB(255, 230, 230, 230),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              )),
                          child: Icon(
                            Icons.web,
                            size: deviceWidth > 600 ? 50.0 : 30.0,
                          ),
                        ),
                      ),
                      Text("Visit our website",
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0))
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8.0),
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         margin: const EdgeInsets.symmetric(vertical: 10.0),
                  //         width: 50.0,
                  //         height: 50.0,
                  //         padding: const EdgeInsets.all(10.0),
                  //         decoration: const BoxDecoration(
                  //             shape: BoxShape.rectangle,
                  //             color: Color.fromARGB(255, 230, 230, 230),
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(15.0),
                  //             )),
                  //         child: Image.asset(
                  //           "assets/images/whatsapp.png",
                  //         ),
                  //       ),
                  //       const Text("Whatsapp", style: TextStyle(fontSize: 17.0))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 10.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "SPREAD THE WORD",
                  style: TextStyle(fontSize: deviceWidth > 600 ? 24.0 : 15.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: deviceWidth > 600 ? 286 : 230.0,
              child: ListView.separated(
                itemCount: icons2.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      switch (index) {
                        case 0:
                          _launchGmailCompose(
                              to: 'tiarabytj@gmail.com',
                              subject: 'Feedback',
                              body: 'Respected sir/mam',
                              context: context);
                          break;
                        case 1:
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const NotificationPage(),
                          // ));

                          break;
                        case 2:
                          if (await inAppReview.isAvailable()) {
                            print("inAppReview.isAvailable");
                            inAppReview.requestReview();
                          } else {
                            print("inAppReview.isUnAvailable");
                          }
                          break;
                        default:
                      }
                    },
                    child: ListTile(
                     
                      contentPadding: EdgeInsets.symmetric(
                          vertical: deviceWidth > 600 ? 10.0 : 5.0,
                          horizontal: 20.0),
                      leading: Icon(
                        icons2[index],
                        size: deviceWidth > 600 ? 40.0 : 30.0,
                      ),
                      title: Text(title2[index],
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                              fontWeight: FontWeight.normal)),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.0, color: Colors.grey),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 10.0),
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                child: Text(
                  "POLICIES",
                  style: TextStyle(fontSize: deviceWidth > 600 ? 24.0 : 15.0),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height:  deviceWidth > 600 ? 201.0 :100.0,
              child: GridView.builder(
                itemCount: title3.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          onLinkClicked(
                              "https://tiarabytj.com/blog/quotations/return-policy/",
                              context);
                          break;
                        default:
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                             vertical: 10.0),
                        child: Text(title3[index],
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 32.0 : 16.0,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: deviceWidth > 600 ? 3.3 :2.9,
                    crossAxisCount: 3,
                    mainAxisSpacing: 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _callNumber() async {
    // print("_callNumber");
    // const number = '9833566117'; //set the number here
    // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    // print("_callNumber $res");
    String url = 'tel:9833566117';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
