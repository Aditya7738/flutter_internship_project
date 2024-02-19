import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/price_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGoldPlans extends StatefulWidget {
  const MyGoldPlans({super.key});

  @override
  State<MyGoldPlans> createState() => _MyGoldPlansState();
}

class _MyGoldPlansState extends State<MyGoldPlans> {
  List<OrderModel> listOfOrders = <OrderModel>[];
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

    setState(() {
      isOrderFetching = true;
    });
    listOfOrders =
        await ApiService.fetchOrders(customerProvider.customerData[0]["id"], 1);

List<OrderModelMetaDatum> listOfmetaData = <OrderModelMetaDatum>[];
    for (var i = 0; i < listOfOrders.length; i++) {
      listOfmetaData = listOfOrders[i].metaData; 
    }

    // if (listOfOrders[i].metaData[i].key == "virtual_order" &&
    //       listOfOrders[i].metaData[i].value == "digigold") {
    //     listOfGoldPlans.add(listOfOrders[i]);
    //   }

    setState(() {
      isOrderFetching = false;
    });

    print("listOfGoldPlans $listOfGoldPlans");
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
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "₹ 1000",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
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
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
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
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Golden Varsha 1000",
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
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "February 19, 2024, 13:10:20",
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
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "2/12 months",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                        ),
                                        maxLines: 2,
                                      )
                                    ]),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
