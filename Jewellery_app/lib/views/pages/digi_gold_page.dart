import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart' as DigiGoldPlan;

import 'package:Tiara_by_TJ/views/widgets/digi_gold_card.dart';
import 'package:flutter/material.dart';

class DigiGoldPage extends StatefulWidget {
  const DigiGoldPage({super.key});

  @override
  State<DigiGoldPage> createState() => _DigiGoldPageState();
}

class _DigiGoldPageState extends State<DigiGoldPage> {

bool isDigiGoldPlanLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDigiGoldPlanList();
  }

  Future<void> getDigiGoldPlanList() async {
    await ApiService.getListOfDigiGoldPlan();

    setState(() {
      isDigiGoldPlanLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DigiGold"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flexi Plan",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            "Buy Gold Worth",
                            // style: Theme.of(context).textTheme.headline2,
                          ),
                          TextField(),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Min : "),
                              Image.asset(
                                "assets/images/rupee.png",
                                width: 15.0,
                                height: 15.0,
                              ),
                              Text(
                                "1 / Max : ",
                              ),
                              Image.asset(
                                "assets/images/rupee.png",
                                width: 15.0,
                                height: 15.0,
                              ),
                              Text(
                                "199999",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Buy Gold By Grams"),
                          TextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                              "PROCEED TO PAY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black, shape: BoxShape.rectangle),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Terms & Conditions",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/saved_money.png",
                                        width: 25.0,
                                        height: 25.0,
                                      ),
                                      Text("Today's Gold Rate: "),
                                      Image.asset(
                                        "assets/images/rupee.png",
                                        width: 15.0,
                                        height: 15.0,
                                      ),
                                      Text("Price")
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),

                

                isDigiGoldPlanLoading 
                ? 
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor
                    )
                  ),
                )
                :

                Column(
                  children: getGoldPlanList(),
                )
               
                
              ],
            )),
      ),
    );
  }
  
List<Widget> getGoldPlanList() {
   
    return ApiService.listOfDigiGoldPlan.map((e) => DigiGoldCard(digiGoldPlan: e)).toList();
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