import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/views/pages/coupon_list.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/shipping_page.dart';
import 'package:Tiara_by_TJ/views/widgets/button_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/cart_app_bar.dart';
import 'package:Tiara_by_TJ/views/widgets/cart_total_row.dart';
import 'package:Tiara_by_TJ/views/widgets/label_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  int? productId;

  CartPage({super.key});

  // CartPage.empty() : productId = 0;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selectedQuantity = '1';
  String selectedSize = '5';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> quantityList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  List<String> sizeList = [
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25"
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cart = cartProvider.cart;

    return Scaffold(
        appBar: const CartAppBar(
          title: 'Cart',
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
              child: Consumer<CartProvider>(builder: (context, value, child) {
            var cartList = value.cart;

            cartList.forEach((element) {
              print("Cartlist in cart ${element.toMap()}");
            });
            if (cartList.isNotEmpty) {
              // value.calculateTotalPrice();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...getCartList(cartList, value),

                      const SizedBox(
                        height: 15.0,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CouponListPage(
                                    cartProductIds: value.cartProductIds,
                                    cartTotal: value.calculateTotalPrice()),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/discount.png",
                              color: Theme.of(context).primaryColor,
                              width: 30.0,
                              height: 30.0,
                            ),
                            title: Text(
                              "Apply Coupon",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 19.0),
                            ),
                            trailing: Icon(Icons.east_outlined,
                                size: 30.0,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   alignment: Alignment.centerRight,
                      //   child: InkWell(
                      //     child: Text(
                      //       "Apply coupon",
                      //       style: TextStyle(
                      //           fontSize: 17.0,
                      //           color: Theme.of(context).primaryColor,
                      //           decoration: TextDecoration.underline),
                      //     ),
                      //     onTap: () {
                      //       showCouponDialog(context);
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 15.0,
                      // ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cart totals",
                                style: Theme.of(context).textTheme.headline2),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      style: BorderStyle.solid)),
                              child: Column(
                                children: [
                                  CartTotalRow(
                                      label: 'No. of Items',
                                      value: value.cart.length
                                          .toString(), //decide what to fixed this or value.cartProductIds.length.toString(),
                                      showMoney: false),
                                  const Divider(
                                    height: 15.0,
                                    color: Colors.grey,
                                  ),
                                  CartTotalRow(
                                      label: 'Subtotal',
                                      value: value
                                          .calculateTotalPrice()
                                          .toString(),
                                      showMoney: true),
                                  const Divider(
                                    height: 15.0,
                                    color: Colors.grey,
                                  ),
                                  const CartTotalRow(
                                      label: 'Shipping charge',
                                      value: "Free",
                                      showMoney: false),
                                  const Divider(
                                    height: 15.0,
                                    color: Colors.grey,
                                  ),
                                  const CartTotalRow(
                                    label: 'Shipping insurance',
                                    value: "Free",
                                    showMoney: false,
                                  ),
                                  const Divider(
                                    height: 15.0,
                                    color: Colors.grey,
                                  ),
                                  CartTotalRow(
                                    label: 'Total',
                                    value:
                                        value.calculateTotalPrice().toString(),
                                    showMoney: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 90.0,
                      ),
                    ]),
              );
            } else {
              // return Padding(
              //   padding: const EdgeInsets.only(top: 28.0),
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Image.asset(
              //           "assets/images/empty_shopping_cart.png",
              //           width: 200.0,
              //           height: 200.0,
              //         ),
              //         const SizedBox(
              //           height: 40.0,
              //         ),
              //         Text("Your Shopping Bag is Empty",
              //             style: Theme.of(context).textTheme.headline1),
              //         const SizedBox(
              //           height: 50.0,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.of(context).pushReplacement(
              //                 MaterialPageRoute(
              //                     builder: (context) => const DashboardPage()));
              //           },
              //           child: Container(
              //               decoration: BoxDecoration(
              //                   color: Colors.green,
              //                   borderRadius: BorderRadius.circular(5.0)),
              //               padding: const EdgeInsets.symmetric(
              //                   vertical: 10.0, horizontal: 20.0),
              //               child: const Text(
              //                 "Continue Shopping",
              //                 style: TextStyle(
              //                     color: Colors.white, fontSize: 17.0),
              //               )),
              //         )
              //       ],
              //     ),
              //   ),
              // );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/empty_shopping_cart.png",
                        width: 150.0,
                        height: 150.0,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        "Your Cart is Empty",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 22.0,
                            // color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Looks like you don't have added any jewelleries to your cart yet",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.0),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const DashboardPage()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 40.0),
                            child: const Text(
                              "CONTINUE SHOPPING",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
              );
            }
          })),
        ),
        bottomSheet: Consumer<CartProvider>(
          builder: (context, value, child) {
            if (value.cart.isNotEmpty) {
              return BottomSheet(
                enableDrag: false,
                onClosing: () {},
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/rupee.png",
                              width: 25.0,
                              height: 37.0,
                            ),
                            Text(cartProvider.calculateTotalPrice().toString(),
                                style: Theme.of(context).textTheme.headline1)
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ButtonWidget(
                            btnString: "Proceed to checkout",
                            onTap: () {
                              final customerProvider =
                                  Provider.of<CustomerProvider>(context,
                                      listen: false);

                              //List<Map<String,dynamic>> oldCartDataList = <Map<String,dynamic>>[];

                              //user old cart item should be added to cart again when he login and direct to cart page
                              // for (var i = 0; i < cartProvider.cart.length; i++) {
                              //   oldCartDataList.add(

                              //   );
                              // }

                              // customerProvider.customerData.addAll(

                              // );

                              bool isDataEmpty =
                                  customerProvider.customerData.isEmpty;

                              if (isDataEmpty) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginPage(
                                          isComeFromCart: true,
                                        )));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ShippingPage()));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return SizedBox();
            }
          },
        )
        // cart.length != 0
        //     ?
        );
  }

  List<Widget> getCartList(
      List<CartProductModel> cartList, CartProvider value) {
    return cartList.map((cartData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
            child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                cartData.imageUrl ?? Strings.defaultImageUrl,
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/rupee.png",
                        width: 19.0,
                        height: 19.0,
                      ),
                      Text(cartData.price ?? "20,000",
                          style: Theme.of(context).textTheme.headline2)
                    ],
                  ),
                  SizedBox(
                      width: 178.0,
                      //  (MediaQuery.of(context)
                      //             .size
                      //             .width -
                      //         (MediaQuery.of(context)
                      //                 .size
                      //                 .width /
                      //             3)) -
                      //     67,
                      child: Text(
                        cartData.productName ?? "Jewellery",
                        maxLines: 2,
                        style: const TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text("Qty: ",
                              style: Theme.of(context).textTheme.headline4),
                          const SizedBox(
                            width: 5.0,
                          ),
                          DropdownButton<String>(
                              value: cartData.quantity,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: quantityList.map((String option) {
                                return DropdownMenuItem(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (mounted) {
                                  setState(() {
                                    value.updateQuantity(
                                        cartData.cartProductid!, newValue!);
                                  });
                                }
                              })
                        ],
                      ),
                      const SizedBox(
                        width: 11.0,
                      ),
                      Row(
                        children: [
                          Text("Size: ",
                              style: Theme.of(context).textTheme.headline4),
                          const SizedBox(
                            width: 5.0,
                          ),
                          DropdownButton<String>(
                              value: selectedSize,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: sizeList.map((String option) {
                                return DropdownMenuItem(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (mounted) {
                                  setState(() {
                                    selectedSize = newValue!;
                                  });
                                }
                              })
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Expected Delivery : ",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Text(cartData.deliveryDate ?? "After 5 days",
                      style: Theme.of(context).textTheme.headline4)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    value.removeFromCart(cartData, cartData.cartProductid!);

                    value.removeFromCartId(cartData.cartProductid!);

                    print("CART IDS : ${value.cartProductIds}");
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 19.0,
                    ),
                  ),
                ),
              ],
            )
          ]),
        )),
      );
    }).toList();
  }

  void showCouponDialog(BuildContext context) {
    //TextEditingController textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              maxLines: 1,
              enabled: true,
              decoration: const InputDecoration(hintText: "Coupon code"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (context) => SearchPage()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffCC868A),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: const Text(
                    "Apply coupon",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  )),
            ),
          ]),
        );
      },
    );
  }
}
