import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSubOptionsWidget extends StatefulWidget {
  final Map<String, dynamic> subOptions;
  final int index;
  //final bool isFilterSubOptionClicked;
  // final VoidCallback onTap;
  final String filterKey;
  FilterSubOptionsWidget(
      {super.key,
      required this.subOptions,
      required this.index,
      // required this.isFilterSubOptionClicked,
      //  required this.onTap,
      required this.filterKey});

  @override
  State<FilterSubOptionsWidget> createState() => _FilterSubOptionsWidgetState();
}

class _FilterSubOptionsWidgetState extends State<FilterSubOptionsWidget> {
  //late Map<String, dynamic> subOptions;

//  bool filterAlreadyThere = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //subOptions = widget.subOptions;
  }

 // bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: true);
    List<Map<String, dynamic>> selectedSubOptions = filterOptionsProvider.list;

    print("filterKey ${widget.filterKey}");

    // for (var i = 0; i < selectedSubOptions.length; i++) {
    //   print("selectedSubOptions parent ${selectedSubOptions[i]["parent"]}");
    //   print(
    //       "is contain widget.filterKey ${selectedSubOptions[i]["parent"] == widget.filterKey}");

    //   if (selectedSubOptions[i]["parent"] == widget.filterKey) {
    //     print("selectedSubOptions[i][id] ${selectedSubOptions[i]["id"]}");
    //     print("widget.subOptionsid ${widget.subOptions["id"]}");
    //     if (selectedSubOptions[i]["id"] == widget.subOptions["id"]) {
    //       setState(() {
    //         isSelected = true;
    //       });
    //     }
    //   } else {
    //     setState(() {
    //       isSelected = false;
    //     });
    //   }
    // }

    //////////////////////////////////
    // if (selectedSubOptionsdata.containsKey(widget.filterKey)) {
    //   print("selectedSubOptionsdata[widget.filterKey]id ${selectedSubOptionsdata[widget.filterKey]}");
    //   print("widget.subOptionsid ${widget.subOptions["id"]}");
    //   if(selectedSubOptionsdata[widget.filterKey] == widget.subOptions["id"]){
    //     isSelected = true;
    //   }

    // }

    // print("widget.isFilterSubOptionClicked ${widget.isFilterSubOptionClicked}");
    // print("isSelected ${isSelected}");
    // print("filterAlreadyThere $filterAlreadyThere");

    return GestureDetector(
      onTap: () {
        // print("filterOptionsProvider.list ${filterOptionsProvider.list}");
        // print("subOptionsparent ${widget.filterKey}");
        // if (filterOptionsProvider.list.length > 0) {
        //   for (var i = 0; i < filterOptionsProvider.list.length; i++) {
        //     print(
        //         "containsValue subOptionsid ${filterOptionsProvider.list[i].containsValue(widget.subOptions["id"])}");

        //     print(
        //         "ContainsValueSubOptionParent ${filterOptionsProvider.list[i].containsValue(widget.filterKey)}");
        //     print("subOptionsid ${widget.subOptions["id"]}");

        //     if (filterOptionsProvider.list[i]
        //             .containsValue(widget.subOptions["id"]) &&
        //         filterOptionsProvider.list[i].containsValue(widget.filterKey)) {
        //       setState(() {
        //         filterAlreadyThere = true;
        //       });
        //       filterOptionsProvider.removeFromList(i);
        //     } else {
        //       // setState(() {
        //       //   filterAlreadyThere = false;
        //       // });
        filterOptionsProvider.setSelectedSubOptionsdata({
          "id": widget.subOptions["id"],
          "count": widget.subOptions["count"],
          "label": widget.subOptions["label"],
          "parent": widget.filterKey
        });
        //       break;
        //     }
        //   }
        // } else {
        //   // setState(() {
        //   //   filterAlreadyThere = false;
        //   // });
        //   filterOptionsProvider.setSelectedSubOptionsdata({
        //     "id": widget.subOptions["id"],
        //     "count": widget.subOptions["count"],
        //     "label": widget.subOptions["label"],
        //     "parent": widget.filterKey
        //   });
        // }

        print("filterOptionsProvider.list ${filterOptionsProvider.list}");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Consumer<FilterOptionsProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    bool isSelected = false;
                    for (var i = 0; i < value.list.length; i++) {
                      if (value.list[i]["parent"] == widget.filterKey &&
                          value.list[i]["id"] == widget.subOptions["id"]) {
                        isSelected = true;
                      }
                    }

                    return Text(
                      widget.subOptions["label"] ?? "filter${widget.index}",
                      maxLines: 2,
                      style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                          //widget.isFilterSubOptionClicked ||
                          // isSelected
                          //     ? filterAlreadyThere
                          //         ? Colors.black
                          //         : Theme.of(context).primaryColor
                          //     : Colors.black,

                          fontSize: 15.0),
                    );
                  },
                )),
            Consumer<FilterOptionsProvider>(
              builder: (BuildContext context, value, Widget? child) {
                bool isSelected = false;
                    for (var i = 0; i < value.list.length; i++) {
                      if (value.list[i]["parent"] == widget.filterKey &&
                          value.list[i]["id"] == widget.subOptions["id"]) {
                        isSelected = true;
                      }
                    }
                return Text(
                  widget.subOptions["count"].toString(),
                  style: TextStyle(
                      color:
                          //widget.isFilterSubOptionClicked ||
                         isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                      fontSize: 15.0),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
