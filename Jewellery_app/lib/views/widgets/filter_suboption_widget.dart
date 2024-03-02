import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSubOptionsWidget extends StatefulWidget {
  final Map<String, dynamic> subOptions;
  final int index;

  final String filterKey;
  FilterSubOptionsWidget(
      {super.key,
      required this.subOptions,
      required this.index,
      required this.filterKey});

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
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.subOptions["label"] ?? "filter${widget.index}",
                    maxLines: 2,
                    style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                        fontSize: 15.0),
                  ),
                ),
                Text(
                  widget.subOptions["count"].toString(),
                  style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                      fontSize: 15.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
