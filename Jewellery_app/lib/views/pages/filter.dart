import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<Map<String, dynamic>> map = <Map<String, dynamic>>[
    {"id": "price", "value": "Price"},
    {"id": "collection", "value": "Collections"},
    {"id": "purity", "value": "Purity"},
    {"id": "weight", "value": "Weight"},
    {"id": "diamond", "value": "Diamond"},
  ];

  double selectedMin = 1000.0;
  double selectedMax = 100000.0;

  late Widget priceRange;

  bool _isDisposed = false;

   @override
  void dispose() {
    // Dispose of any resources (e.g., listeners, controllers) here
    // Set the flag to true to indicate that the widget is disposed
    _isDisposed = true;
    super.dispose();
  }

  _FilterState(){
    priceRange = Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width / 3),
        height: (MediaQuery.of(context).size.height / 2) - 77,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: Text(
                "Price Range",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/rupee.png",
                  width: 19.0,
                  height: 17.0,
                ),
                Text(
                  " ${selectedMin.toInt()} - ",
                ),
                Image.asset(
                  "assets/images/rupee.png",
                  width: 19.0,
                  height: 17.0,
                ),
                Text(
                  " ${selectedMax.toInt()}",
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            RangeSlider(
              min: 500.0,
              max: 139080.0,
              values: RangeValues(selectedMin, selectedMax),
              onChanged: (value) {
                print("SELECTED VALUE $value");
                setState(() {
                  selectedMin = value.start;
                  selectedMax = value.end;
                });
              },
              labels:
                  RangeLabels(selectedMin.toString(), selectedMax.toString()),
            )
          ],
        ),
      );
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
      
  }

  @override
  Widget build(BuildContext context) {
    var selectedFilterIndex = 0;
 if (_isDisposed) {
      return SizedBox(); // Return an empty widget if disposed
    } else {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Filter By",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Divider(
                thickness: 2.0,
              ),
              Row(
                children: [
                  Container(
                    color: Colors.yellow,
                    width: MediaQuery.of(context).size.width / 3,
                    height: (MediaQuery.of(context).size.height / 2) - 77,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final filters = map[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedFilterIndex = index;
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 10.0, top: 10.0, bottom: 10.0),
                                color: Colors.blue,
                                height: 45.0,
                                width: MediaQuery.of(context).size.width / 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(filters["value"]),
                                    Container(
                                      color: Colors.red,
                                      width: 3.0,
                                    ),
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey,
                            thickness: 2.0,
                          );
                        },
                        itemCount: map.length),
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  ),
                  showSelectedWindow(selectedFilterIndex)
                ],
              )
            ],
          )),
    );
    }
  }

  Widget showSelectedWindow(int selectedFilterIndex) {
    Widget window = SizedBox();
    switch (selectedFilterIndex) {
      case 0:
        window = priceRange;
        break;
      default:
        window = SizedBox();
    }

    return window;
  }
}
