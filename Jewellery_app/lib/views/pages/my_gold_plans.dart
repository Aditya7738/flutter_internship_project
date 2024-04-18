import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/widgets/my_gold_plan_list_item.dart';
import 'package:Tiara_by_TJ/views/widgets/price_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyGoldPlans extends StatefulWidget {
  const MyGoldPlans({super.key});

  @override
  State<MyGoldPlans> createState() => _MyGoldPlansState();
}

class _MyGoldPlansState extends State<MyGoldPlans> {
  List<OrderModel> listOfGoldPlans = <OrderModel>[];

  bool isOrderFetching = false;
  Map<String, List<OrderModel>> digiPlanModelMap = {};

  List<OrderModel> purchasedPlans = <OrderModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyGoldPlans();
  }

  getMyGoldPlans() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isOrderFetching = true;
        });
      }

      ApiService.listOfOrders.clear();
      print("customerId ${customerProvider.customerData[0]["id"]}");
      await ApiService.fetchOrders(customerProvider.customerData[0]["id"], 1);

      print("digi unfilter orders ${ApiService.listOfOrders.length}");
      for (var i = 0; i < ApiService.listOfOrders.length; i++) {
        for (var j = 0; j < ApiService.listOfOrders[i].metaData.length; j++) {
          if (ApiService.listOfOrders[i].metaData[j].key == "virtual_order" &&
              ApiService.listOfOrders[i].metaData[j].value == "digigold") {
            listOfGoldPlans.add(ApiService.listOfOrders[i]);
          }
        }
      }

      for (OrderModel orderModel in listOfGoldPlans) {
        for (OrderModelMetaDatum map in orderModel.metaData) {
          String digiPlanName = "";
          if (map.key == "digi_plan_name") {
            digiPlanName = map.value!;
            print("digiPlanName $digiPlanName");
            print(
                "!digiPlanModelMap.containsKey(digiPlanName) ${!digiPlanModelMap.containsKey(digiPlanName)}");

            if (!digiPlanModelMap.containsKey(digiPlanName)) {
              // If it doesn't exist, create a new list for that digi plan name
              digiPlanModelMap[digiPlanName] = [];

              print("digiPlanModelMap in $digiPlanModelMap");
            }

            digiPlanModelMap[digiPlanName]!.add(orderModel);

            print("digiPlanModelMap out $digiPlanModelMap");
          }
        }
      }

      digiPlanModelMap.forEach((key, value) {
        purchasedPlans.add(value.last);
      });

      purchasedPlans.forEach((element) {
        for (var i = 0; i < element.metaData.length; i++) {
          if (element.metaData[i].key == "payment_date") {
            print("payment_date$i ${element.metaData[i].value}");
          }
        }
      });
    }

    if (mounted) {
      setState(() {
        isOrderFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final deviceWidth = MediaQuery.of(context).size.width;
//left to show u have not purchased digi gold plan
    return Scaffold(
      appBar: AppBar(
        title: Text("My Gold Plans"),
      ),
      body: orderProvider.isOrderCreating || isOrderFetching
          ? Center(
              child: CircularProgressIndicator(
                color: Color(int.parse(
                    "0xff${layoutDesignProvider.primary.substring(1)}")),
              ),
            )
          : digiPlanModelMap.keys.isEmpty
              // true
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty_gold_plan_image.png",
                            width: deviceWidth > 600 ? 600.sp : 500.sp,
                            height: deviceWidth > 600 ? 450.sp : 350.sp,
                            fit: BoxFit.fill
                            // color: Color(int.parse(
                            //     "0xff${layoutDesignProvider.primary.substring(1)}"))
                            ),
                        // SvgPicture.asset(
                        //   "assets/images/empty_gold_plan.svg",
                        //   // width: 200,
                        //   height: deviceWidth > 600 ? 400 : 300,
                        //   // colorFilter: ColorFilter.mode(
                        //   //     Color(int.parse(
                        //   //         "0xff${layoutDesignProvider.primary.substring(1)}")),
                        //   //     BlendMode.srcIn)
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Hey there! It seems you haven't taken advantage our Digital gold plan offer yet.",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(int.parse(
                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                              fontSize: deviceWidth > 600 ? 27.sp : 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          //"
                          //We recommend checking out our Digi Gold plan for some exclusive perks. If it's not right fit for you, don't worry!
                          "Our Flexible plan allows you to tailor your experience based on your needs and budget.",
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: deviceWidth > 600
                                ? Fontsizes.tabletTextFormInputFieldSize
                                : Fontsizes.textFormInputFieldSize,
                            color: Color(int.parse(
                                "0xff${layoutDesignProvider.primary.substring(1)}")),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20.0,
                        // ),
                        // Text(
                        //   "Feel free to explore and make the most of our app!",
                        //   maxLines: 3,
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: deviceWidth > 600
                        //         ? Fontsizes.tabletTextFormInputFieldSize
                        //         : Fontsizes.textFormInputFieldSize,
                        //   ),
                        // ),

                        const SizedBox(
                          height: 50.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardPage()));
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
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: digiPlanModelMap.keys.length,
                    itemBuilder: (context, index) {
                      OrderModel orderModel = purchasedPlans[index];
                      String digiPlanName = "";
                      for (var i = 0; i < orderModel.metaData.length; i++) {
                        if (orderModel.metaData[i].key == "digi_plan_name") {
                          print(
                              "digi_plan_name$i ${orderModel.metaData[i].value}");
                          digiPlanName = orderModel.metaData[i].value!;
                        }
                      }

                      print("in widget digiPlanName $digiPlanName");

                      List<OrderModel> allOrdersOfThatPlan =
                          digiPlanModelMap[digiPlanName]!;

                      return MyGoldPlanListItem(
                          orderModel: orderModel,
                          allOrdersList: allOrdersOfThatPlan);
                    },
                  ),
                ),
    );
  }
}
