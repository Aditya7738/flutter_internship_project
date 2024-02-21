import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/views/widgets/cart_total_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoldPlanDetail extends StatelessWidget {
  final OrderModel orderModel;
  GoldPlanDetail({super.key, required this.orderModel});

  // List<Map<String, dynamic>> tableData = [
  //   {"header": "MONTH", "row0": "1", "row10": "1"},
  //   {
  //     "header": "DATE OF PAYMENT",
  //     "row0": "February 19, 2024, 13:03:11",
  //     "row11": "February 19, 2024, 13:03:11"
  //   },
  //   {"header": "PAYMENT REF ID", "row0": "-", "row12": "-"},
  //   {"header": "GOLD CREDITED", "row3": "1.15 Grams", "row13": "1.15 Grams"},
  //   {
  //     "header": "MODE OF PAYMENT",
  //     "row0": "Online Payment From Website",
  //     "row14": "Online Payment From Website"
  //   },
  //   {"header": "AMOUNT PAID", "row0": "₹ 1000", "row15": "₹ 1000"}
  // ];

  List<Map<String, dynamic>> tableData = [
    {
      "row00": "1", "row10": "February 19, 2024, 13:03:11", "row20": "-", "row30": "1.15 Grams", "row40": "Online Payment From Website", "row50": "₹ 1000" 
    },
    {
      "row01": "2", "row11": "February 19, 2024, 13:10:20", "row21": "-", "row31": "1.15 Grams", "row41": "Online Payment From Website", "row51": "₹ 1000"
    }
  ];

  List<String> tableHeaders = [
    "MONTH",
    "DATE OF PAYMENT", "PAYMENT REF ID",
     "GOLD CREDITED", "MODE OF PAYMENT", "AMOUNT PAID"
  ];

  String getPlaneName() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "digi_plan_name") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getDescription() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "description") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPlanType() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "digi_plan_type") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPlanDescription() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "description") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPaymentDate() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "payment_date") {
        return DateFormat('MMMM dd, yyyy, HH:mm:ss')
            .format(DateTime.parse(orderModel.metaData[i].value!));
      }
    }
    return "";
  }

  String getPlanDuration() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "digi_plan_duration") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getGoldCredited() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "gold_gross") {
        return orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plan history"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Plan Name:",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("${getPlaneName()}",
                        style: TextStyle(
                          fontSize: 17.0,
                        )),
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
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(" ${getPlanType()}",
                        style: TextStyle(
                          fontSize: 17.0,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Plan Amount:",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("₹ ${orderModel.total}",
                        style: TextStyle(
                          fontSize: 17.0,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Date of joining:",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("${getPaymentDate()}",
                        style: TextStyle(
                          fontSize: 17.0,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Duration:",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("${getPlanDuration()} months",
                        style: TextStyle(
                          fontSize: 17.0,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Description:",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text("${getPlanDescription()}",
                    style: TextStyle(
                      fontSize: 17.0,
                    )),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Payment Details",
                  style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid)),
                  child: Column(
                    children: [
                      CartTotalRow(
                          label: 'Total Amount Paid',
                          value: "Digi Gold Plan",
                          showMoney: true),
                      const Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      CartTotalRow(
                          label: 'Gold Credited',
                          value: "${getGoldCredited()} gms",
                          showMoney: false),
                      const Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      CartTotalRow(
                        label: 'No. of months paid',
                        value: "0 / 12",
                        showMoney: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),

                // SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                //   child: Container(
                //     decoration: BoxDecoration(
                //    // color: Colors.red,
                //       border: Border.all(
                //           color: Colors.grey, style: BorderStyle.solid)),
                //     child: Column(
                //       children: [
                //         Row(
                //           children: [
                //             for(var header in tableHeaders)
                //             Container(
                //               width: 100,
                //               height: 50,
                //               alignment: Alignment.center,
                //               child: Text(header, style: TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 16
                //               ),),
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //   )
                // )
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid)),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tableHeaders.length,
                    itemBuilder: (context, index) {
                      int outerIndex = index;
                      // Map<String, dynamic> data = tableData[index];
                      return Container(
                        width: 110.0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: 110.0,
                                child: Text(
                                  tableHeaders[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ),
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),

                            // ...getTableHeaders(outerIndex)

                            ListView.builder(
                              itemCount: tableData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data = tableData[index];
                                return Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        height: 90.0,
                                        width: 110.0,
                                        child: Text(
                                          data["row$outerIndex$index"],
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                    Divider(
                                      height: 2.0,
                                      color: Colors.grey,
                                    ),
                                  ],
                                );
                                // return Text("hi");
                              },
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //       alignment: Alignment.center,
                            //       height: 80.0,
                            //       width: 110.0,
                            //       child: Text(
                            //         data["row$index"],
                            //         style: TextStyle(
                            //             // fontWeight: FontWeight.bold,
                            //             fontSize: 18),
                            //       )),
                            // ),
                            // Divider(
                            //   height: 2.0,
                            //   color: Colors.grey,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text(data["row1$index"],
                            //         style: TextStyle(
                            //             // fontWeight: FontWeight.bold,
                            //             fontSize: 18),),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> getTableHeaders(int outerIndex) {
    return tableData.map((e) {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              height: 80.0,
              width: 110.0,
              child: Text(
                e["row$outerIndex"],
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
          Divider(
            height: 2.0,
            color: Colors.grey,
          ),
        ],
      );

      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text("e",
      //       style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      // );
    }).toList();
  }
}

// Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text("tableHeaders[index]",
//                                       style: TextStyle(
//                                           fontSize: 17.0,
//                                           fontWeight: FontWeight.bold)))
