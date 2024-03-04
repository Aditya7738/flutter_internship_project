import 'dart:convert';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlans;
import 'package:Tiara_by_TJ/model/gold_rate_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digigold_plan_bill.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';

import 'package:Tiara_by_TJ/views/widgets/digi_gold_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DigiGoldPage extends StatefulWidget {
  const DigiGoldPage({super.key});

  @override
  State<DigiGoldPage> createState() => _DigiGoldPageState();
}

class _DigiGoldPageState extends State<DigiGoldPage> {
  bool isDigiGoldPlanLoading = false;
  int goldRate = 0;
  String goldPurity = "0";
  TextEditingController flexiPayController = TextEditingController();
  TextEditingController flexiGoldController = TextEditingController();

  bool checkBoxChecked = false;

  bool termsSeen = false;

  TextEditingController flexiPlanDurationController = TextEditingController();

  bool isFlexiPlanEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDigiGoldPlanList();

    getGoldRateRequest();
  }

  Future<void> getGoldRateRequest() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      final digiGoldProvider =
          Provider.of<DigiGoldProvider>(context, listen: false);
      digiGoldProvider.setGoldRateLoading(true);
      http.Response response = await ApiService.getGoldRate();

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        print("gold json $json");
        GoldRateModel goldRateModel = GoldRateModel(
          type: json["type"],
          data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
        goldPurity = getGoldPurity(goldRateModel);

        goldRate = getGoldRate(goldRateModel);
      }

      digiGoldProvider.setGoldRateLoading(false);
    }
  }

  String getGoldPurity(GoldRateModel goldRateModel) {
    String goldPurity = "0";
    if (goldRateModel.data != null) {
      if (goldRateModel.data!.goldPricing != null) {
        if (goldRateModel.data!.goldPricing!.inr != null) {
          goldPurity =
              goldRateModel.data!.goldPricing!.inr!.inrDefault ?? "916";
        }
      }
    }
    return goldPurity;
  }

  int getGoldRate(GoldRateModel goldRateModel) {
    int goldRate = 0;
    if (goldRateModel.data != null) {
      if (goldRateModel.data!.goldPricing != null) {
        String goldPricingType =
            goldRateModel.data!.goldPricing!.from ?? "automatic";
        if (goldRateModel.data!.goldPricing!.inr != null) {
          String defaultPurity =
              goldRateModel.data!.goldPricing!.inr!.inrDefault ?? "916";

          switch (goldPricingType) {
            case "automatic":
              if (goldRateModel.data!.goldPricing!.inr!.automatic != null) {
                goldRate = getGoldRateOfAutomatic(
                    goldRateModel.data!.goldPricing!.inr!.automatic!,
                    defaultPurity,
                    goldRateModel);
              }

              break;
            case "manual":
              goldRate = getGoldRateOfManual(
                  goldRateModel.data!.goldPricing!.inr!.manual,
                  defaultPurity,
                  goldRateModel);

              break;
            default:
              if (goldRateModel.data!.goldPricing!.inr!.automatic != null) {
                goldRate = getGoldRateOfAutomatic(
                    goldRateModel.data!.goldPricing!.inr!.automatic!,
                    defaultPurity,
                    goldRateModel);
              }

              break;
          }
        }
      }
    }
    return goldRate;
  }

  int getGoldRateOfAutomatic(PurpleAutomatic automatic, String defaultPurity,
      GoldRateModel goldRateModel) {
    int goldRate = 0;

    switch (defaultPurity) {
      case "375":
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the375 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the375!.rate !=
              null) {
            goldRate =
                goldRateModel.data!.goldPricing!.inr!.automatic!.the375!.rate!;
          }
        }
        break;
      case "583":
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the583 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the583!.rate !=
              null) {
            goldRate =
                goldRateModel.data!.goldPricing!.inr!.automatic!.the583!.rate!;
          }
        }
        break;
      case "750":
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the750 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the750!.rate !=
              null) {
            goldRate =
                goldRateModel.data!.goldPricing!.inr!.automatic!.the750!.rate!;
          }
        }
        break;
      case "916":
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the916 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the916!.rate !=
              null) {
            goldRate =
                goldRateModel.data!.goldPricing!.inr!.automatic!.the916!.rate!;
          }
        }
        break;
      case "999":
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the999 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the999!.rate !=
              null) {
            goldRate =
                goldRateModel.data!.goldPricing!.inr!.automatic!.the999!.rate!;
          }
        }
        break;
      case "999.99":
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the99999 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the99999!.rate !=
              null) {
            goldRate = goldRateModel
                .data!.goldPricing!.inr!.automatic!.the99999!.rate!;
          }
        }
        break;
      default:
        if (goldRateModel.data!.goldPricing!.inr!.automatic!.the916 != null) {
          if (goldRateModel.data!.goldPricing!.inr!.automatic!.the916!.rate !=
              null) {
            goldRate =
                goldRateModel.data!.goldPricing!.inr!.automatic!.the916!.rate!;
          }
        }
        break;
    }

    return goldRate;
  }

  int getGoldRateOfManual(Map<String, Manual> manual, String defaultPurity,
      GoldRateModel goldRateModel) {
    int goldRate = 0;

    switch (defaultPurity) {
      case "375":
        if (goldRateModel.data!.goldPricing!.inr!.manual["375"] != null) {
          Manual manual = goldRateModel.data!.goldPricing!.inr!.manual["375"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }

        break;
      case "583":
        if (goldRateModel.data!.goldPricing!.inr!.manual["583"] != null) {
          Manual manual = goldRateModel.data!.goldPricing!.inr!.manual["583"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }
        break;
      case "750":
        if (goldRateModel.data!.goldPricing!.inr!.manual["750"] != null) {
          Manual manual = goldRateModel.data!.goldPricing!.inr!.manual["750"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }
        break;
      case "916":
        if (goldRateModel.data!.goldPricing!.inr!.manual["916"] != null) {
          Manual manual = goldRateModel.data!.goldPricing!.inr!.manual["916"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }
        break;
      case "999":
        if (goldRateModel.data!.goldPricing!.inr!.manual["999"] != null) {
          Manual manual = goldRateModel.data!.goldPricing!.inr!.manual["999"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }
        break;
      case "999.99":
        if (goldRateModel.data!.goldPricing!.inr!.manual["999.99"] != null) {
          Manual manual =
              goldRateModel.data!.goldPricing!.inr!.manual["999.99"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }
        break;
      default:
        if (goldRateModel.data!.goldPricing!.inr!.manual["916"] != null) {
          Manual manual = goldRateModel.data!.goldPricing!.inr!.manual["916"]!;
          if (manual.rate != null) {
            goldRate = int.parse(manual.rate!);
          }
        }
        break;
    }

    return goldRate;
  }

  List<DigiGoldPlans.DigiGoldPlanModel> listOfAllDigiGoldPlan =
      <DigiGoldPlans.DigiGoldPlanModel>[];

  List<DigiGoldPlans.DigiGoldPlanModel> listOfFilteredDigiGoldPlan =
      <DigiGoldPlans.DigiGoldPlanModel>[];

  DigiGoldPlans.DigiGoldPlanModel? flexiPlanModel;

  Future<void> getDigiGoldPlanList() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isDigiGoldPlanLoading = true;
        });
      }

      listOfAllDigiGoldPlan = await ApiService.getListOfDigiGoldPlan();

      for (var i = 0; i < listOfAllDigiGoldPlan.length; i++) {
        for (var j = 0; j < listOfAllDigiGoldPlan[i].metaData.length; j++) {
          if (listOfAllDigiGoldPlan[i].metaData[j].key == "digi_plan_type") {
            if (listOfAllDigiGoldPlan[i].metaData[j].value == "flexi") {
              flexiPlanModel = listOfAllDigiGoldPlan[i];
              if (mounted) {
                setState(() {
                isFlexiPlanEnabled = true;
              });
              }
              
            } else {
              listOfFilteredDigiGoldPlan.add(listOfAllDigiGoldPlan[i]);
            }
          }
        }
      }

      if (mounted) {
        setState(() {
          isDigiGoldPlanLoading = false;
        });
      }
    }
  }

  Future<void> onLinkClicked(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print("Could not launch Terms and condition's URL");
    }
  }

  void calculateGoldGrams(String value) {
    if (value == "0") {
      flexiGoldController.text = "0.0";
    }

    double goldGrams = int.parse(value) / goldRate;
    flexiGoldController.text = ((goldGrams * 1000).round() / 1000).toString();
  }

  void calculatePriceForGoldGrams(String value) {
    if (value == "0.0") {
      flexiPayController.text = "0";
    } else if (value == "") {
      flexiPayController.text = "";
    }
    double priceOfGoldGram = double.parse(value) * goldRate;
    flexiPayController.text =
        ((priceOfGoldGram * 100).round() / 100).toString();
  }

  String getMaxFlexiPlanDuration() {
    for (var i = 0; i < flexiPlanModel!.metaData.length; i++) {
      if (flexiPlanModel!.metaData[i].key == "digi_plan_duration") {
        return flexiPlanModel!.metaData[i].value;
      }
    }
    return "";
  }

  String getDigiPlanType() {
    for (var i = 0; i < flexiPlanModel!.metaData.length; i++) {
      if (flexiPlanModel!.metaData[i].key == "digi_plan_type") {
        return flexiPlanModel!.metaData[i].value;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: true);

    bool isCustomerDataEmpty = customerProvider.customerData.isEmpty;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Text("DigiGold"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              children: [
                isFlexiPlanEnabled
                    ? Column(
                        children: [
                          Consumer<DigiGoldProvider>(
                            builder: (context, value, child) {
                              if (value.isGoldRateLoading) {
                                return Container(
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height -
                                      (kToolbarHeight + 110),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  )),
                                );
                              } else {
                                return Card(
                                  color: Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Flexi Plan",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "Buy Gold Worth",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          // style: Theme.of(context).textTheme.headline2,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/rupee.png",
                                                width: 25.0,
                                                height: 37.0,
                                                color: Colors.white),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  onChanged: (value) {
                                                    calculateGoldGrams(value);
                                                  },
                                                  controller:
                                                      flexiPayController,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Min : ₹ 30 / Max : ₹ 199999",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        ),
                                        Text(
                                          "Buy Gold By Grams",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    130,
                                                child: TextField(
                                                  onChanged: (value) {
                                                    calculatePriceForGoldGrams(
                                                        value);
                                                  },
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  controller:
                                                      flexiGoldController,
                                                )),
                                            Text(
                                              "gms",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        ),
                                        Text(
                                          "Enter plan duration",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    160,
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  controller:
                                                      flexiPlanDurationController,
                                                )),
                                            Text(
                                              "months",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Max duration: ${getMaxFlexiPlanDuration()} months",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                              value: checkBoxChecked,
                                              onChanged: (value) {
                                                print(
                                                    "termsSeen2 ${termsSeen}");
                                                if (termsSeen) {
                                                  if (mounted) {
                                                    setState(() {
                                                      checkBoxChecked =
                                                          value ?? false;
                                                    });
                                                  }
                                                  print(
                                                      "checkBoxChecked ${checkBoxChecked}");
                                                }
                                              },
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (mounted) {
                                                  setState(() {
                                                    termsSeen = true;
                                                  });
                                                }

                                                onLinkClicked(
                                                    "https://tiarabytj.com/terms-conditions/");
                                              },
                                              child: Text(
                                                "Terms & Conditions",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        isCustomerDataEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage(
                                                          isComeFromCart: false,
                                                        ),
                                                      ));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Text(
                                                    "LOGIN",
                                                    style: TextStyle(
                                                        color: checkBoxChecked
                                                            ? Colors.black
                                                            : Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  decoration: checkBoxChecked
                                                      ? BoxDecoration(
                                                          color: Colors.white,
                                                          // borderRadius:
                                                          //     BorderRadius.circular(5.0)
                                                        )
                                                      : BoxDecoration(
                                                          border: Border.all(
                                                              width: 2.0,
                                                              color:
                                                                  Colors.white,
                                                              style: BorderStyle
                                                                  .solid),
                                                          shape: BoxShape
                                                              .rectangle),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  Map<String, String>
                                                      flexiPlanData =
                                                      <String, String>{
                                                    "plan_price":
                                                        flexiPayController.text,
                                                    "plan_gold_weight":
                                                        flexiGoldController
                                                            .text,
                                                    "plan_duration":
                                                        flexiPlanDurationController
                                                            .text,
                                                    "digi_plan_type":
                                                        getDigiPlanType(),
                                                    "description":
                                                        flexiPlanModel!
                                                                .description ??
                                                            "Description"
                                                  };

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DigiGoldPlanOrderPage(
                                                          digiGoldPlanModel:
                                                              flexiPlanModel!,
                                                          flexiPlanData:
                                                              flexiPlanData,
                                                        ),
                                                      ));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Text(
                                                    "PROCEED TO PAY",
                                                    style: TextStyle(
                                                        color: checkBoxChecked
                                                            ? Colors.black
                                                            : Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  decoration: checkBoxChecked
                                                      ? BoxDecoration(
                                                          color: Colors.white,
                                                          // borderRadius:
                                                          //     BorderRadius.circular(5.0)
                                                        )
                                                      : BoxDecoration(
                                                          border: Border.all(
                                                              width: 2.0,
                                                              color:
                                                                  Colors.white,
                                                              style: BorderStyle
                                                                  .solid),
                                                          shape: BoxShape
                                                              .rectangle),
                                                ),
                                              ),
                                        //
                                        // GestureDetector(
                                        //         onTap: () {
                                        //           // Navigator.push(context, MaterialPageRoute(builder: (context) => DigiGoldPlanOrderPage(),));
                                        //         },
                                        //         child: Container(
                                        //           margin: EdgeInsets.symmetric(
                                        //               horizontal: 20.0),
                                        //           alignment: Alignment.center,
                                        //           padding: EdgeInsets.symmetric(
                                        //               vertical: 10.0, horizontal: 20.0),
                                        //           width: MediaQuery.of(context)
                                        //                   .size
                                        //                   .width -
                                        //               100,
                                        //           child: Text(
                                        //             "LOGIN",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 16.0,
                                        //                 fontWeight: FontWeight.bold),
                                        //           ),
                                        //           decoration: BoxDecoration(
                                        //               color: Colors.black,
                                        //               shape: BoxShape.rectangle),
                                        //         ),
                                        //       )
                                        //     :

                                        // Container(
                                        //     margin: EdgeInsets.symmetric(
                                        //         horizontal: 20.0),
                                        //     alignment: Alignment.center,
                                        //     padding: EdgeInsets.symmetric(
                                        //         vertical: 10.0, horizontal: 20.0),
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width -
                                        //         100,

                                        //     child: Text(
                                        //       "PROCEED TO PAY",
                                        //       style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontSize: 16.0,
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //     decoration: BoxDecoration(
                                        //         color: Colors.black,
                                        //         shape: BoxShape.rectangle),
                                        //   ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/saved_money.png",
                                                      width: 35.0,
                                                      height: 35.0,
                                                      color: Colors.yellow,
                                                    ),
                                                    // Text(""),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    SizedBox(
                                                        width: 190.0,
                                                        child: Text(
                                                          "Today's Gold Rate: \n ₹ $goldRate per gram of $goldPurity purity",
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.yellow,
                                                          ),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            //child:
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Column(
                            children: [
                              ...getGoldPlanList(),
                            ],
                          )
                        ],
                      )
                    : isDigiGoldPlanLoading
                        ? Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height -
                                (kToolbarHeight + 110),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )),
                          )
                        :

                        // isDigiGoldPlanLoading
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(top: 20.0),
                        //         child: Center(
                        //             child: CircularProgressIndicator(
                        //                 color: Theme.of(context).primaryColor)),
                        //       )
                        //     : Column(
                        //children:
                        Column(
                            children: [
                              ...getGoldPlanList(),
                            ],
                          )

                // )
              ],
            )),
      ),
    );
  }

  List<Widget> getGoldPlanList() {
    return listOfFilteredDigiGoldPlan
        .map((e) => DigiGoldCard(digiGoldPlan: e))
        .toList();
  }
}
// SizedBox(
//   width: MediaQuery.of(context).size.width,
//   height: MediaQuery.of(context).size.height,
//   child: ListView.builder(
//       itemCount: ApiService.listOfDigiGoldPlan.length,
//       itemBuilder: (context, index) {
//         DigiGoldPlan.DigiGoldPlanModel digiGoldPlan = ApiService.listOfDigiGoldPlan[index];
//         return DigiGoldCard(digiGoldPlan: digiGoldPlan,);
//       }),
// )
