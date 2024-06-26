import 'dart:ui';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlan;
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digigold_plan_bill.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/widgets/digi_gold_plan_subcard.dart';
import 'package:Tiara_by_TJ/views/widgets/price_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DigiGoldCard extends StatefulWidget {
  final DigiGoldPlan.DigiGoldPlanModel digiGoldPlan;

  const DigiGoldCard({super.key, required this.digiGoldPlan});

  @override
  State<DigiGoldCard> createState() => _DigiGoldCardState();
}

class _DigiGoldCardState extends State<DigiGoldCard> {
  String jeweller_contribution = "";
  bool isJewellerContributing = false;
  String termsConditions = "";
  bool checkBoxChecked = false;
  bool termsSeen = false;
  int planDuration = 0;

  bool isPlanAlreadyPurchased = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkIsJewellerContributing();
    getTermsConditions();

    for (var i = 0; i < widget.digiGoldPlan.metaData.length; i++) {
      if (widget.digiGoldPlan.metaData[i].key == "digi_plan_duration") {
        planDuration = int.parse(widget.digiGoldPlan.metaData[i].value);
      }
    }

    print("planDuration $planDuration");

    checkPlanPurchased();
  }

  bool planPurchasedChecking = false;

  checkPlanPurchased() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    print(
        "customerProvider.customerData.isNotEmpty ${customerProvider.customerData.isNotEmpty}");

    if (customerProvider.customerData.isNotEmpty) {
      print("customerId ${customerProvider.customerData[0]["id"]}");
      bool isThereInternet = await ApiService.checkInternetConnection(context);
      if (isThereInternet) {
        if (mounted) {
          setState(() {
            planPurchasedChecking = true;
          });
        }

        ApiService.listOfOrders.clear();

        await ApiService.fetchOrders(customerProvider.customerData[0]["id"], 1);

        List<OrderModel> listOfGoldPlans = <OrderModel>[];

        for (var i = 0; i < ApiService.listOfOrders.length; i++) {
          for (var j = 0; j < ApiService.listOfOrders[i].metaData.length; j++) {
            if (ApiService.listOfOrders[i].metaData[j].key == "virtual_order" &&
                ApiService.listOfOrders[i].metaData[j].value == "digigold") {
              listOfGoldPlans.add(ApiService.listOfOrders[i]);
            }
          }
        }

        for (OrderModel orderModel in listOfGoldPlans) {
          for (var element in orderModel.lineItems) {
            print("element.productId ${element.productId}");
            print("widget.digiGoldPlan.id ${widget.digiGoldPlan.id}");
            print(
                "element.productId == widget.digiGoldPlan.id ${element.productId == widget.digiGoldPlan.id}");
            if (element.productId == widget.digiGoldPlan.id) {
              if (mounted) {
                setState(() {
                  isPlanAlreadyPurchased = true;
                  planPurchasedChecking = false;
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  planPurchasedChecking = false;
                });
              }
            }
          }
        }
      }
    }
  }

  checkIsJewellerContributing() {
    for (var i = 0; i < widget.digiGoldPlan.metaData.length; i++) {
      if (widget.digiGoldPlan.metaData[i].key == "jeweller_contribution") {
        if (mounted) {
          setState(() {
            jeweller_contribution = widget.digiGoldPlan.metaData[i].value;
            isJewellerContributing = true;
          });
        }
      }
    }
  }

  getTermsConditions() {
    for (var i = 0; i < widget.digiGoldPlan.metaData.length; i++) {
      print(
          "widget.digiGoldPlan.metaData[i].key ${widget.digiGoldPlan.metaData[i].key == "terms_and_conditions"}");
      if (widget.digiGoldPlan.metaData[i].key == "terms_and_conditions") {
        if (mounted) {
          setState(() {
            termsConditions = widget.digiGoldPlan.metaData[i].value;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: true);
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: true);
    final digiGoldProvider =
        Provider.of<DigiGoldProvider>(context, listen: true);
    bool isCustomerDataEmpty = customerProvider.customerData.isEmpty;
    print("termsConditions $termsConditions");

    TextStyle labelHead = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: deviceWidth > 600 ? 24.sp : 16.5.sp,
    );
    TextStyle sublabelHead = TextStyle(
      fontSize: deviceWidth > 600 ? 24.sp : 16.5.sp,
    );
    return IgnorePointer(
      ignoring: isPlanAlreadyPurchased,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //true
              planPurchasedChecking
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 2.33,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: //Colors.red
                              Color(int.parse(
                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                        ),
                      ),
                    )
                  : isPlanAlreadyPurchased
                      ? Stack(
                          children: [
                            widget.digiGoldPlan.images.isNotEmpty
                                ? widget.digiGoldPlan.images[0].src != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          child: Image.network(
                                            widget.digiGoldPlan.images[0].src!,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.33,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ),
                                      )
                                    : DigiGoldPlanSubCard(
                                        price: widget.digiGoldPlan.price ?? "0",
                                        isPlanAlreadyPurchased:
                                            isPlanAlreadyPurchased,
                                      )
                                : DigiGoldPlanSubCard(
                                    price: widget.digiGoldPlan.price ?? "0",
                                    isPlanAlreadyPurchased:
                                        isPlanAlreadyPurchased,
                                  ),
                            Positioned(
                              top: 20.0,
                              left: 4.0,
                              right: 4.0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  "You have already purchased this plan",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          deviceWidth > 600 ? 25.sp : 15.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      : widget.digiGoldPlan.images.isNotEmpty
                          ? widget.digiGoldPlan.images[0].src != null
                              ? Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13.0),
                                    child: Image.network(
                                      fit: BoxFit.fill,
                                      //loadingBuilder
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.33,
                                      widget.digiGoldPlan.images[0].src!,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                )
                              : DigiGoldPlanSubCard(
                                  price: widget.digiGoldPlan.price != null
                                      ? widget.digiGoldPlan.price!.isEmpty
                                          ? "0"
                                          : widget.digiGoldPlan.price!
                                      : "0",
                                  isPlanAlreadyPurchased:
                                      isPlanAlreadyPurchased)
                          : DigiGoldPlanSubCard(
                              price: widget.digiGoldPlan.price != null
                                  ? widget.digiGoldPlan.price!.isEmpty
                                      ? "0"
                                      : widget.digiGoldPlan.price!
                                  : "0",
                              isPlanAlreadyPurchased: isPlanAlreadyPurchased,
                            ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.digiGoldPlan.name ?? "Jewellery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: deviceWidth > 600 ? 27.sp : 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Plan Type: ",
                            style: labelHead,
                          ),
                          Text(
                            "Amount",
                            style: sublabelHead,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Plan Duration: ",
                            style: labelHead,
                          ),
                          Text(
                            "$planDuration months",
                            style: sublabelHead,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Divider(
                        height: 30.0,
                      ),
                    ),
                    PriceInfo(
                        label: "You Pay Per Month: ",
                        price: widget.digiGoldPlan.price != null
                            ? widget.digiGoldPlan.price!.isNotEmpty
                                ? widget.digiGoldPlan.price!
                                : "0"
                            : "0"),
                    SizedBox(
                      height: 10.0,
                    ),
                    PriceInfo(
                        label: "Total Amount You Pay: ",
                        price: widget.digiGoldPlan.price != null
                            ? widget.digiGoldPlan.price!.isNotEmpty
                                ? "${int.parse(widget.digiGoldPlan.price!) * planDuration}"
                                : "0"
                            : "0"),
                    SizedBox(
                      height: 10.0,
                    ),
                    isJewellerContributing
                        ? PriceInfo(
                            label: "Jeweller Contribution: ",
                            price: jeweller_contribution)
                        : SizedBox(),
                    SizedBox(
                      height: 30.0,
                    ),
                    isJewellerContributing
                        ? PriceInfo(
                            label: "You Get Jewellery Worth: ",
                            price: widget.digiGoldPlan.price != null
                                ? widget.digiGoldPlan.price!.isNotEmpty
                                    ? "${int.parse(jeweller_contribution) + int.parse(widget.digiGoldPlan.price!) * planDuration}"
                                    : "0"
                                : "0")
                        : SizedBox(),
                    SizedBox(
                      height: 40.0,
                    ),
                    customerProvider.customerData.isEmpty
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  activeColor: Color(int.parse(
                                      "0xff${layoutDesignProvider.primary.substring(1)}")),
                                  checkColor: Colors.white,
                                  value: checkBoxChecked,
                                  onChanged: (value) {
                                    print("termsSeen2 ${termsSeen}");
                                    if (termsSeen) {
                                      if (mounted) {
                                        setState(() {
                                          checkBoxChecked = value ?? false;
                                        });
                                      }
                                      print(
                                          "checkBoxChecked ${checkBoxChecked}");
                                    }
                                  },
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        termsSeen = true;
                                      });
                                    }
                                    print("termsSeen1 ${termsSeen}");

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            alignment: Alignment.center,
                                            title: const Text(
                                              "Terms & Conditions",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: HtmlWidget(
                                              termsConditions,
                                              textStyle:
                                                  TextStyle(fontSize: 17.0),
                                            ));
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Terms & Conditions",
                                    style: TextStyle(
                                      fontSize:
                                          deviceWidth > 600 ? 25.sp : 16.sp,
                                    ),
                                  ))
                            ],
                          ),
                    SizedBox(
                      height: 50.0,
                    ),
                    customerProvider.customerData.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              // if (checkBoxChecked) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage(isComeFromCart: false),
                                  ));
                              // }
                            },
                            child: Container(
                                margin:
                                    EdgeInsets.only(left: 15.0, bottom: 5.0),
                                decoration:
                                    // checkBoxChecked
                                    //     ? BoxDecoration(
                                    //         color: Color(int.parse(
                                    //  "0xff${layoutDesignProvider.primary.substring(1)}")),
                                    //         borderRadius:
                                    //             BorderRadius.circular(5.0))
                                    //     :
                                    BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color: isPlanAlreadyPurchased
                                                ? Color.fromARGB(
                                                    255, 213, 167, 170)
                                                : Color(int.parse(
                                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  "LOGIN",
                                  style: checkBoxChecked
                                      ? TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              deviceWidth > 600 ? 22.sp : 17.sp
                                          // MediaQuery.of(context).size.width >600
                                          //     ? MediaQuery.of(context).size.width / 33
                                          //     : 17.0,

                                          )
                                      : TextStyle(
                                          color: isPlanAlreadyPurchased
                                              ? Color.fromARGB(
                                                  255,
                                                  213,
                                                  167,
                                                  170,
                                                )
                                              : Color(int.parse(
                                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              deviceWidth > 600 ? 22.sp : 17.sp
                                          // MediaQuery.of(context).size.width >600
                                          //     ? MediaQuery.of(context).size.width / 33
                                          //     : 17.0,

                                          ),
                                )),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (checkBoxChecked) {
                                digiGoldProvider
                                    .setDigiGoldPlanModel(widget.digiGoldPlan);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DigiGoldPlanOrderPage(
                                              digiGoldPlanModel:
                                                  widget.digiGoldPlan),
                                    ));
                              }
                            },
                            child: Container(
                                margin:
                                    EdgeInsets.only(left: 15.0, bottom: 5.0),
                                decoration: checkBoxChecked
                                    ? BoxDecoration(
                                        color: Color(int.parse(
                                            "0xff${layoutDesignProvider.primary.substring(1)}")),
                                        borderRadius:
                                            BorderRadius.circular(5.0))
                                    : BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color: isPlanAlreadyPurchased
                                                ? Color.fromARGB(
                                                    255, 213, 167, 170)
                                                : Color(int.parse(
                                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  "Buy Plan",
                                  style: checkBoxChecked
                                      ? TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              deviceWidth > 600 ? 22.sp : 17.sp
                                          // MediaQuery.of(context).size.width >600
                                          //     ? MediaQuery.of(context).size.width / 33
                                          //     : 17.0,

                                          )
                                      : TextStyle(
                                          color: isPlanAlreadyPurchased
                                              ? Color.fromARGB(
                                                  255,
                                                  213,
                                                  167,
                                                  170,
                                                )
                                              : Color(int.parse(
                                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              deviceWidth > 600 ? 22.sp : 17.sp
                                          // MediaQuery.of(context).size.width >600
                                          //     ? MediaQuery.of(context).size.width / 33
                                          //     : 17.0,

                                          ),
                                )),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
