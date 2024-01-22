import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';

class MyOrderTab extends StatelessWidget {
  MyOrderTab({super.key});
  double shippingProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Order No: ", style: TextStyle(
                                fontSize: 17.0,
                              ),),
                          Text(
                            "LSF0B5EA",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0,),
                          )
                        ],
                      ),
                      InkWell(
                        child: Text(
                          "Order Details",
                          style: TextStyle(color: Colors.green, fontSize: 15.0,),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid)),
                          child: Image.network(
                            Strings.defaultImageUrl,
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Butterfly Watch Charm",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/rupee.png",
                                  width: 19.0,
                                  height: 17.0,
                                ),
                                const Text(
                                  // productsModel.regularPrice != ""
                                  //     ? productsModel.regularPrice ??
                                  "20000",
                                  // : "0.0",
                                  // productsModel.regularPrice ??
                                  //     "20,000",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                            const Row(
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
                                  "UG00148-1Y0000",
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
                      const Icon(Icons.chevron_right_outlined)
                    ],
                  ),
                ),
                const Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Order Received ",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                          Text("(21-May-2021)")
                        ],
                      ),
                      Column(
                        children: [
                          // Slider(
                          //   divisions: 2,
                          //   activeColor: Color(0xffCC868A),
                          //   value: 0.5,
                          //   onChanged: (value) {},
                          //   min: 0.0,
                          //   max: 1.0,
                          // ),

                          //  SliderTheme(
                          //   data: SliderTheme.of(context).copyWith(
                          //     activeTrackColor: Color(0xffCC868A),
                          //     trackHeight: 4.0,
                          //     tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 14),
                          //     disabledActiveTickMarkColor: Colors.red,
                          //     thumbShape: SliderComponentShape.noThumb,
                          //     activeTickMarkColor: Colors.black,
                          //     inactiveTickMarkColor: Colors.white,
                          //   ),
                          //   child: Slider(
                          //     divisions: 2,
                          //     activeColor: Color(0xffCC868A),
                          //     value: 0.5,
                          //     onChanged: (value) {},
                          //     min: 0.0,
                          //     max: 1.0,
                          //   ),
                          // ),

                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: const Color(0xffCC868A),
                              trackHeight: 5.0,
                              tickMarkShape: const RoundSliderTickMarkShape(
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

                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Placed on \n21-May-2021"),
                              Text(
                                  "Expected \nDelivery \nbetween\n6th to \n10th Jun")
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
}
