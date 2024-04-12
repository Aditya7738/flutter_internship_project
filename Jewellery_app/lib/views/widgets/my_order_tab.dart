import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/orders_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrderTab extends StatefulWidget {
  MyOrderTab({super.key});

  @override
  State<MyOrderTab> createState() => _MyOrderTabState();
}

class _MyOrderTabState extends State<MyOrderTab> {
  bool pageLoading = false;

  bool isThereMoreOrders = false;

  bool isMoreOrderLoading = false;

  List<OrderModel> listOfCartOrders = <OrderModel>[];

  @override
  void initState() {
    super.initState();

    getOrders();
  }

  Future<void> getOrders() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    int customerId = customerProvider.customerData[0]["id"];

    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          pageLoading = true;
        });
      }

      ApiService.listOfOrders.clear();

      await ApiService.fetchOrders(customerId, 1);
      listOfCartOrders.clear();
      for (var i = 0; i < ApiService.listOfOrders.length; i++) {
        if (ApiService.listOfOrders[i].metaData.isEmpty) {
          if (ApiService.listOfOrders[i].status == "pending") {
            listOfCartOrders.add(ApiService.listOfOrders[i]);
          }
        }
      }

      if (mounted) {
        setState(() {
          pageLoading = false;
        });
      }
    }
  }

  Future<void> showConfirmationDialog(
      BuildContext context, double deviceWidth, OrderModel orderModel) async {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);

    var isOrderCancelled = await showDialog(
      context: context,
      builder: (context) {
        bool isOrderCancelling = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              alignment: Alignment.center,
              title: Text(
                "Do you really want to cancel order?",
                style: TextStyle(
                  color: Color(0xffCC868A),
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth > 600
                      ? deviceWidth / 29
                      : (deviceWidth / 25).sp,
                ),
              ),
              content: Text(
                "Please click on 'Confirm' button to cancel order or else click on 'Cancel'",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    // fontSize: (deviceWidth / 33) + 1.5,
                    fontSize: deviceWidth > 600 ? deviceWidth / 33 : 15.sp),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
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
                            fontSize: deviceWidth > 600 ? 25.sp : 17.sp),
                      )),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () async {
                    // orderProvider
                    //     .setIsOrderCancelling(
                    //         true);

                    setState(() {
                      isOrderCancelling = true;
                    });
                    await ApiService.cancelOrder(orderModel.id!);
                    setState(() {
                      isOrderCancelling = false;
                    });
                    // orderProvider
                    //     .setIsOrderCancelling(
                    //         false);

                    Navigator.pop(context, true);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(int.parse(
                              "0xff${layoutDesignProvider.primary.substring(1)}")),
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.symmetric(
                          vertical: deviceWidth > 600 ? 10.0 : 7.0,
                          horizontal: 20.0),
                      child: isOrderCancelling
                          ? SizedBox(
                              width: deviceWidth > 600 ? 90.sp : 80.sp,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              "Confirm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceWidth > 600 ? 25.sp : 17.sp),
                            )),
                )
              ],
            );
          },
        );
      },
    );

    if (isOrderCancelled) {
      getOrders();
    }

    return isOrderCancelled;
  }

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    print("listOfCartOrders ${listOfCartOrders.length}");
    return orderProvider.isOrderCreating || pageLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(int.parse(
                  "0xff${layoutDesignProvider.primary.substring(1)}")),
              color: Colors.white,
            ),
          )
        :
        //   true
        listOfCartOrders.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/no_orders.svg",
                          // width: 200,
                          height: deviceWidth > 600 ? 400 : 300,
                          colorFilter: ColorFilter.mode(
                              Color(int.parse(
                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                              BlendMode.srcIn)),

                      // Image.asset(
                      //   "assets/images/empty_wish_list.jpg",
                      //   width: 240.0,
                      //   height: 240.0,
                      // ),
                      // const SizedBox(
                      //   height: 40.0,
                      // ),
                      // Text(
                      //   "Your Wishlist is Empty",
                      //   textAlign: TextAlign.center,
                      //   maxLines: 2,
                      //   style: TextStyle(
                      //       fontSize: deviceWidth > 600
                      //           ? Fontsizes.tabletHeadingSize
                      //           : Fontsizes.headingSize,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Looks like you don't have purchased jewelleries yet",
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
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount:
                      // 1,
                      listOfCartOrders.length,
                  itemBuilder: (context, index) {
                    OrderModel orderModel = listOfCartOrders[index];

                    // double totalPrice = 0.0;

                    // for (var i = 0; i < orderModel.lineItems.length; i++) {
                    //   totalPrice += orderModel.lineItems[i].price!;
                    // }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Order No: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              // fontSize: (deviceWidth / 33) + 1.5,
                                              fontSize: deviceWidth > 600
                                                  ? 26.sp
                                                  : 15.sp)),
                                      Text(
                                          //"orderModel.id",
                                          orderModel.id.toString(),
                                          style: TextStyle(
                                              fontSize: deviceWidth > 600
                                                  ? 26.sp
                                                  : 15.sp))
                                    ],
                                  ),
                                  Text(
                                      // "₹ orderModel.total}",
                                      "₹ ${orderModel.total}",
                                      style: TextStyle(
                                          fontSize: deviceWidth > 600
                                              ? 26.sp
                                              : 15.sp))
                                ],
                              ),
                            ),
                            const Divider(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: deviceWidth > 600 ? 190 : 130.0,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Scrollbar(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  itemCount:
                                      //1,
                                      orderModel.lineItems.length,
                                  itemBuilder: (context, index) {
                                    LineItem order =
                                        orderModel.lineItems[index];

                                    return Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: deviceWidth > 600
                                                      ? 160.sp
                                                      : 120.sp,
                                                  width: deviceWidth > 600
                                                      ? 160.sp
                                                      : 120.sp,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          style: BorderStyle
                                                              .solid)),
                                                  child: Image.network(
                                                    order.image == null
                                                        ? layoutDesignProvider
                                                            .placeHolder
                                                        : order.image!.src == ""
                                                            ? layoutDesignProvider.placeHolder
                                                            : order.image!.src!,
                                                    width: 100.0,
                                                    height: 100.0,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 90.0,
                                                        height: 87.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Color(int.parse(
                                                              "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              20,
                                                      child: Text(
                                                        //" order.name!",
                                                        order.name!,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                deviceWidth >
                                                                        600
                                                                    ? 27.sp
                                                                    : 15.sp),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          // "₹ order.price",
                                                          "₹ ${order.price!.toInt().toString()}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  deviceWidth >
                                                                          600
                                                                      ? 27.sp
                                                                      : 15.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Sku: ",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  deviceWidth >
                                                                          600
                                                                      ? 27.sp
                                                                      : 15.sp),
                                                        ),
                                                        Text(
                                                          // "order.sku",
                                                          order.sku ?? "sku",

                                                          style: TextStyle(
                                                              fontSize:
                                                                  deviceWidth >
                                                                          600
                                                                      ? 27.sp
                                                                      : 15.sp),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ]),

                                          //const Icon(Icons.chevron_right_outlined)
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Divider(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Order Received ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: deviceWidth > 600
                                                ? 27.sp
                                                : 15.5.sp,
                                          )),
                                      Text(
                                          //"orderModel.dateCreated",

                                          "(${DateHelper.dateFormatForOrder(orderModel.dateCreated!)})",
                                          style: TextStyle(
                                            fontSize: deviceWidth > 600
                                                ? 25.sp
                                                : 13.5.sp,
                                          ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor:
                                              const Color(0xffCC868A),
                                          trackHeight: 5.0,
                                          tickMarkShape:
                                              const RoundSliderTickMarkShape(
                                            tickMarkRadius: 4.0,
                                          ),
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 7.0),
                                          activeTickMarkColor: Colors.black,
                                          inactiveTickMarkColor: Colors.white,
                                        ),
                                        child: Slider(
                                          divisions: 2,
                                          activeColor: const Color(0xffCC868A),
                                          value: 0.5,
                                          onChanged: (value) {},
                                          min: 0.0,
                                          max: 1.0,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:
                                                deviceWidth > 600 ? 180 : 80.0,
                                            child: Text(
                                              // "Placed on orderModel on getCurrentDateIn",  maxLines: 5,
                                              "Placed on \n${DateHelper.dateFormatForOrder(orderModel.dateCreated!)}",
                                              style: TextStyle(
                                                fontSize: deviceWidth > 600
                                                    ? 26.sp
                                                    : 12.5.sp,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                deviceWidth > 600 ? 180 : 80.0,
                                            child: Text(
                                              //  "Expected Delivery on getCurrentDateInWords",
                                              "Expected Delivery on ${DateHelper.getCurrentDateInWords()}",
                                              maxLines: 5,
                                              style: TextStyle(
                                                fontSize: deviceWidth > 600
                                                    ? 26.sp
                                                    : 12.5.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            right:
                                                deviceWidth > 600 ? 20.0 : 10.0,
                                            bottom: deviceWidth > 600
                                                ? 20.0
                                                : 10.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                // bool isOrderCancelled =
                                                //     await showDialog(
                                                //   context: context,
                                                //   builder: (context) {},
                                                // );

                                                // print(
                                                //     "isOrderCancelled $isOrderCancelled");
                                                // if (isOrderCancelled) {
                                                //   getOrders();
                                                // }

                                                await showConfirmationDialog(
                                                    context,
                                                    deviceWidth,
                                                    orderModel);
                                              },
                                              child: Text(
                                                "Cancel order",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: deviceWidth > 600
                                                        ? 33.sp
                                                        : (Fontsizes
                                                                .buttonTextSize)
                                                            .sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
  }
}
