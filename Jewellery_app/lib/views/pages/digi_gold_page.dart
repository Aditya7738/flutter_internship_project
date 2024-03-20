// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlans;
import 'package:Tiara_by_TJ/model/gold_rate_model.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digigold_plan_bill.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';

import 'package:Tiara_by_TJ/views/widgets/digi_gold_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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

  bool isFlexiPlanAlreadyPurchased = false;

  Stream<FileResponse>? digiGoldPlanFileStream;

  void _downloadFile(CacheProvider cacheProvider) {
    if (mounted) {
      setState(() {
        // cacheProvider.setCategoryFileStream(DefaultCacheManager()
        //     .getFileStream(ApiService.categoryUri, withProgress: true));
        digiGoldPlanFileStream = DefaultCacheManager()
            .getFileStream(ApiService.digiGoldUrl, withProgress: true);
      });
      print("digiGoldPlanFileStream == null ${digiGoldPlanFileStream == null}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheProvider cacheProvider =
        Provider.of<CacheProvider>(context, listen: false);
    print(
        "initState digiGoldPlanFileStream == null ${digiGoldPlanFileStream == null}");
    if (digiGoldPlanFileStream == null) {
      //getRequest();
      _downloadFile(cacheProvider);
    }

    // getDigiGoldPlanList();

    checkFlexiPlanPurchased();

    print(
        "isFlexiPlanAlreadyPurchased == false ${isFlexiPlanAlreadyPurchased == false}");

    getGoldRateRequest();
  }

  checkFlexiPlanPurchased() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    print(
        "customerProvider.customerData.isNotEmpty ${customerProvider.customerData.isNotEmpty}");

    if (customerProvider.customerData.isNotEmpty) {
      print("customerId ${customerProvider.customerData[0]["id"]}");
      bool isThereInternet = await ApiService.checkInternetConnection(context);
      if (isThereInternet) {
        ApiService.listOfOrders.clear();

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
            if (element.productId == 68946) {
              setState(() {
                isFlexiPlanAlreadyPurchased = true;
              });

              print("element.productId == 68946 ${element.productId == 68946}");
            }
          }
        }
      }
    }
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
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        print("Could not launch Terms and condition's URL");
      }
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

    final digiGoldProvider =
        Provider.of<DigiGoldProvider>(context, listen: true);

    bool isCustomerDataEmpty = customerProvider.customerData.isEmpty;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("DigiGold"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              children: [
                isFlexiPlanEnabled
                    ? Column(children: [
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
                                color: isFlexiPlanAlreadyPurchased
                                    ? Color.fromARGB(255, 213, 167, 170)
                                    : Theme.of(context).primaryColor,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    print(
                                        "flexi constraints.maxWidth / 33 ${(constraints.maxWidth / 32)}");
                                    return Column(
                                      children: [
                                        isFlexiPlanAlreadyPurchased
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.0),
                                                    child: Text(
                                                      "You have already purchased Flexi plan",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                        IgnorePointer(
                                            ignoring:
                                                isFlexiPlanAlreadyPurchased,
                                            child: Padding(
                                                // width: MediaQuery.of(context)
                                                //     .size
                                                //     .width,
                                                padding: const EdgeInsets.only(
                                                    right: 20.0,
                                                    left: 20.0,
                                                    bottom: 30.0,
                                                    top: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Flexi Plan",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: (constraints
                                                                        .maxWidth /
                                                                    38) +
                                                                10,
                                                            color:
                                                                Colors.white)),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              125,
                                                          child: LayoutBuilder(
                                                            builder: (context,
                                                                constraints) {
                                                              print(
                                                                  "Gold Rate ${constraints.maxWidth / 20}");
                                                              double fontSize =
                                                                  constraints
                                                                          .maxWidth /
                                                                      20;
                                                              if (fontSize >
                                                                  17) {
                                                                fontSize -= 15;
                                                              }
                                                              return Text(
                                                                "Today's Gold Rate: ₹ $goldRate per gram of $goldPurity purity",
                                                                maxLines: 2,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      fontSize,
                                                                  color: Colors
                                                                      .yellow,
                                                                ),
                                                              );
                                                            },

                                                            //  child:
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                      "Buy Gold Worth",
                                                      style: TextStyle(
                                                          fontSize: (constraints
                                                                      .maxWidth /
                                                                  30) +
                                                              0.99,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/rupee.png",
                                                            scale: 14.5,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                120,
                                                            child: TextField(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      constraints.maxWidth /
                                                                              40 +
                                                                          5),
                                                              onChanged:
                                                                  (value) {
                                                                calculateGoldGrams(
                                                                    value);
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
                                                          fontSize: constraints
                                                                  .maxWidth /
                                                              37,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 40.0,
                                                    ),
                                                    Text(
                                                      "Buy Gold By Grams",
                                                      style: TextStyle(
                                                          fontSize: (constraints
                                                                      .maxWidth /
                                                                  30) +
                                                              0.99,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                140,
                                                            child: TextField(
                                                              onChanged:
                                                                  (value) {
                                                                calculatePriceForGoldGrams(
                                                                    value);
                                                              },
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      constraints.maxWidth /
                                                                              40 +
                                                                          5),
                                                              controller:
                                                                  flexiGoldController,
                                                            )),
                                                        Text(
                                                          "gms",
                                                          style: TextStyle(
                                                            fontSize: constraints
                                                                        .maxWidth /
                                                                    40 +
                                                                5,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 40.0,
                                                    ),
                                                    Text(
                                                      "Enter plan duration",
                                                      style: TextStyle(
                                                          fontSize: (constraints
                                                                      .maxWidth /
                                                                  30) +
                                                              0.99,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                174,
                                                            child: TextField(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      constraints.maxWidth /
                                                                              40 +
                                                                          5),
                                                              controller:
                                                                  flexiPlanDurationController,
                                                            )),
                                                        Text(
                                                          "months",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  constraints.maxWidth /
                                                                          40 +
                                                                      5,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      "Max duration: ${getMaxFlexiPlanDuration()} months",
                                                      style: TextStyle(
                                                          fontSize: constraints
                                                                  .maxWidth /
                                                              37,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 40.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Transform.scale(
                                                          scale: 1.199,
                                                          child: Checkbox(
                                                            activeColor:
                                                                Colors.white,
                                                            checkColor:
                                                                Colors.black,
                                                            value:
                                                                checkBoxChecked,
                                                            onChanged: (value) {
                                                              print(
                                                                  "termsSeen2 ${termsSeen}");
                                                              if (termsSeen) {
                                                                if (mounted) {
                                                                  setState(() {
                                                                    checkBoxChecked =
                                                                        value ??
                                                                            false;
                                                                  });
                                                                }
                                                                print(
                                                                    "checkBoxChecked ${checkBoxChecked}");
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if (mounted) {
                                                              setState(() {
                                                                termsSeen =
                                                                    true;
                                                              });
                                                            }

                                                            onLinkClicked(
                                                                "https://tiarabytj.com/terms-conditions/");
                                                          },
                                                          child: Text(
                                                            "Terms & Conditions",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    (constraints.maxWidth /
                                                                            30) +
                                                                        2,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 80.0,
                                                    ),
                                                    isCustomerDataEmpty
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LoginPage(
                                                                      isComeFromCart:
                                                                          false,
                                                                    ),
                                                                  ));
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          20.0),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  100,
                                                              child: Text(
                                                                "LOGIN",
                                                                style: checkBoxChecked
                                                                    ? Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline5
                                                                    : Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .button
                                                                // : TextStyle(
                                                                //     color: checkBoxChecked
                                                                //         ? Colors
                                                                //             .black
                                                                //         : Colors
                                                                //             .white,
                                                                //     fontSize:
                                                                //         16.0,
                                                                //     fontWeight:
                                                                //         FontWeight.bold)
                                                                ,
                                                              ),
                                                              decoration:
                                                                  checkBoxChecked
                                                                      ? BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          // borderRadius:
                                                                          //     BorderRadius.circular(5.0)
                                                                        )
                                                                      : BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 2.0,
                                                                              color: Colors.white,
                                                                              style: BorderStyle.solid),
                                                                          shape: BoxShape.rectangle),
                                                            ),
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              Map<String,
                                                                      String>
                                                                  flexiPlanData =
                                                                  <String,
                                                                      String>{
                                                                "plan_price":
                                                                    flexiPayController
                                                                        .text,
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
                                                                    builder:
                                                                        (context) =>
                                                                            DigiGoldPlanOrderPage(
                                                                      digiGoldPlanModel:
                                                                          flexiPlanModel!,
                                                                      flexiPlanData:
                                                                          flexiPlanData,
                                                                    ),
                                                                  ));
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          20.0),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width -
                                                                  100,
                                                              child: Text(
                                                                "PROCEED TO PAY",
                                                                style: TextStyle(
                                                                    color: checkBoxChecked
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              decoration:
                                                                  checkBoxChecked
                                                                      ? BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          //
                                                                          //                                  borderRadius:
                                                                          //     BorderRadius.circular(5.0)
                                                                        )
                                                                      : BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 2.0,
                                                                              color: Colors.white,
                                                                              style: BorderStyle.solid),
                                                                          shape: BoxShape.rectangle),
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                  ],
                                                )))
                                      ],
                                    );
                                  }),
                                ),
                              );
                            }
                          },
                          //child:
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        digiGoldPlanFileStream != null
                            ? StreamBuilder(
                                stream: digiGoldPlanFileStream!,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    getFile(snapshot, digiGoldProvider);
                                  }

                                  Widget body;
                                  print(
                                      "!snapshot.hasData ${!snapshot.hasData}");
                                  print(
                                      "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
                                  final loading = !snapshot.hasData ||
                                      snapshot.data is DownloadProgress;
                                  // DownloadProgress? progress =
                                  //     snapshot.data as DownloadProgress?;
                                  print("loading $loading");
                                  if (snapshot.hasError) {
                                    print(
                                        "snapshot error ${snapshot.error.toString()}");
                                    body = SizedBox();
                                  } else if (loading) {
                                    body = SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color:
                                                // Colors.red,
                                                Theme.of(context).primaryColor,
                                          ),
                                        ));
                                    print("snapshot.loading");
                                  } else {
                                    print(
                                        "digiGoldProvider.fileInfoFetching ${digiGoldProvider.fileInfoFetching}");

                                    if (digiGoldProvider.fileInfoFetching !=
                                        null) {
                                      if (digiGoldProvider.fileInfoFetching!) {
                                        body = SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                200,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                // Colors.yellow,
                                              ),
                                            ));
                                      } else {
                                        body = SizedBox();
                                      }
                                    } else {
                                      body = Column(
                                        children: [
                                          ...getGoldPlanList(),
                                        ],
                                      );
                                    }
                                    print("snapshot.data ${snapshot.data}");
                                  }
                                  return body;
                                },
                              )
                            : SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Text(
                                    "stream is null ${digiGoldPlanFileStream != null}"),
                              )
                      ])
                    : Consumer<DigiGoldProvider>(
                        builder: (context, value, child) {
                          if (digiGoldPlanFileStream != null) {
                            return StreamBuilder(
                              stream: digiGoldPlanFileStream!,
                              builder: (context, snapshot) {
                                Widget? body;

                                if (value.fileInfoFetching != true) {
                                  if (snapshot.hasData) {
                                    getFile(snapshot, value);
                                  }
                                }

                                // if (snapshot.hasData) {
                                //     getFile(snapshot, value);
                                //   }

                                print("!snapshot.hasData ${!snapshot.hasData}");
                                print(
                                    "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
                                final loading = !snapshot.hasData ||
                                    snapshot.data is DownloadProgress;
                                // DownloadProgress? progress =
                                //     snapshot.data as DownloadProgress?;
                                print("loading $loading");
                                if (snapshot.hasError) {
                                  print(
                                      "snapshot error ${snapshot.error.toString()}");
                                  body = SizedBox();
                                } else if (loading) {
                                  body = SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              // Colors.red,
                                              Theme.of(context).primaryColor,
                                        ),
                                      ));
                                  print("snapshot.loading");
                                } else {
                                  print(
                                      "digiGoldProvider.fileInfoFetching ${value.fileInfoFetching}");
                                  if (value.fileInfoFetching != null) {
                                    if (value.fileInfoFetching!) {
                                      body = SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              200,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              // Colors.yellow,
                                            ),
                                          ));
                                    } else {
                                      body = SizedBox();
                                    }
                                  } else {
                                    body = Column(
                                      children: [
                                        ...getGoldPlanList(),
                                      ],
                                    );
                                  }
                                  // value.fileInfoFetching
                                  //     ?
                                  //     :
                                  print("snapshot.data ${snapshot.data}");
                                }
                                return body;
                              },
                            );
                          } else {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                        },
                      )

                // digiGoldPlanFileStream != null
                //     ? StreamBuilder(
                //         stream: digiGoldPlanFileStream!,
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             getFile(snapshot, digiGoldProvider);
                //           }

                //           Widget body;
                //           print("!snapshot.hasData ${!snapshot.hasData}");
                //           print(
                //               "snapshot.data is DownloadProgress ${snapshot.data is DownloadProgress}");
                //           final loading = !snapshot.hasData ||
                //               snapshot.data is DownloadProgress;
                //           // DownloadProgress? progress =
                //           //     snapshot.data as DownloadProgress?;
                //           print("loading $loading");
                //           if (snapshot.hasError) {
                //             print(
                //                 "snapshot error ${snapshot.error.toString()}");
                //             body = SizedBox();
                //           } else if (loading) {
                //             body = SizedBox(
                //                 width: MediaQuery.of(context).size.width,
                //                 height:
                //                     MediaQuery.of(context).size.height / 2,
                //                 child: Center(
                //                   child: CircularProgressIndicator(
                //                     color:
                //                         // Colors.red,
                //                         Theme.of(context).primaryColor,
                //                   ),
                //                 ));
                //             print("snapshot.loading");
                //           } else {
                //             print(
                //                 "digiGoldProvider.fileInfoFetching ${digiGoldProvider.fileInfoFetching}");

                //             digiGoldProvider.fileInfoFetching
                //                 ? body = SizedBox(
                //                     width:
                //                         MediaQuery.of(context).size.width,
                //                     height:
                //                         MediaQuery.of(context).size.height - 200,
                //                     child: Center(
                //                       child: CircularProgressIndicator(
                //                         color:
                //                             Theme.of(context).primaryColor,
                //                         // Colors.yellow,
                //                       ),
                //                     ))
                //                 : body = Column(
                //                     children: [
                //                       ...getGoldPlanList(),
                //                     ],
                //                   );
                //             print("snapshot.data ${snapshot.data}");
                //           }
                //           return body;
                //         },
                //       )
                //     : SizedBox(
                //         height: MediaQuery.of(context).size.height / 6,
                //         child: Center(
                //           child: CircularProgressIndicator(
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),

                // : isDigiGoldPlanLoading
                //     ? Container(
                //         color: Colors.white,
                //         height: MediaQuery.of(context).size.height -
                //             (kToolbarHeight + 110),
                //         child: Center(
                //             child: CircularProgressIndicator(
                //           color: Theme.of(context).primaryColor,
                //         )),
                //       )
                //     :

                // )
              ],
            )),
      ),
    );
  }

  // List<Widget> getGoldPlanList() {
  //   return listOfFilteredDigiGoldPlan
  //       .map((e) => DigiGoldCard(digiGoldPlan: e))
  //       .toList();
  // }

  List<Widget> getGoldPlanList() {
    return CacheMemory.listOfDigiGoldPlans
        .map((e) => DigiGoldCard(digiGoldPlan: e))
        .toList();
  }

  void getFile(AsyncSnapshot<Object?> snapshot,
      DigiGoldProvider digiGoldProvider) async {
    if (digiGoldProvider.fileInfoFetching != null) {
      digiGoldProvider.setFileInfoFetching(true);
      //  CacheMemory.listOfCategory.clear();
      await CacheMemory.getDigiGoldFile(snapshot);
      digiGoldProvider.setFileInfoFetching(null);
    }
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
