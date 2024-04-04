import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FilterSubOptionsWidget extends StatefulWidget {
  final Map<String, dynamic> subOptions;
  final int index;
  final double width;

  final String filterKey;
  FilterSubOptionsWidget(
      {super.key,
      required this.subOptions,
      required this.index,
      required this.filterKey,
      required this.width});

  @override
  State<FilterSubOptionsWidget> createState() => _FilterSubOptionsWidgetState();
}

class _FilterSubOptionsWidgetState extends State<FilterSubOptionsWidget> {
  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAlreadySelectedFilters();
  }

  showAlreadySelectedFilters() {
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);
    for (var i = 0; i < filterOptionsProvider.list.length; i++) {
      if (filterOptionsProvider.list[i]["parent"] == widget.filterKey &&
          filterOptionsProvider.list[i]["id"] == widget.subOptions["id"]) {
        if (mounted) {
          setState(() {
            isSelected = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final filterOptionsProvider =
    //     Provider.of<FilterOptionsProvider>(context, listen: true);
    // final filterOptionsProvider =
    //     Provider.of<FilterOptionsProvider>(context, listen: false);
    // for (var i = 0; i < filterOptionsProvider.list.length; i++) {
    //   if (filterOptionsProvider.list[i]["parent"] == widget.filterKey &&
    //       filterOptionsProvider.list[i]["id"] == widget.subOptions["id"]) {
    //     setState(() {
    //       isSelected = true;
    //     });
    //   }
    // }

    print("filterKey ${widget.filterKey}");

    return Consumer<FilterOptionsProvider>(
      builder: (context, value, child) {
        // for (var i = 0; i < value.list.length; i++) {
        //   if (value.list[i]["parent"] == widget.filterKey &&
        //       value.list[i]["id"] == widget.subOptions["id"]) {
        //     if (mounted) {
        //       setState(() {
        //         isSelected = true;
        //       });
        //     }
        //   }
        // }

        return GestureDetector(
          onTap: () {
            if (value.list.length > 0) {
              for (var i = 0; i < value.list.length; i++) {
                print("value.list before ${value.list}");
                // print(
                //     "value.list[i].containsValue(selectedSubOptionsdataid ${value.list[i].containsValue(widget.subOptions["id"])}");

                // print(
                //     "value.list[i].containsValue(selectedSubOptionsdataparent) ${value.list[i].containsValue(widget.filterKey)}");
                if (value.list[i].containsValue(widget.subOptions["id"]) &&
                    value.list[i].containsValue(widget.filterKey)) {
                  print("list $value.list");
                  value.removeFromList(i);
                  if (mounted) {
                    setState(() {
                      isSelected = false;
                    });
                  }
                  return;
                }
              }
            }

            if (widget.filterKey == "price_range") {
              if (value.list.length > 0) {
                for (var i = 0; i < value.list.length; i++) {
                  if (value.list[i].containsValue(widget.filterKey)) {
                    value.removeFromList(i);
                    if (mounted) {
                      setState(() {
                        isSelected = false;
                      });
                    }
                  }
                }
              }
            }

            value.setSelectedSubOptionsdata({
              "id": widget.subOptions["id"],
              "count": widget.subOptions["count"],
              "label": widget.subOptions["label"],
              "parent": widget.filterKey
            });

            print("value.list after ${value.list}");

            for (var i = 0; i < value.list.length; i++) {
              if (value.list[i]["parent"] == widget.filterKey &&
                  value.list[i]["id"] == widget.subOptions["id"]) {
                if (mounted) {
                  setState(() {
                    isSelected = true;
                  });
                }
              }
            }
          },
          child: Container(
            width: widget.width,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double deviceWidth = MediaQuery.of(context).size.width;

                print(
                    "filter suboption constraints.maxWidth / 2 ${constraints.maxWidth / 23}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: constraints.maxWidth - 100,
                          child: Text(
                            widget.subOptions["label"] ??
                                "filter${widget.index}",
                            maxLines: 2,
                            style: isSelected
                                ? TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: deviceWidth > 600 ?
                                      constraints.maxWidth / 23
                                      : 14.5.sp)
                                : TextStyle(
                                   
                                    fontWeight: FontWeight.normal,
                                    fontSize: deviceWidth > 600 ?
                                      constraints.maxWidth / 23
                                      : 14.5.sp),
                          )),
                      Text(
                        widget.subOptions["count"].toString(),
                        style: isSelected
                            ? TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: deviceWidth > 600 ?
                                      constraints.maxWidth / 23
                                      : 14.5.sp)
                            : TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize:  deviceWidth > 600 ?
                                      constraints.maxWidth / 23
                                      : 14.5.sp),
                      )
                    ],
                  ),
                );
              },
              //child:
            ),
          ),
        );
      },
    );
  }
}
