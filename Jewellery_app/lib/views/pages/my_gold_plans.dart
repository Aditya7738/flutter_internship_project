import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
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
      setState(() {
        isOrderFetching = true;
      });

      ApiService.listOfOrders.clear();
      await ApiService.fetchOrders(customerProvider.customerData[0]["id"], 1);

//List<OrderModelMetaDatum> listOfMetaData = <OrderModelMetaDatum>[];
      for (var i = 0; i < ApiService.listOfOrders.length; i++) {
        for (var j = 0; j < ApiService.listOfOrders[i].metaData.length; j++) {
          if (ApiService.listOfOrders[i].metaData[j].key == "virtual_order" &&
              ApiService.listOfOrders[i].metaData[j].value == "digigold") {
            listOfGoldPlans.add(ApiService.listOfOrders[i]);
          }
        }
      }

      // for (var i = 0; i < listOfGoldPlans.length; i++) {
      //   print("listOfGoldPlans ${listOfGoldPlans[i].id}");
      // }

      // for (var i = 0; i < listOfMetaData.length; i++) {
      //   if(listOfMetaData[i].key == "virtual_order" && listOfMetaData[i].value == "digigold"){

      //   }
      // }

      // if (listOfOrders[i].metaData[i].key == "virtual_order" &&
      //       listOfOrders[i].metaData[i].value == "digigold") {
      //     listOfGoldPlans.add(listOfOrders[i]);
      //   }

      setState(() {
        isOrderFetching = false;
      });
    }

    // print("listOfGoldPlans $listOfGoldPlans");
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Gold Plans"),
      ),
      body: orderProvider.isOrderCreating || isOrderFetching
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: listOfGoldPlans.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = listOfGoldPlans[index];
                  return MyGoldPlanListItem(orderModel: orderModel);
                },
              ),
            ),
    );
  }
}
