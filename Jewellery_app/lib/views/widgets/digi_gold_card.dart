import 'package:flutter/material.dart';

class DigiGoldCard extends StatefulWidget {
  const DigiGoldCard({super.key});

  @override
  State<DigiGoldCard> createState() => _DigiGoldCardState();
}

class _DigiGoldCardState extends State<DigiGoldCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 90.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/gold_coin.png",
                      width: 45.0,
                      height: 45.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          width: 47.0,
                          height: 47.0,
                        ),
                        Text(
                          "20000",
                          style: const TextStyle(
                            fontSize: 45.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Per Month", style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Jewellery", style: Theme.of(context).textTheme.headline2,),
              SizedBox(height: 10.0,),
              Container(
               
                width: MediaQuery.of(context).size.width/2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Plan Type: ",  style: Theme.of(context).textTheme.headline4,),
                    Text("Amount")
                  ],
                ),
              ),
              Container(
               
                width: MediaQuery.of(context).size.width/2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Plan Duration: ",  style: Theme.of(context).textTheme.headline4,),
                    Text("3 Months")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(height: 20.0,),
              ),
              Row(
               
                  children: [
                    Text("Plan Duration: ",  style: Theme.of(context).textTheme.headline4,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          width: 17.0,
                          height: 17.0,
                        ),
                        Text(
                          "20000",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
      
                  ],
                ),
                Row(
               
                  children: [
                    Text("Plan Duration: ",  style: Theme.of(context).textTheme.headline4,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          width: 17.0,
                          height: 17.0,
                        ),
                        Text(
                          "20000",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
      
                  ],
                ),
                Row(
               
                  children: [
                    Text("Plan Duration: ",  style: Theme.of(context).textTheme.headline4,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          width: 17.0,
                          height: 17.0,
                        ),
                        Text(
                          "20000",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
      
                  ],
                ),
                Row(
               
                  children: [
                    Text("Plan Duration: ",  style: Theme.of(context).textTheme.headline4,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          width: 17.0,
                          height: 17.0,
                        ),
                        Text(
                          "20000",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
      
                  ],
                ),
                Row(
               
                  children: [
                    Text("Plan Duration: ",  style: Theme.of(context).textTheme.headline4,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/rupee.png",
                          width: 17.0,
                          height: 17.0,
                        ),
                        Text(
                          "20000",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
      
                  ],
                ),
      
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: false, 
                      onChanged: (value) {
                        
                      },
                      ),
                      
                      Text("Terms & Conditions")
      
                  ],
                ),
                   SizedBox(height: 10.0,),
                    GestureDetector(
                    onTap: () async {
                      
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 15.0),
                      
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0),
                        )),
                  ),
      
      
      
                ],
              ),
            )
           
          ],
        ),
      ),
    );
  }
}
