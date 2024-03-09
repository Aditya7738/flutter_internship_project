import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_suboptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterOptions extends StatefulWidget {
  final int selectedFilterIndex;
  final String filterKey;
  FilterOptions(
      {super.key, required this.selectedFilterIndex, required this.filterKey});

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  //Widget window = SizedBox();
  double selectedMin = 1000.0;
  double selectedMax = 100000.0;
  @override
  Widget build(BuildContext context) {
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);
    // Map<String, dynamic> selectedSubOptionsdata =
    //     filterOptionsProvider.selectedSubOptionsdata;

    // if (selectedSubOptionsdata.containsKey("price_range")) {
    //   selectedMin = selectedSubOptionsdata["price_range"]["min_price"].toDouble();
    //   selectedMax = selectedSubOptionsdata["price_range"]["max_price"].toDouble();
    // }

    List<Map<String, dynamic>> selectedSubOptions = filterOptionsProvider.list;

    for (var i = 0; i < selectedSubOptions.length; i++) {
      if (selectedSubOptions[i]["parent"] == "price_range") {
        selectedMin =
            selectedSubOptions[i]["price_range"]["min_price"].toDouble();
        selectedMax =
            selectedSubOptions[i]["price_range"]["max_price"].toDouble();
      }
    }

    Widget priceRange = Container(
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width / 3),
      height: (MediaQuery.of(context).size.height / 2) - 77,
      child: LayoutBuilder(
        builder: (context, constraints) {
          print(
              "Price Range constraints.maxWidth ${constraints.maxWidth / 25}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  "Price Range",
                  style: TextStyle(fontSize: constraints.maxWidth / 25),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ ${selectedMin.toInt()} - ₹ ${selectedMax.toInt()}",
                    style: TextStyle(fontSize: constraints.maxWidth / 25),
                  ),
                  // Image.asset(
                  //   "assets/images/rupee.png",
                  //   width: 19.0,
                  //   height: 17.0,
                  // ),
                  // Text(
                  //   "",
                  // ),
                  // Image.asset(
                  //   "assets/images/rupee.png",
                  //   width: 19.0,
                  //   height: 17.0,
                  // ),
                  // Text(
                  //   " ${selectedMax.toInt()}",
                  // )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RangeSlider(
                  activeColor: Theme.of(context).primaryColor,
                  min: 500.0,
                  max: 139080.0,
                  values: RangeValues(selectedMin, selectedMax),
                  onChanged: (value) {
                    print("SELECTED VALUE $value");
                    if (mounted) {
                      setState(() {
                        selectedMin = value.start;
                        selectedMax = value.end;
                      });
                    }
                  },
                  onChangeEnd: (value) {
                    filterOptionsProvider.setSelectedSubOptionsdata({
                      "price_range": {
                        "min_price": value.start.toInt(),
                        "max_price": value.end.toInt()
                      },
                      "parent": "price_range"
                    });
                    print(
                        "filterOptionsProvider.list ${filterOptionsProvider.list}");
                  },
                  labels: RangeLabels(
                      selectedMin.toString(), selectedMax.toString()),
                ),
              )
            ],
          );
        },
        //child:
      ),
    );

    print("widget.selectedFilterIndex ${widget.selectedFilterIndex}");

    if (widget.selectedFilterIndex == 0) {
      //print("0 in widget.selectedFilterIndex ${widget.selectedFilterIndex}");
      //window = priceRange;
      return priceRange;
    } else {
      //  print("else in widget.selectedFilterIndex ${widget.selectedFilterIndex}");
      return FilterSubOptions(
          selectedFilterIndex: widget.selectedFilterIndex,
          filterKey: widget.filterKey);
    }
  }
}
