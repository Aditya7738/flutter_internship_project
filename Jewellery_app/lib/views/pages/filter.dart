import 'package:Tiara_by_TJ/model/filter_options_model.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_options.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_tile.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<Map<String, String>> map = <Map<String, String>>[
    {"id": "price", "value": "Price"},
    {"id": "collection", "value": "Collections"},
    {"id": "categories", "value": "Categories"},
    {"id": "sub-categories", "value": "Sub-categories"},
    {"id": "tags", "value": "Tags"},
    {"id": "diamond_wt", "value": "Diamond weight"},
    {"id": "gold_wt", "value": "Gold weight"},
    {"id": "gender", "value": "Gender"},
  ];

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedFilterIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.66,
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
                    decoration: BoxDecoration(
                      border: Border.symmetric(vertical: BorderSide(color: Colors.black,
                                  style: BorderStyle.solid))
                    ),
                   
                    width: MediaQuery.of(context).size.width / 3,
                    height: (MediaQuery.of(context).size.height / 2) - 76,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final filters = map[index];

                          return FilterTile(
                            isFilterTileClicked: index == selectedFilterIndex,
                            option: filters["value"]!,
                            onTap: () {
                              setState(() {
                                selectedFilterIndex = index;
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                          );
                        },
                        itemCount: map.length),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  FilterOptions(selectedFilterIndex: selectedFilterIndex),
                ],
              ),
              Divider(
                thickness: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            "Clear all",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0),
                          )),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: const Text(
                            "Apply",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  // Widget showSelectedWindow(int selectedFilterIndex) {

  //   return window;
  // }
}
