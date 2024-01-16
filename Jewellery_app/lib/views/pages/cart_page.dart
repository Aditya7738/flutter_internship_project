import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/views/widgets/cart_app_bar.dart';
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
      appBar: const CartAppBar(title: 'Cart', forCart: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<CartProvider>(builder: (context, value, child) {
              var cartList = value.cart;
              if (cartList.isNotEmpty) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        (kToolbarHeight * 3),
                    child: Scrollbar(
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
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Text(
                                      cartData.productName ?? "Jewellery",
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                   
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
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                   

                                                        value.updateQuantity(cartData.cartProductid!, newValue!);


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
                                                onChanged: (String? newValue) {
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
                    ));
              }
              return const Text("Cart is emplty");
            }
            )
          ],
        ),
      ),
    );
  }
}
