import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/pages/coupon_list.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/shipping_page.dart';
import 'package:Tiara_by_TJ/views/widgets/button_widget.dart';

import 'package:Tiara_by_TJ/views/widgets/cart_total_row.dart';
import 'package:Tiara_by_TJ/views/widgets/label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//store totalafter applied coupon in  order provider
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

  Map<String, dynamic>? selectedCouponData;

  double calculateTotalPriceAfterApplyCoupon(double total,
      Map<String, dynamic>? selectedCouponData, CartProvider value) {
    //final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double totalAfterDiscount = 0.0;
    if (selectedCouponData!["discountString"].toString().contains("%")) {
      totalAfterDiscount =
          total - ((selectedCouponData["discountAmount"] / 100) * total);
    } else {
      totalAfterDiscount = total - selectedCouponData["discountAmount"];
    }

    print("calculateTotalPriceAfterApplyCoupon $totalAfterDiscount");

    print("mounted error might be below");
    value.setTotalAfterCouponApplied(totalAfterDiscount);
    print("mounted error might be above");
    return totalAfterDiscount;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    print("coupon deviceWidth / 50 ${deviceWidth / 50}");
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
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
                      ...getCartList(cartList, value, deviceWidth),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Offers & Benefits",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: deviceWidth > 600
                              //     ? deviceWidth / 30
                              //     : (deviceWidth / 24) - 2,
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletHeadingSize
                                  : 16.sp),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (value.selectedCouponData == null) {
                            selectedCouponData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CouponListPage(
                                      cartProductIds: value.cartProductIds,
                                      cartTotal: value.calculateTotalPrice()),
                                ));
                            value.setSelectedCouponData(selectedCouponData);
                            print(
                                "selectedCouponData != null ${selectedCouponData != null}");
                            if ( //true
                                selectedCouponData != null) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Image.asset(
                                      "assets/images/discount.png",
                                      color: Color(int.parse(
                                          "0xff${layoutDesignProvider.primary.substring(1)}")),
                                      width: deviceWidth > 600 ? 40.0 : 30.0,
                                      height: deviceWidth > 600 ? 40.0 : 30.0,
                                    ),
                                    content: Container(
                                      // color: Colors.red,
                                      height: deviceWidth > 600 ? 268 : 260,
                                      child: Column(
                                        children: [
                                          Text(
                                            "'${selectedCouponData!["couponcode"]}' applied",
                                            style: TextStyle(
                                              fontSize: deviceWidth > 600
                                                  ? deviceWidth / 33
                                                  : 17,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: selectedCouponData![
                                                          "discountString"]
                                                      .toString()
                                                      .contains("%")
                                                  ? [
                                                      TextSpan(
                                                          text: "You got "),
                                                      TextSpan(
                                                          text:
                                                              //    "discountString",
                                                              "${selectedCouponData!["discountString"]}",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  int.parse(
                                                                      "0xff${layoutDesignProvider.primary.substring(1)}")))),
                                                      TextSpan(
                                                          text:
                                                              " discount with this coupon!"),
                                                    ]
                                                  : [
                                                      TextSpan(
                                                          text:
                                                              "${selectedCouponData!["discountString"]}",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  int.parse(
                                                                      "0xff${layoutDesignProvider.primary.substring(1)}")))),
                                                      TextSpan(
                                                          text:
                                                              " saved with this coupon!")
                                                    ],
                                              style: TextStyle(
                                                  fontSize: deviceWidth > 600
                                                      ? (deviceWidth / 33) + 4
                                                      : 19.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          // Text(
                                          //   selectedCouponData![
                                          //               "discountString"]
                                          //           .toString()
                                          //           .contains("%")
                                          //       ? "You got ${selectedCouponData!["discountString"]} discount with this coupon!"
                                          //       : "${selectedCouponData!["discountString"]} saved with this coupon!",
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       fontSize: deviceWidth > 600
                                          //           ? (deviceWidth / 33) + 2
                                          //           : 22.0,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Text(
                                            "Woohoo! Your coupon is successfully applied!",
                                            style: TextStyle(
                                              fontSize: deviceWidth > 600
                                                  ? deviceWidth / 33
                                                  : 17,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffCC868A),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                child: Text(
                                                  "YAYY!",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletButtonTextSize
                                                          : Fontsizes
                                                              .buttonTextSize),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: value.selectedCouponData != null
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 227, 230),
                                    // border: Border.all(
                                    //     color: Color(int.parse("0xff${layoutDesignProvider.primary.substring(1)}"))),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 20.0,
                                      right: 20.0),
                                  title: Text(
                                    //"'couponcode' applied"
                                    "'${value.selectedCouponData!["couponcode"]}' applied",
                                    style: TextStyle(
                                        // color: Color(int.parse("0xff${layoutDesignProvider.primary.substring(1)}")),
                                        // fontSize: deviceWidth > 600
                                        //     ? deviceWidth / 35
                                        //     : 16.0,
                                        fontSize:
                                            deviceWidth > 600 ? 26.sp : 16.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  subtitle: Expanded(
                                    // height: 40.0,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: value.selectedCouponData![
                                                      "discountString"]
                                                  .toString()
                                                  .contains("%")
                                              ? " ₹ ${((value.selectedCouponData!["discountAmount"] / 100) * value.calculateTotalPrice()).round()}"
                                              : " ${value.selectedCouponData!["discountString"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: deviceWidth > 600
                                                  ? deviceWidth / 35
                                                  : 16.0,
                                              color: Color(int.parse(
                                                  "0xff${layoutDesignProvider.primary.substring(1)}"))),
                                        ),
                                        TextSpan(
                                          text: " saved on this order",
                                          style: TextStyle(
                                              fontSize: deviceWidth > 600
                                                  ? deviceWidth / 35
                                                  : 16.0,
                                              color: Colors.black),
                                        )
                                      ]),
                                      maxLines: 2,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      value.setSelectedCouponData(null);
                                      //   });
                                    },
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                          fontSize:
                                              deviceWidth > 600 ? 25.sp : 15.sp,
                                          color: Color(int.parse(
                                              "0xff${layoutDesignProvider.primary.substring(1)}"))),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                padding: EdgeInsets.symmetric(
                                    vertical: deviceWidth > 600 ? 10.0 : 0.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(int.parse(
                                            "0xff${layoutDesignProvider.primary.substring(1)}"))),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: ListTile(
                                  leading: Image.asset(
                                    "assets/images/discount.png",
                                    scale: deviceWidth > 600
                                        ? deviceWidth / 70
                                        : 20,
                                    color: Color(int.parse(
                                        "0xff${layoutDesignProvider.primary.substring(1)}")),
                                    // width: 30.0,
                                    // height: 30.0,
                                  ),
                                  title: Text(
                                    "Apply Coupon",
                                    style: TextStyle(
                                        color: Color(0xffCC868A),
                                        fontWeight: FontWeight.normal,
                                        // fontSize: deviceWidth > 600
                                        //     ? (deviceWidth / 33)
                                        //     : (deviceWidth / 23),
                                        fontSize:
                                            deviceWidth > 600 ? 26.sp : 16.sp),
                                  ),
                                  trailing: Icon(Icons.east_outlined,
                                      size: deviceWidth > 600
                                          ? deviceWidth / 25
                                          : 25,
                                      color: Color(int.parse(
                                          "0xff${layoutDesignProvider.primary.substring(1)}"))),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cart totals",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: deviceWidth > 600
                                  //     ? deviceWidth / 30
                                  //     : (deviceWidth / 24) - 2,
                                  fontSize: deviceWidth > 600
                                      ? Fontsizes.tabletHeadingSize
                                      : 16.sp),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            value.selectedCouponData != null
                                ? Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'No. of Items',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: deviceWidth > 600
                                                    //     ? deviceWidth / 30
                                                    //     : (deviceWidth / 27) - 1,
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletTableLabelTextSize
                                                        : Fontsizes
                                                            .tableLabelTextSize),
                                              ),
                                              Text(
                                                value.cart.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: deviceWidth > 600
                                                    //     ? deviceWidth / 30
                                                    //     : (deviceWidth / 27) - 1,
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletTableLabelTextSize
                                                        : Fontsizes
                                                            .tableLabelTextSize),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: deviceWidth > 600
                                                    //     ? deviceWidth / 35
                                                    //     : deviceWidth / 28,
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletTableLabelTextSize
                                                        : Fontsizes
                                                            .tableLabelTextSize),
                                              ),
                                              Text(
                                                  "₹ ${value.calculateTotalPrice()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Shipping charge',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize)),
                                              Text("Free",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(int.parse(
                                                          "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Discount',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize)),
                                              Text(
                                                  value.selectedCouponData![
                                                              "discountString"]
                                                          .toString()
                                                          .contains("%")
                                                      ? "- ₹ ${((value.selectedCouponData!["discountAmount"] / 100) * value.calculateTotalPrice()).round()}"
                                                      : "- ${value.selectedCouponData!["discountString"]}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize:
                                                          // deviceWidth > 600
                                                          //     ? deviceWidth / 33
                                                          //     : 17.0,

                                                          deviceWidth > 600
                                                              ? Fontsizes
                                                                  .tabletTableLabelTextSize
                                                              : Fontsizes
                                                                  .tableLabelTextSize,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Shipping insurance',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize)),
                                              Text("Free",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(int.parse(
                                                          "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 26.5.sp
                                                              : 16.5.sp)),
                                              Text(
                                                  value.selectedCouponData !=
                                                          null
                                                      ? "₹ ${(calculateTotalPriceAfterApplyCoupon(value.calculateTotalPrice(), value.selectedCouponData, value)).round()}"
                                                      : "₹ ${value.calculateTotalPrice().toString()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 26.5.sp
                                                              : 16.5.sp))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'No. of Items',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: deviceWidth > 600
                                                    //     ? deviceWidth / 30
                                                    //     : (deviceWidth / 27) - 1,
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletTableLabelTextSize
                                                        : Fontsizes
                                                            .tableLabelTextSize),
                                              ),
                                              Text(
                                                value.cart.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: deviceWidth > 600
                                                    //     ? deviceWidth / 30
                                                    //     : (deviceWidth / 27) - 1,
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletTableLabelTextSize
                                                        : Fontsizes
                                                            .tableLabelTextSize),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: deviceWidth > 600
                                                    //     ? deviceWidth / 35
                                                    //     : deviceWidth / 28,
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletTableLabelTextSize
                                                        : Fontsizes
                                                            .tableLabelTextSize),
                                              ),
                                              Text(
                                                  "₹ ${value.calculateTotalPrice()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Shipping charge',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize)),
                                              Text("Free",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(int.parse(
                                                          "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Shipping insurance',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize)),
                                              Text("Free",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(int.parse(
                                                          "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletTableLabelTextSize
                                                          : Fontsizes
                                                              .tableLabelTextSize))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Total',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 26.5.sp
                                                              : 16.5.sp)),
                                              Text(
                                                  "₹ ${value.calculateTotalPrice().toString()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //     : (deviceWidth / 27) - 1,
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 26.5
                                                              : 16.5.sp))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth > 600 ? 120.0 : 100.0,
                      ),
                    ]),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
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
                            fontSize: deviceWidth > 600
                                ? Fontsizes.tabletHeadingSize
                                : Fontsizes.headingSize,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Looks like you don't have added any jewelleries to your cart yet",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: deviceWidth > 600
                              ? Fontsizes.tabletTextFormInputFieldSize
                              : Fontsizes.textFormInputFieldSize,
                        ),
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
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 40.0),
                            child: Text(
                              "Continue Shopping",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: deviceWidth > 600
                                      ? Fontsizes.tabletButtonTextSize
                                      : Fontsizes.buttonTextSize),
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
                constraints:
                    BoxConstraints.expand(width: deviceWidth, height: 100),
                enableDrag: false,
                onClosing: () {},
                builder: (context) {
                  print(
                      "totalAfterCouponApplied ${value.totalAfterCouponApplied.round()}");

                  print(
                      "calculateTotalPrice ${value.calculateTotalPrice().round()}");
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value.selectedCouponData != null
                              ? "₹ ${value.totalAfterCouponApplied.round().toString()}"
                              : "₹ ${value.calculateTotalPrice().round().toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: deviceWidth > 600
                                ? Fontsizes.tabletHeadingSize
                                : 16.5.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final customerProvider =
                                Provider.of<CustomerProvider>(context,
                                    listen: false);
                            if (value.selectedCouponData != null) {
                              value.setIsCouponApplied(true);
                            } else {
                              value.setIsCouponApplied(false);
                            }
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
                                  builder: (context) => const ShippingPage()));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: deviceWidth > 600
                                ? deviceWidth / 4
                                : (deviceWidth / 2) - 50,
                            height: deviceWidth > 600 ? 60 : 50,
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 10.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}"))),
                            child: Text(
                              "PLACE ORDER",
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontSize: deviceWidth > 600 ? 23 : 17.0,
                                  fontSize: deviceWidth > 600
                                      ? Fontsizes.tabletButtonTextSize
                                      : 15.5.sp,
                                  fontWeight: FontWeight.bold),
                            ),
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
      List<CartProductModel> cartList, CartProvider value, double deviceWidth) {
    // print("mobile deviceWidth ${deviceWidth / 3.2}");
    double dimension = deviceWidth > 600 ? deviceWidth / 4 : deviceWidth / 3;
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    return cartList.map((cartData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
        child: Card(
            child: Container(
          height: deviceWidth > 600 ? dimension + 32 : dimension + 22,
          padding:
              deviceWidth > 600 ? EdgeInsets.all(15.0) : EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        cartData.imageUrl ?? Constants.defaultImageUrl,
                        width: dimension,
                        height: dimension,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(int.parse(
                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                            ),
                          );
                        },
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        print("spacing ${(constraints.maxHeight / 13)}");
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: deviceWidth > 600
                                    ? (deviceWidth / 1.8) + 12.0
                                    : (deviceWidth / 2) - 25,
                                child: Text(
                                  cartData.productName ?? "Jewellery",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: deviceWidth > 600
                                      //     ? deviceWidth / 28
                                      //     : (deviceWidth / 25) - 1,
                                      fontSize:
                                          deviceWidth > 600 ? 26.sp : 16.sp),
                                  // maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              SizedBox(height: deviceWidth > 600 ? 10 : 5),
                              Text(
                                "₹ ${cartData.price ?? 20000}",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    // fontSize: deviceWidth > 600
                                    //     ? (deviceWidth / 33) + 3
                                    //     : (deviceWidth / 28) + 1,
                                    fontSize:
                                        deviceWidth > 600 ? 25.5.sp : 15.5.sp),
                              ),
                              SizedBox(height: deviceWidth > 600 ? 10 : 0),
                              Container(
                                height: deviceWidth > 600
                                    ? (constraints.maxHeight / 6)
                                    : 28,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Qty: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              // fontSize: deviceWidth > 600
                                              //     ? deviceWidth / 30
                                              //     : (deviceWidth / 25) - 2,
                                              fontSize: deviceWidth > 600
                                                  ? 24.sp
                                                  : 14.sp),
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
                                                child: Text(
                                                  option,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //       : (deviceWidth / 25) - 2,
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 24.sp
                                                              : 14.sp),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (mounted) {
                                                setState(() {
                                                  value.updateQuantity(
                                                      cartData.cartProductid!,
                                                      newValue!);
                                                });
                                              }
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      width: deviceWidth > 600 ? 51 : 6,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Size: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              // fontSize: deviceWidth > 600
                                              //     ? deviceWidth / 30
                                              //      : (deviceWidth / 25) - 2,
                                              fontSize: deviceWidth > 600
                                                  ? 24.sp
                                                  : 14.sp),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        DropdownButton<String>(
                                            value: selectedSize,
                                            icon: const Icon(Icons
                                                .keyboard_arrow_down_rounded),
                                            items:
                                                sizeList.map((String option) {
                                              return DropdownMenuItem(
                                                value: option,
                                                child: Text(
                                                  option,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      // fontSize: deviceWidth > 600
                                                      //     ? deviceWidth / 30
                                                      //      : (deviceWidth / 25) - 2,
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 24.sp
                                                              : 14.sp),
                                                ),
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
                              ),
                              SizedBox(height: deviceWidth > 600 ? 10 : 2),
                              Text(
                                "Expected Delivery : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: deviceWidth > 600
                                    //     ? deviceWidth / 30
                                    //     : (deviceWidth / 25) - 2,
                                    fontSize:
                                        deviceWidth > 600 ? 24.5.sp : 14.5.sp),
                              ),
                              SizedBox(
                                  height: deviceWidth > 600
                                      ? (constraints.maxHeight / 33)
                                      : 1),
                              Text(
                                cartData.deliveryDate ?? "After 5 days",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    // fontSize:
                                    // deviceWidth > 600
                                    //     ? deviceWidth / 30
                                    //     : (deviceWidth / 25) - 2,
                                    fontSize:
                                        deviceWidth > 600 ? 24.5.sp : 14.5.sp),
                              )
                            ],
                          ),
                        );
                      },
                      //child:
                    ),
                  ],
                ),
                // SizedBox(width: 8.0,),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            value.removeFromCart(
                                cartData, cartData.cartProductid!);

                            value.removeFromCartId(cartData.cartProductid!);

                            print("CART IDS : ${value.cartProductIds}");
                          },
                          child: Container(
                            margin: deviceWidth > 600
                                ? EdgeInsets.only(right: 5.0, top: 5.0)
                                : EdgeInsets.all(0.0),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: deviceWidth > 600
                                  ? constraints.maxHeight / 8
                                  : constraints.maxHeight / 9,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  //  child:
                )
              ]),
        )),
      );
    }).toList();
  }

  // void showCouponDialog(BuildContext context) {
  //   //TextEditingController textEditingController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: Column(mainAxisSize: MainAxisSize.min, children: [
  //           TextFormField(
  //             maxLines: 1,
  //             enabled: true,
  //             decoration: const InputDecoration(hintText: "Coupon code"),
  //           ),
  //           const SizedBox(
  //             height: 20.0,
  //           ),
  //           GestureDetector(
  //             onTap: () {
  //               // Navigator.of(context).pushReplacement(
  //               //     MaterialPageRoute(
  //               //         builder: (context) => SearchPage()));
  //             },
  //             child: Container(
  //                 decoration: BoxDecoration(
  //                     color: const Color(0xffCC868A),
  //                     borderRadius: BorderRadius.circular(5.0)),
  //                 padding: const EdgeInsets.symmetric(
  //                     vertical: 10.0, horizontal: 20.0),
  //                 child: const Text(
  //                   "Apply coupon",
  //                   style: TextStyle(color: Colors.white, fontSize: 17.0),
  //                 )),
  //           ),
  //         ]),
  //       );
  //     },
  //   );
  // }
}
