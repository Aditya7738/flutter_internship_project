import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/views/widgets/cart_total_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';

class GoldPlanDetail extends StatefulWidget {
  final OrderModel orderModel;
  final List<OrderModel> allOrdersList;
  GoldPlanDetail(
      {super.key, required this.orderModel, required this.allOrdersList});

  @override
  State<GoldPlanDetail> createState() => _GoldPlanDetailState();
}

class _GoldPlanDetailState extends State<GoldPlanDetail> {
  String getPlaneName() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "digi_plan_name") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getDescription() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "description") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPaymentMethod() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "payment_method") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPaymentMethodFromList(OrderModel orderModel) {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "payment_method") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPaymentRefId() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "payment_ref_id") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPaymentRefIdFromList(OrderModel orderModel) {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "payment_ref_id") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPlanType() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "digi_plan_type") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPlanDescription() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "description") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "Description";
  }

  String getPaymentDate() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "payment_date") {
        return DateFormat('MMMM dd, yyyy')
            .format(DateTime.parse(widget.orderModel.metaData[i].value!));
      }
    }
    return "";
  }

  bool isJewellerContributing = false;

  String jewellerContribution = "";

  getJewellerContribution() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      print(
          "widget.orderModel.metaData[i].key == jeweller_contribution ${widget.orderModel.metaData[i].key == "jeweller_contribution"}");

      if (widget.orderModel.metaData[i].key == "jeweller_contribution") {
        print(
            "widget.orderModel.metaData[i].value!.isNotEmpty ${widget.orderModel.metaData[i].value!.isNotEmpty}");
        if (widget.orderModel.metaData[i].value!.isNotEmpty) {
          setState(() {
            isJewellerContributing = true;
            jewellerContribution = widget.orderModel.metaData[i].value!;
          });
        }
      }
    }
  }

  String getPaymentDateFromList(OrderModel orderModel) {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "payment_date") {
        return DateFormat('MMMM dd, yyyy')
            .format(DateTime.parse(orderModel.metaData[i].value!));
      }
    }
    return "";
  }

  String getPlanDuration() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "digi_plan_duration") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getGoldCredited() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "gold_gross") {
        if (widget.orderModel.metaData[i].value! == "") {
          return "0";
        } else {
          return widget.orderModel.metaData[i].value!;
        }
      }
    }
    return "0";
  }

  String getGoldCreditedFromList(OrderModel orderModel) {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "gold_gross") {
        if (orderModel.metaData[i].value! == "") {
          return "0";
        } else {
          return orderModel.metaData[i].value!;
        }
      }
    }
    return "0";
  }

  String getTotalGoldCredited() {
    print("${widget.allOrdersList.length * double.parse(getGoldCredited())}");
    return "${widget.allOrdersList.length * double.parse(getGoldCredited())}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getDates();
    sortOrderListByPaymentDate();

    getJewellerContribution();
  }

  sortOrderListByPaymentDate() {
    widget.allOrdersList.sort(
      (a, b) {
        DateTime dateA = DateTime.now();
        for (var i = 0; i < a.metaData.length; i++) {
          if (a.metaData[i].key == "payment_date") {
            dateA = DateTime.parse(a.metaData[i].value!);
            print("dateA ${dateA.toString()}");
          }
        }

        DateTime dateB = DateTime.now();
        for (var i = 0; i < b.metaData.length; i++) {
          if (b.metaData[i].key == "payment_date") {
            dateB = DateTime.parse(b.metaData[i].value!);
            print("dateB ${dateB.toString()}");
          }
        }

        return dateA.compareTo(dateB);
      },
    );

    for (var i = 0; i < widget.allOrdersList.length; i++) {
      for (var j = 0; j < widget.allOrdersList[i].metaData.length; j++) {
        if (widget.allOrdersList[i].metaData[i].key == "payment_date") {
          print(
              "payment_dates$i ${DateTime.parse(widget.orderModel.metaData[i].value!)}");
        }
      }
    }
  }

  // // getDates() {
  // //   for (var i = 0; i < widget.allOrdersList.length; i++) {
  // //     for (var j = 0; j < widget.allOrdersList[i].metaData.length; j++) {
  // //       if (widget.allOrdersList[i].metaData[i].key == "payment_date") {
  // //         print(
  // //             "payment_dates$i ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.orderModel.metaData[i].value!))}");
  // //       }
  // //     }
  // //   }
  // // }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    print("isJewellerContributing $isJewellerContributing");
    return Scaffold(
        appBar: AppBar(
          title: Text("Plan history"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(deviceWidth > 600 ? 30.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Text(
                //       "Plan Name:",
                //       style: TextStyle(
                //           fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     SizedBox(
                //       width: 5.0,
                //     ),
                //     Text("${getPlaneName()}",
                //         style: TextStyle(
                //             fontSize: deviceWidth > 600 ? 32.0 : 17.0,
                //             fontWeight: FontWeight.normal)),
                //   ],
                // ),
                deviceWidth > 600
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/gold_coin.png",
                                width: deviceWidth > 600 ? 74.0 : 34.0,
                                height: deviceWidth > 600 ? 74.0 : 34.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text("${getPlaneName()}",
                                  style: TextStyle(
                                      fontSize:
                                          deviceWidth > 600 ? 32.sp : 17.sp,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Plan Type:",
                                style: TextStyle(
                                    fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(" ${getPlanType()}",
                                  style: TextStyle(
                                      fontSize: deviceWidth > 600 ? 32.0 : 17.0,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/gold_coin.png",
                                width: deviceWidth > 600 ? 74.0 : 34.0,
                                height: deviceWidth > 600 ? 74.0 : 34.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text("${getPlaneName()}",
                                  style: TextStyle(
                                      fontSize:
                                          deviceWidth > 600 ? 32.sp : 17.sp,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Plan Type:",
                                style: TextStyle(
                                    fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(" ${getPlanType()}",
                                  style: TextStyle(
                                      fontSize: deviceWidth > 600 ? 32.0 : 17.0,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Description:",
                  style: TextStyle(
                      fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                HtmlWidget("<p>${getPlanDescription()}</p>",
                    textStyle: TextStyle(
                        fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                        fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 10.0,
                ),

//////////////////////////////////////////////////////////////////////////////////

                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.all(deviceWidth > 600 ? 36.0 : 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Date of joining:",
                                  style: TextStyle(
                                      fontSize: deviceWidth > 600 ? 27.0 : 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("${getPaymentDate()}",
                                    style: TextStyle(
                                        fontSize:
                                            deviceWidth > 600 ? 30.0 : 16.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Duration:",
                                    style: TextStyle(
                                        fontSize:
                                            deviceWidth > 600 ? 27.0 : 13.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("${getPlanDuration()} months",
                                      style: TextStyle(
                                          fontSize:
                                              deviceWidth > 600 ? 30.0 : 16.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(deviceWidth > 600 ? 36.0 : 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Total amount paid:",
                                  style: TextStyle(
                                      fontSize: deviceWidth > 600 ? 27.0 : 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "₹ ${widget.allOrdersList.length * int.parse(widget.orderModel.total!)}",
                                    style: TextStyle(
                                        fontSize:
                                            deviceWidth > 600 ? 30.0 : 16.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Gold Credited",
                                  style: TextStyle(
                                      fontSize: deviceWidth > 600 ? 27.0 : 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text("${getTotalGoldCredited()} gms",
                                    style: TextStyle(
                                        fontSize:
                                            deviceWidth > 600 ? 30.0 : 16.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(deviceWidth > 600 ? 36.0 : 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "No. of months paid:",
                                  style: TextStyle(
                                      fontSize: deviceWidth > 600 ? 27.0 : 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "${widget.allOrdersList.length} / ${getPlanDuration()}",
                                    style: TextStyle(
                                        fontSize:
                                            deviceWidth > 600 ? 30.0 : 16.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            isJewellerContributing
                                ? deviceWidth > 600
                                    ? Column(
                                        children: [
                                          Text(
                                            "Jeweller contribution on last month:",
                                            style: TextStyle(
                                                fontSize: deviceWidth > 600
                                                    ? 27.0
                                                    : 13.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text("₹ $jewellerContribution",
                                              style: TextStyle(
                                                  fontSize: deviceWidth > 600
                                                      ? 30.0
                                                      : 16.0,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    : Container(
                                      width: 180,
                                      child: Column(
                                          children: [
                                            Text(
                                              "Jeweller contribution on last month:",
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: deviceWidth > 600
                                                      ? 27.0
                                                      : 13.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text("₹ $jewellerContribution",
                                                style: TextStyle(
                                                    fontSize: deviceWidth > 600
                                                        ? 30.0
                                                        : 16.0,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                    )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /////////////////////////////////////////////////////////////
                // Container(
                //   width: deviceWidth,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Plan Name: ",
                //         style: TextStyle(
                //             fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       Text("${getPlaneName()}",
                //           style: TextStyle(
                //               fontSize: deviceWidth > 600 ? 32.0 : 17.0,
                //               fontWeight: FontWeight.normal)),
                //     ],
                //   ),
                // ),

                // SizedBox(
                //   height: 10.0,
                // ),
                // Container(
                //   width: deviceWidth,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Plan Type:",
                //         style: TextStyle(
                //             fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       Text(" ${getPlanType()}",
                //           style: TextStyle(
                //               fontSize: deviceWidth > 600 ? 32.0 : 17.0,
                //               fontWeight: FontWeight.normal)),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // // Container(
                // //   width: MediaQuery.of(context).size.width,
                // //   child: Row(
                // //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // //     children: [
                // //       Text(
                // //         "Plan Amount:",
                // //         style: TextStyle(
                // //             fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                // //             fontWeight: FontWeight.bold),
                // //       ),
                // //       SizedBox(
                // //         width: 5.0,
                // //       ),
                // //       Text("₹ ${widget.orderModel.total}",
                // //           style: TextStyle(
                // //               fontSize: deviceWidth > 600 ? 32.0 : 17.0,
                // //               fontWeight: FontWeight.normal)),
                // //     ],
                // //   ),
                // // ),
                // // SizedBox(
                // //   height: 10.0,
                // // ),
                // // true
                // isJewellerContributing
                //     ? Column(
                //         children: [
                //           Container(
                //             width: deviceWidth,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   "Jeweller contribution on last month: ",
                //                   maxLines: 2,
                //                   style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //                 SizedBox(
                //                   width: 5.0,
                //                 ),
                //                 Text(
                //                   "₹ 1000",
                //                   //"₹ $jewellerContribution",
                //                   style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //                       fontWeight: FontWeight.normal),
                //                 )
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10.0,
                //           ),
                //         ],
                //       )
                //     : SizedBox(),
                // Container(
                //   width: deviceWidth,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Date of joining:",
                //         style: TextStyle(
                //             fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       SizedBox(
                //         width: 5.0,
                //       ),
                //       Text("${getPaymentDate()}",
                //           style: TextStyle(
                //               fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //               fontWeight: FontWeight.normal)),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // Container(
                //   width: deviceWidth,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Duration:",
                //         style: TextStyle(
                //             fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       Text("${getPlanDuration()} months",
                //           style: TextStyle(
                //               fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //               fontWeight: FontWeight.normal)),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // Text(
                //   "Description:",
                //   style: TextStyle(
                //       fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 5.0,
                // ),
                // HtmlWidget("<p>${getPlanDescription()}</p>",
                //     textStyle: TextStyle(
                //         fontSize: deviceWidth > 600 ? 32.0 : 18.0,
                //         fontWeight: FontWeight.normal)),
                // SizedBox(
                //   height: 15.0,
                // ),
                // Text(
                //   "Payment Details",
                //   style: TextStyle(
                //       fontSize: deviceWidth > 600 ? 32.0 : 19.0,
                //       fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // Container(
                //   padding: const EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //           color: Colors.grey, style: BorderStyle.solid)),
                //   child: Column(
                //     children: [
                //       //show total amounnt of payments, credited gold
                //       CartTotalRow(
                //           label: 'Total Amount Paid',
                //           value:
                //               "${widget.allOrdersList.length * int.parse(widget.orderModel.total!)}",
                //           showMoney: true),
                //       const Divider(
                //         height: 15.0,
                //         color: Colors.grey,
                //       ),
                //       CartTotalRow(
                //           label: 'Gold Credited',
                //           value: "${getTotalGoldCredited()} gms",
                //           showMoney: false),
                //       const Divider(
                //         height: 15.0,
                //         color: Colors.grey,
                //       ),
                //       CartTotalRow(
                //         label: 'No. of months paid',
                //         value:
                //             "${widget.allOrdersList.length} / ${getPlanDuration()}",
                //         showMoney: false,
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 30.0,
                ),
                ...getPlanPayments(deviceWidth)
              ],
            ),
          ),
        ));
  }

  List<Widget> getPlanPayments(double deviceWidth) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < widget.allOrdersList.length; i++) {
      OrderModel orderModel = widget.allOrdersList[i];
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Month ${i + 1}",
                      style: TextStyle(
                          fontSize: deviceWidth > 600 ? 29.0 : 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${getPaymentDateFromList(orderModel)}",
                      style: TextStyle(
                          fontSize: deviceWidth > 600 ? 29.0 : 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                ),
                Column(
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          Text(
                            "Payment Ref ID: ",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 28.0 : 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${getPaymentRefIdFromList(orderModel)}",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 28.0 : 16.0,
                                fontWeight: FontWeight.normal),
                            maxLines: 2,
                          )
                        ]),
                        TableRow(children: [
                          Text(
                            "Mode of payment: ",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 28.0 : 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${getPaymentMethodFromList(orderModel)}",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 28.0 : 16.0,
                                fontWeight: FontWeight.normal),
                            maxLines: 2,
                          )
                        ]),
                        TableRow(children: [
                          Text(
                            "Amount paid: ",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 28.0 : 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹ ${widget.orderModel.total}",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 28.0 : 16.0,
                                fontWeight: FontWeight.normal),
                            maxLines: 2,
                          )
                        ]),
                      ],
                    )
                  ],
                ),
                Divider(
                  thickness: 1.0,
                ),
                Row(
                  children: [
                    Text(
                      "Gold credited: ",
                      style:
                          TextStyle(fontSize: deviceWidth > 600 ? 28.0 : 18.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      getGoldCreditedFromList(orderModel),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: deviceWidth > 600 ? 29.0 : 17.0,
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth > 600 ? 7.0 : 5.0,
                    ),
                    Image.asset(
                      "assets/images/gold_coin.png",
                      width: deviceWidth > 600 ? 34.0 : 24.0,
                      height: deviceWidth > 600 ? 34.0 : 24.0,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ));
    }
    return widgets;
  }
}
