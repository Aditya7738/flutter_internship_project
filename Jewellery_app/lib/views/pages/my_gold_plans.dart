import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/my_gold_plan_list_item.dart';
import 'package:Tiara_by_TJ/views/widgets/price_info.dart';
import 'package:flutter/material.dart';
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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: digiPlanModelMap.keys.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = purchasedPlans[index];
                  String digiPlanName = "";
                  for (var i = 0; i < orderModel.metaData.length; i++) {
                    if (orderModel.metaData[i].key == "digi_plan_name") {
                      print("digi_plan_name$i ${orderModel.metaData[i].value}");
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
