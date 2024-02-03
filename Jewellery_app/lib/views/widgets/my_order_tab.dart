import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/order_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyOrderTab extends StatefulWidget {
  MyOrderTab({super.key});

  @override
  State<MyOrderTab> createState() => _MyOrderTabState();
}

class _MyOrderTabState extends State<MyOrderTab> {
  double shippingProgress = 0.0;
  bool pageLoading = true;

  bool isThereMoreOrders = false;

  bool isMoreOrderLoading = false;

  @override
  void initState() {
    super.initState();

    getOrders();
  }

  Future<void> getOrders() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    int customerId = customerProvider.customerData[0]["id"];

    ApiService.listOfOrders.clear();

    await ApiService.fetchOrders(customerId, 1);

    setState(() {
      pageLoading = false;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return pageLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.white,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: ApiService.listOfOrders.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = ApiService.listOfOrders[index];
                

                return Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order No: ",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  orderModel.id.toString(),
                                  style: Theme.of(context).textTheme.headline3
                                )
                              ],
                            ),
                            InkWell(
                              child: Text(
                                "Order Details",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: 5.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 120.0,
                        padding: const EdgeInsets.all(8.0),
                        child: Scrollbar(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            itemCount: orderModel.lineItems.length,
                            itemBuilder: (context, index) {
                              LineItem order = orderModel.lineItems[index];
                          
                              return Container(
                              padding: EdgeInsets.only(left: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    style: BorderStyle.solid)),
                                            child: Image.network(
                                              order.image == null
                                                  ? Strings.defaultImageUrl
                                                  : order.image!.src == ""
                                                      ? Strings.defaultImageUrl
                                                      : order.image!.src!,
                                              width: 100.0,
                                              height: 100.0,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Container(
                                                  alignment: Alignment.center,
                                                  width: 90.0,
                                                  height: 87.0,
                                                  child:
                                                      const CircularProgressIndicator(
                                                    color: Colors.black,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                               
                                                width: MediaQuery.of(context).size.width/2 - 20,
                                                child: Text(
                                                  order.name!,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/rupee.png",
                                                    width: 19.0,
                                                    height: 17.0,
                                                  ),
                                                  Text(
                                                    // productsModel.regularPrice != ""
                                                    //     ? productsModel.regularPrice ??
                                                    order.price.toString(),
                                                    // : "0.0",
                                                    // productsModel.regularPrice ??
                                                    //     "20,000",
                                                    style: TextStyle(
                                                    fontSize: 17.0,
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Sku: ",
                                                     style: TextStyle(
                                                    fontSize: 17.0,
                                                  ),
                                                  ),
                                                  Text(
                                                    // productsModel.regularPrice != ""
                                                    //     ? productsModel.regularPrice ??
                                                    order.sku ?? "sku",
                                                    // : "0.0",
                                                    // productsModel.regularPrice ??
                                                    //     "20,000",
                                                     style: TextStyle(
                                                    fontSize: 17.0,
                                                  ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ]),
                                                          
                                    //const Icon(Icons.chevron_right_outlined)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Divider(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order Received ",
                                  style: Theme.of(context).textTheme.headline3
                                ),
                                Text("(21-May-2021)")
                              ],
                            ),
                            Column(
                              children: [
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: const Color(0xffCC868A),
                                    trackHeight: 5.0,
                                    tickMarkShape:
                                        const RoundSliderTickMarkShape(
                                      tickMarkRadius: 4.0,
                                    ),
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 7.0),
                                    activeTickMarkColor: Colors.black,
                                    inactiveTickMarkColor: Colors.white,
                                  ),
                                  child: Slider(
                                    divisions: 2,
                                    activeColor: const Color(0xffCC868A),
                                    value: 0.5,
                                    onChanged: (value) {},
                                    min: 0.0,
                                    max: 1.0,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                   
                                    
                                    Text("Placed on \n${formatDate(orderModel.dateCreated!)}"),
                                    SizedBox(width: 80.0,
                                      child: Text(
                                          "Expected Delivery on ${DateHelper.getCurrentDateInWords()}", maxLines: 5,),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }

  String formatDate(DateTime dateTime){
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    
    return formatter.format(dateTime);
  }

}
