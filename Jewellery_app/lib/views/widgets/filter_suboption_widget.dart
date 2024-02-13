import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSubOptionsWidget extends StatefulWidget {
  final Map<String, dynamic> subOptions;
  final int index;
  //final bool isFilterSubOptionClicked;
  final VoidCallback onTap;
  final String filterKey;
  FilterSubOptionsWidget(
      {super.key,
      required this.subOptions,
      required this.index,
     // required this.isFilterSubOptionClicked,
      required this.onTap,
       required this.filterKey});

  @override
  State<FilterSubOptionsWidget> createState() => _FilterSubOptionsWidgetState();
}

class _FilterSubOptionsWidgetState extends State<FilterSubOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);
    List<Map<String, dynamic>> selectedSubOptions =
        filterOptionsProvider.list;

    bool isSelected = false;
    for (var i = 0; i < selectedSubOptions.length; i++) {
      
       if ( selectedSubOptions[i].containsKey(widget.filterKey)) {
      print("selectedSubOptions[i][widget.filterKey]id ${ selectedSubOptions[i][widget.filterKey]}");
      print("widget.subOptionsid ${widget.subOptions["id"]}");
      if( selectedSubOptions[i][widget.filterKey] == widget.subOptions["id"]){
        isSelected = true;
      }
     
    }
    }
    // if (selectedSubOptionsdata.containsKey(widget.filterKey)) {
    //   print("selectedSubOptionsdata[widget.filterKey]id ${selectedSubOptionsdata[widget.filterKey]}");
    //   print("widget.subOptionsid ${widget.subOptions["id"]}");
    //   if(selectedSubOptionsdata[widget.filterKey] == widget.subOptions["id"]){
    //     isSelected = true;
    //   }
     
    // }

   // print("widget.isFilterSubOptionClicked ${widget.isFilterSubOptionClicked}");
    print("isSelected ${isSelected}");


    return GestureDetector(
      onTap: widget.onTap,
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
                      color:
                       //widget.isFilterSubOptionClicked || 
                       isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                      fontSize: 15.0),
                )),
            Text(
              widget.subOptions["count"].toString(),
              style: TextStyle(
                  color: 
                  //widget.isFilterSubOptionClicked || 
                  isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                  fontSize: 15.0),
            )
          ],
        ),
      ),
    );
    ;
  }
}
