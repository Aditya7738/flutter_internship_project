import 'dart:convert';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/pages/gold_plan_detail.dart';
import 'package:Tiara_by_TJ/views/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyGoldPlanListItem extends StatefulWidget {
  final OrderModel orderModel;
  final List<OrderModel> allOrdersList;
  MyGoldPlanListItem(
      {super.key, required this.orderModel, required this.allOrdersList});

  @override
  State<MyGoldPlanListItem> createState() => _MyGoldPlanListItemState();
}

class _MyGoldPlanListItemState extends State<MyGoldPlanListItem> {
  bool isOrderCreating = false;

  String getPlaneName() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "digi_plan_name") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getPaymentDate() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "payment_date") {
        return DateFormat('MMMM dd, yyyy, HH:mm:ss')
            .format(DateTime.parse(widget.orderModel.metaData[i].value!));
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

  String getGoldGross() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "gold_gross") {
        return widget.orderModel.metaData[i].value!;
      }
    }
    return "";
  }

  String getDigiPlanType() {
    for (var i = 0; i < widget.orderModel.metaData.length; i++) {
      if (widget.orderModel.metaData[i].key == "digi_plan_type") {
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

  int getPlanId() {
    for (var element in widget.orderModel.lineItems) {
      return element.id ?? 0;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    print("widget.allOrdersList.length ${widget.allOrdersList.length}");
    print("int.parse(getPlanDuration()) ${int.parse(getPlanDuration())}");
    print(
        "widget.allOrdersList.length == int.parse(getPlanDuration()) ${widget.allOrdersList.length == int.parse(getPlanDuration())}");

    double deviceWidth = MediaQuery.of(context).size.width;

    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);

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
                        "₹ ${widget.orderModel.total}",
                        style: TextStyle(
                            fontSize: deviceWidth > 600 ? 28.0 : 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Image.asset(
                        "assets/images/gold_coin.png",
                        width: deviceWidth > 600 ? 34.0 : 24.0,
                        height: deviceWidth > 600 ? 34.0 : 24.0,
                      )
                    ],
                  ),
                  Container(
                      height: deviceWidth > 600 ? 43.0 : 33.0,
                      decoration: BoxDecoration(
                          color: widget.allOrdersList.length >=
                                  int.parse(getPlanDuration())
                              ? Colors.green
                              : Color.fromARGB(255, 81, 168, 239),
                          borderRadius: BorderRadius.circular(12.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.5, horizontal: 15.0),
                      child: Center(
                        child: Text(
                          widget.allOrdersList.length >=
                                  int.parse(getPlanDuration())
                              ? "Completed"
                              : "On going",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth > 600 ? 27.0 : 16.0,
                            //fontWeight: FontWeight.bold
                          ),
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
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getPlaneName(),
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0,
                              fontWeight: FontWeight.normal),
                          maxLines: 2,
                        )
                      ]),
                      TableRow(children: [
                        Text(
                          "Plan purchased date: ",
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getPaymentDate(),
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0,
                              fontWeight: FontWeight.normal),
                          maxLines: 2,
                        )
                      ]),
                      TableRow(children: [
                        Text(
                          "Duration: ",
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.allOrdersList.length}/${getPlanDuration()} months",
                          style: TextStyle(
                              fontSize: deviceWidth > 600 ? 27.0 : 17.0,
                              fontWeight: FontWeight.normal),
                          maxLines: 2,
                        )
                      ]),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoldPlanDetail(
                                orderModel: widget.orderModel,
                                allOrdersList: widget.allOrdersList),
                          ));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: Center(
                          child: Text(
                            "Details",
                            style: TextStyle(
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                fontSize: deviceWidth > 600 ? 28.0 : 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: widget.allOrdersList.length >=
                            int.parse(getPlanDuration())
                        ? () {}
                        : () async {
                            OrderProvider orderProvider =
                                Provider.of<OrderProvider>(context,
                                    listen: false);
                            CustomerProvider customerProvider =
                                Provider.of<CustomerProvider>(context,
                                    listen: false);

                            if (mounted) {
                              setState(() {
                                isOrderCreating = true;
                              });
                            }

                            List<Map<String, dynamic>> lineItems = [
                              {
                                "product_id": getPlanId(),
                                "name": getPlaneName(),
                                "quantity": 1,
                                "total": widget.orderModel.total,
                                "tax_class": "zero-rate",
                              },
                            ];

                            List<Map<String, dynamic>> metaData = [
                              {
                                "key": "virtual_order",
                                "value": "digigold",
                              },
                              {
                                "key": "gold_gross",
                                "value": getGoldGross(),
                              },
                              {
                                "key": "digi_plan_duration",
                                "value": getPlanDuration()
                              },
                              {
                                "key": "digi_plan_name",
                                "value": getPlaneName()
                              },
                              {
                                "key": "digi_plan_type",
                                "value": getDigiPlanType()
                              },
                              {"key": "description", "value": getDescription()},
                            ];

                            Map<String, String> billingData =
                                <String, String>{};
                            if (widget.orderModel.billing != null) {
                              billingData = {
                                "first_name":
                                    widget.orderModel.billing!.firstName!,
                                "last_name":
                                    widget.orderModel.billing!.lastName!,
                                "company": widget.orderModel.billing!.company!,
                                "country": widget.orderModel.billing!.country!,
                                "address_1":
                                    widget.orderModel.billing!.address1!,
                                "address_2":
                                    widget.orderModel.billing!.address2!,
                                "city": widget.orderModel.billing!.city!,
                                "state": widget.orderModel.billing!.state!,
                                "email": widget.orderModel.billing!.email!,
                                "phone": widget.orderModel.billing!.phone!,
                                "postcode": widget.orderModel.billing!.postcode!
                              };
                            } else {
                              billingData = {
                                "first_name": customerProvider.customerData[0]
                                        .containsKey("first_name")
                                    ? customerProvider.customerData[0]
                                        ["first_name"]
                                    : "",
                                "last_name": customerProvider.customerData[0]
                                        .containsKey("last_name")
                                    ? customerProvider.customerData[0]
                                        ["last_name"]
                                    : "",
                                "company": customerProvider.customerData[0]
                                        .containsKey("company")
                                    ? customerProvider.customerData[0]
                                        ["company"]
                                    : "",
                                "country": widget.orderModel.billing?.country ??
                                    "India",
                                "address_1": customerProvider.customerData[0]
                                        .containsKey("address_1")
                                    ? customerProvider.customerData[0]
                                        ["address_1"]
                                    : "",
                                "address_2": customerProvider.customerData[0]
                                        .containsKey("address_2")
                                    ? customerProvider.customerData[0]
                                        ["address_2"]
                                    : "",
                                "city": customerProvider.customerData[0]
                                        .containsKey("city")
                                    ? customerProvider.customerData[0]["city"]
                                    : "",
                                "state": widget.orderModel.billing?.state ?? "",
                                "email": customerProvider.customerData[0]
                                        .containsKey("digi_gold_billing_email")
                                    ? customerProvider.customerData[0]
                                        ["digi_gold_billing_email"]
                                    : "",
                                "phone": customerProvider.customerData[0]
                                        .containsKey("digi_gold_billing_phone")
                                    ? customerProvider.customerData[0]
                                        ["digi_gold_billing_phone"]
                                    : "",
                                "postcode": customerProvider.customerData[0]
                                        .containsKey("pincode")
                                    ? customerProvider.customerData[0]
                                        ["pincode"]
                                    : ""
                              };
                            }

                            orderProvider.setBillingData(billingData);
                            orderProvider.setLineItems(lineItems);
                            orderProvider.setMetaData(metaData);
                            orderProvider.setPrice(widget.orderModel.total!);
                            orderProvider.setCustomerId(
                                customerProvider.customerData[0]["id"]);

                            List<Map<String, dynamic>> razorpayOrderData =
                                await uiCreateRazorpayOrder(context);

                            if (mounted) {
                              setState(() {
                                isOrderCreating = false;
                              });
                            }

                            if (razorpayOrderData.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                  orderId: razorpayOrderData[0]["id"],
                                  fromCart: false,
                                  // cashFreeData: impCashFreeData
                                ),
                              ));
                            }
                          },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 34,
                        decoration: BoxDecoration(
                            color: widget.allOrdersList.length >=
                                    int.parse(getPlanDuration())
                                ? Color.fromARGB(255, 210, 162, 164)
                                : const Color(0xffCC868A),
                            borderRadius: BorderRadius.circular(12.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 9.0, horizontal: 20.0),
                        child: Center(
                          child: isOrderCreating
                              ? const SizedBox(
                                  height: 25.0,
                                  width: 25.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : Text(
                                  "Pay now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: deviceWidth > 600 ? 28.0 : 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> uiCreateRazorpayOrder(
      BuildContext context) async {
    List<Map<String, dynamic>> data = <Map<String, dynamic>>[];
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      final response = await ApiService.createRazorpayOrder();

      if (response != null) {
        String body = await response.stream.bytesToString();
        print("Razorpay Payment body $body");

        try {
          print("${body.runtimeType}");
          print("Razorpay JSON DECODE DATA $data");
          data.add(jsonDecode(body));
          return data;
        } catch (e) {
          print('Razorpay Error decoding: $e');
          return <Map<String, dynamic>>[];
        }
      }
    }
    return <Map<String, dynamic>>[];
  }
}
