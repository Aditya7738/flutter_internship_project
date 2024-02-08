import 'package:Tiara_by_TJ/views/widgets/filter_suboptions.dart';
import 'package:flutter/material.dart';

class FilterOptions extends StatefulWidget {
  final int selectedFilterIndex;
  FilterOptions({super.key, required this.selectedFilterIndex});

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  Widget window = SizedBox();
  double selectedMin = 1000.0;
  double selectedMax = 100000.0;
  @override
  Widget build(BuildContext context) {
////////////////////////////////////////////////////////////////////////

    Widget priceRange = Container(
      
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
            labels: RangeLabels(selectedMin.toString(), selectedMax.toString()),
          )
        ],
      ),
    );

    // Widget purityFilter = Container(

    //   width: MediaQuery.of(context).size.width -
    //       (MediaQuery.of(context).size.width / 3),
    //   height: (MediaQuery.of(context).size.height / 2) - 77,
    //   child: ListView.builder(
    //     itemBuilder: (context, index) {
    //       return Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text("14 KT"),
    //             Container(
    //               decoration: BoxDecoration(
    //                 shape: BoxShape.rectangle,
    //                 borderRadius: BorderRadiusDirectional.horizontal(start:  Radius.circular(10.0), end: Radius.circular(10.0)),
    //                 border: Border.all(color: Theme.of(context).primaryColor, style: BorderStyle.solid, width: 2.0),),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                 child: Text("1"),
    //               ),
    //             )
    //           ],
    //         ),
    //       );
    //     },
    //     itemCount: 2,
    //   ),
    // );

    // Widget weightFilter =

    // Widget sortByDiamond =

    print("widget.selectedFilterIndex ${widget.selectedFilterIndex}");

    if (widget.selectedFilterIndex == 0) {
      window = priceRange;
      return window;
    }else{
      return FilterSubOptions();
    }
    
  
  }
}
