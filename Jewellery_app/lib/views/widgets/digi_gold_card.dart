import 'dart:ui';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlan;
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digigold_plan_bill.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/widgets/digi_gold_plan_subcard.dart';
import 'package:Tiara_by_TJ/views/widgets/price_info.dart';
import 'package:flutter/material.dart';
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

  checkPlanPurchased() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      ApiService.listOfOrders.clear();
      print("customerId ${customerProvider.customerData[0]["id"]}");
      await ApiService.fetchOrders(customerProvider.customerData[0]["id"], 1);

      List<OrderModel> listOfGoldPlans = <OrderModel>[];
//List<OrderModelMetaDatum> listOfMetaData = <OrderModelMetaDatum>[];
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
            setState(() {
              isPlanAlreadyPurchased = true;
            });
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
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: true);
    final digiGoldProvider =
        Provider.of<DigiGoldProvider>(context, listen: true);
    bool isCustomerDataEmpty = customerProvider.customerData.isEmpty;
    print("termsConditions $termsConditions");
    return IgnorePointer(
      ignoring: isPlanAlreadyPurchased,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isPlanAlreadyPurchased
                  ? Stack(
                      children: [
                        widget.digiGoldPlan.images.isNotEmpty
                            ? widget.digiGoldPlan.images[0].src != null
                                ? Image.network(
                                    widget.digiGoldPlan.images[0].src!)
                                : DigiGoldPlanSubCard(
                                    price: widget.digiGoldPlan.price ?? "0",
                                    isPlanAlreadyPurchased:
                                        isPlanAlreadyPurchased,
                                  )
                            : DigiGoldPlanSubCard(
                                price: widget.digiGoldPlan.price ?? "0",
                                isPlanAlreadyPurchased: isPlanAlreadyPurchased,
                              ),
                        Positioned(
                          top: 20.0,
                          left: 1.0,
                          right: 1.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "You have already purchased this plan",
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  : widget.digiGoldPlan.images.isNotEmpty
                      ? widget.digiGoldPlan.images[0].src != null
                          ? Image.network(widget.digiGoldPlan.images[0].src!)
                          : DigiGoldPlanSubCard(
                              price: widget.digiGoldPlan.price ?? "0",
                              isPlanAlreadyPurchased: isPlanAlreadyPurchased)
                      : DigiGoldPlanSubCard(
                          price: widget.digiGoldPlan.price ?? "0",
                          isPlanAlreadyPurchased: isPlanAlreadyPurchased,
                        ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.digiGoldPlan.name ?? "Jewellery",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Plan Type: ",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Amount",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Plan Duration: ",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "$planDuration months",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 20.0,
                      ),
                    ),
                    PriceInfo(
                        label: "You Pay Per Month: ",
                        price: widget.digiGoldPlan.price != null
                            ? widget.digiGoldPlan.price!.isNotEmpty
                                ? widget.digiGoldPlan.price!
                                : "0"
                            : "0"),
                    PriceInfo(
                        label: "Total Amount You Pay: ",
                        price: widget.digiGoldPlan.price != null
                            ? widget.digiGoldPlan.price!.isNotEmpty
                                ? "${int.parse(widget.digiGoldPlan.price!) * planDuration}"
                                : "0"
                            : "0"),
                    isJewellerContributing
                        ? PriceInfo(
                            label: "Jeweller Contribution: ",
                            price: jeweller_contribution)
                        : SizedBox(),
                    SizedBox(
                      height: 10.0,
                    ),
                    isJewellerContributing
                        ? PriceInfo(
                            label: "You Get Jewellery Worth: ",
                            price: widget.digiGoldPlan.price != null
                                ? widget.digiGoldPlan.price!.isNotEmpty
                                    ? "${int.parse(jeweller_contribution) + int.parse(widget.digiGoldPlan.price!) * planDuration}"
                                    : "0"
                                : "0")
                        : SizedBox(
                            height: 10.0,
                          ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: checkBoxChecked,
                          onChanged: (value) {
                            print("termsSeen2 ${termsSeen}");
                            if (termsSeen) {
                              if (mounted) {
                                setState(() {
                                  checkBoxChecked = value ?? false;
                                });
                              }
                              print("checkBoxChecked ${checkBoxChecked}");
                            }
                          },
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
                                        textStyle: TextStyle(fontSize: 17.0),
                                      ));
                                },
                              );
                            },
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 17.0),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    isCustomerDataEmpty
                        ? GestureDetector(
                            onTap: () {
                              if (checkBoxChecked) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LoginPage(isComeFromCart: false),
                                    ));
                              }
                            },
                            child: Container(
                                margin:
                                    EdgeInsets.only(left: 15.0, bottom: 5.0),
                                decoration: checkBoxChecked
                                    ? BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0))
                                    : BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17.0),
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
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0))
                                    : BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17.0),
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
