import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyOrderTab extends StatefulWidget {
  MyOrderTab({super.key});

  @override
  State<MyOrderTab> createState() => _MyOrderTabState();
}

class _MyOrderTabState extends State<MyOrderTab> {
  double shippingProgress = 0.0;
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

      for (var i = 0; i < ApiService.listOfOrders.length; i++) {
        if (ApiService.listOfOrders[i].metaData.isEmpty) {
          listOfCartOrders.add(ApiService.listOfOrders[i]);
        }
      }

      if (mounted) {
        setState(() {
          pageLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return orderProvider.isOrderCreating || pageLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.white,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      fontSize:
                                          deviceWidth > 600 ? 26.sp : 15.sp))
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
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Scrollbar(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              itemCount:
                                  //1,
                                  orderModel.lineItems.length,
                              itemBuilder: (context, index) {
                                LineItem order = orderModel.lineItems[index];

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
                                                      style:
                                                          BorderStyle.solid)),
                                              child: Image.network(
                                                order.image == null
                                                    ? Constants.defaultImageUrl
                                                    : order.image!.src == ""
                                                        ? Constants
                                                            .defaultImageUrl
                                                        : order.image!.src!,
                                                width: 100.0,
                                                height: 100.0,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    width: 90.0,
                                                    height: 87.0,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Colors.black,
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
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      20,
                                                  child: Text(
                                                    //" order.name!",
                                                    order.name!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            deviceWidth > 600
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
                                                              deviceWidth > 600
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
                                                              deviceWidth > 600
                                                                  ? 27.sp
                                                                  : 15.sp),
                                                    ),
                                                    Text(
                                                      // "order.sku",
                                                      order.sku ?? "sku",

                                                      style: TextStyle(
                                                          fontSize:
                                                              deviceWidth > 600
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
                                        fontSize:
                                            deviceWidth > 600 ? 27.sp : 15.5.sp,
                                      )),
                                  Text(
                                      //"orderModel.dateCreated",

                                      "(${DateHelper.dateFormatForOrder(orderModel.dateCreated!)})",
                                      style: TextStyle(
                                        fontSize:
                                            deviceWidth > 600 ? 25.sp : 13.5.sp,
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: const Color(0xffCC868A),
                                      trackHeight: 5.0,
                                      tickMarkShape:
                                          const RoundSliderTickMarkShape(
                                        tickMarkRadius: 4.0,
                                      ),
                                      thumbShape: const RoundSliderThumbShape(
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
                                        width: deviceWidth > 600 ? 180 : 80.0,
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
                                        width: deviceWidth > 600 ? 180 : 80.0,
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
