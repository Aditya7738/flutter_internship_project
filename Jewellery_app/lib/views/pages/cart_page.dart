import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/views/pages/search_page.dart';
import 'package:jwelery_app/views/pages/shipping_page.dart';
import 'package:jwelery_app/views/widgets/cart_app_bar.dart';
import 'package:jwelery_app/views/widgets/cart_total_row.dart';
import 'package:jwelery_app/views/widgets/label_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final cart = cartProvider.cart;

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

    return Scaffold(
      appBar: const CartAppBar(
        title: 'Cart',
        forCart: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Consumer<CartProvider>(builder: (context, value, child) {
          var cartList = value.cart;
          if (cartList.isNotEmpty) {
            // value.calculateTotalPrice();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Scrollbar(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              final cartData = cartList[index];
                              return Card(
                                  child: Row(children: [
                                Image.network(
                                  cartData.imageUrl ?? Strings.defaultImageUrl,
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 170,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 200,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        3)) -
                                                44,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/rupee.png",
                                                  width: 19.0,
                                                  height: 17.0,
                                                ),
                                                Text(
                                                  cartData.price ?? "20,000",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                value.removeFromCart(cartData);

                                                value.removeFromCartId(
                                                    cartData.cartProductid!);

                                                print(
                                                    "CART IDS : ${value.cartProductIds}");
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3)) -
                                              45,
                                          child: Text(
                                            cartData.productName ?? "Jewellery",
                                            
                                            style:
                                                const TextStyle(fontSize: 16.0),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          )),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const LabelWidget(
                                                label: "Qty: ",
                                                fontSize: 16.0,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              DropdownButton<String>(
                                                  value: cartData.quantity,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down_rounded),
                                                  items: quantityList
                                                      .map((String option) {
                                                    return DropdownMenuItem(
                                                      value: option,
                                                      child: Text(option),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      value.updateQuantity(
                                                          cartData
                                                              .cartProductid!,
                                                          newValue!);
                                                    });
                                                  })
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          Row(
                                            children: [
                                              const LabelWidget(
                                                label: "Size: ",
                                                fontSize: 16.0,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              DropdownButton<String>(
                                                  value: selectedSize,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down_rounded),
                                                  items: sizeList
                                                      .map((String option) {
                                                    return DropdownMenuItem(
                                                      value: option,
                                                      child: Text(option),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedSize = newValue!;
                                                    });
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Expected Delivery : ",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      Text(
                                        cartData.deliveryDate ?? "After 5 days",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      )
                                    ],
                                  ),
                                ),
                              ]));
                            }),
                      ),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: const Text(
                          "Apply coupon",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          showCouponDialog(context);
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    const Text(
                      "Cart totals",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, style: BorderStyle.solid)),
                      child: Column(
                        children: [
                          CartTotalRow(
                              label: 'Subtotal',
                              value: value.calculateTotalPrice().toString(),
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
                            value: value.calculateTotalPrice().toString(),
                            showMoney: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 70.0,
                    ),

                    // Container(
                    //     decoration: BoxDecoration(
                    //         color: Color(0xffCC868A),
                    //         borderRadius: BorderRadius.circular(5.0)),
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10.0, horizontal: 20.0),
                    //     child: const Text(
                    //       "Proceed to checkout",
                    //       style: TextStyle(color: Colors.white, fontSize: 17.0),
                    //     )),

                    // InkWell(
                    //   child: const Text(
                    //     "Save & Continue Shopping",
                    //     style: TextStyle(decoration: TextDecoration.underline),
                    //   ),
                    //   onTap: () {
                    //     Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(builder: (context) => SearchPage()));
                    //   },
                    // ),
                  ]),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/empty_shopping_cart.png",
                      width: 200.0,
                      height: 200.0,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    const Text(
                      "Your Shopping Bag is Empty",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: const Text(
                            "Continue Shopping",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          )),
                    )
                  ],
                ),
              ),
            );
          }
        })),
      ),
      floatingActionButton: cart.isNotEmpty
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ShippingPage()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffCC868A),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: const Text(
                    "Proceed to checkout",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  )),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
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
