import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/views/pages/gold_plan_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyGoldPlanListItem extends StatelessWidget {
  final OrderModel orderModel;
  MyGoldPlanListItem({super.key, required this.orderModel});

  String getPlaneName() {
    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "digi_plan_name") {
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

  String getCurrentMonthIndexPlanWise() {
    // DateFormat format = DateFormat("MMMM d, yyyy, HH:mm:ss");

    for (var i = 0; i < orderModel.metaData.length; i++) {
      if (orderModel.metaData[i].key == "payment_date") {
        DateTime paymentDateTime =
            DateTime.parse(orderModel.metaData[i].value!);
        print("getPaymentDate $paymentDateTime");

        DateTime currentDate = DateTime.now();
        int diffMonths = (currentDate.year - paymentDateTime.year) * 12 +
            currentDate.month -
            paymentDateTime.month;
        print("getPlanDuration int ${int.parse(getPlanDuration())}");
        print("currentMonthIndex ${diffMonths % int.parse(getPlanDuration())}");

        int currentMonthIndex = diffMonths % int.parse(getPlanDuration());

        if (currentMonthIndex < 0) {
          currentMonthIndex += int.parse(getPlanDuration());
        }

        return currentMonthIndex.toString();
      }
    }
    return "";
  }

  // getData() {
  //   for (var i = 0; i < orderModel.metaData.length; i++) {
  //     if (orderModel.metaData[i].key == "digi_plan_name") {
  //       planName = orderModel.metaData[i].value!;
  //     }

  //     if (orderModel.metaData[i].key == "payment_date") {
  //       paymentDate = orderModel.metaData[i].value!;
  //     }

  //     if (orderModel.metaData[i].key == "digi_plan_duration") {
  //       planDuration = orderModel.metaData[i].value!;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹ ${orderModel.total}",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Image.asset(
                        "assets/images/gold_coin.png",
                        width: 24.0,
                        height: 24.0,
                      )
                    ],
                  ),
                  Container(
                      height: 30.0,

                      // height: 40.0,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 106, 181, 241),
                          borderRadius: BorderRadius.circular(12.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.5, horizontal: 15.0),
                      child: Center(
                        child: const Text(
                          "On going",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
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
                          "Plan name: ",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getPlaneName(),
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                          maxLines: 2,
                        )
                      ]),
                      TableRow(children: [
                        Text(
                          "Payment date: ",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getPaymentDate(),
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                          maxLines: 2,
                        )
                      ]),
                      TableRow(children: [
                        Text(
                          "Duration: ",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${getCurrentMonthIndexPlanWise()}/${getPlanDuration()} months",
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                          maxLines: 2,
                        )
                      ]),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
             
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GoldPlanDetail(orderModel: orderModel),));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2 - 34,
                        // height: 40.0,
                        decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0,
                                          color: Theme.of(context).primaryColor,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(12.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: Center(
                          child: Text(
                            "Details",
                            style: TextStyle(
                                color:  Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                      SizedBox(width: 10.0,),
                      Container(
                   width: MediaQuery.of(context).size.width/2 - 34,
                      // height: 40.0,
                      decoration: BoxDecoration(
                          color: const Color(0xffCC868A),
                          borderRadius: BorderRadius.circular(12.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 9.0, horizontal: 20.0),
                      child: Center(
                        child: const Text(
                          "Pay now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
