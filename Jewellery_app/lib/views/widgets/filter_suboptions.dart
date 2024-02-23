import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_suboption_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterSubOptions extends StatefulWidget {
  final int selectedFilterIndex;
  final String filterKey;
  const FilterSubOptions(
      {super.key, required this.selectedFilterIndex, required this.filterKey});

  @override
  State<FilterSubOptions> createState() => _FilterSubOptionsState();
}

class _FilterSubOptionsState extends State<FilterSubOptions> {
  // int selectedFilterSubOptionIndex = -1;
  @override
  Widget build(BuildContext context) {
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    List<Map<String, dynamic>> listOfSubOptions = <Map<String, dynamic>>[];

    print(
        "filterOptionsProvider.filterCollectionsOptionsdata length ${filterOptionsProvider.list.length}");

    // print("selectedFilterSubOptionIndex out of return $selectedFilterSubOptionIndex");

    switch (widget.filterKey) {
      case "collection":
        listOfSubOptions = filterOptionsProvider.filterCollectionsOptionsdata;
        break;
      case "categories":
        listOfSubOptions = filterOptionsProvider.filterCategoryOptionsdata;
        break;
      case "sub-categories":
        listOfSubOptions = filterOptionsProvider.filterSubCategoriesOptionsdata;
        break;
      case "tags":
        listOfSubOptions = filterOptionsProvider.filterTagsOptionsdata;
        break;
      case "diamond_wt":
        listOfSubOptions = filterOptionsProvider.filterDiamondWtOptionsdata;
        break;
      case "gold_wt":
        listOfSubOptions = filterOptionsProvider.filterGoldWtOptionsdata;
        break;
      case "gender":
        listOfSubOptions = filterOptionsProvider.filterGenderOptionsdata;
        break;
      default:
        listOfSubOptions = <Map<String, dynamic>>[];
    }

    return Container(
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width / 3),
      height: (MediaQuery.of(context).size.height / 2) - 77,
      child: Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) {
            print("listOfSubOptions length ${listOfSubOptions.length}");
            Map<String, dynamic> subOptions = listOfSubOptions[index];

            print("subOptions $subOptions");

            //print("CURRENT INDEX $index AND SELECTED INDEX $selectedFilterSubOptionIndex");

            return FilterSubOptionsWidget(
              subOptions: subOptions,
             index: index,

              //isFilterSubOptionClicked: index == selectedFilterSubOptionIndex,
              // onTap: () {
              //   // if (mounted) {
      //setState(() {});
              //   //   selectedFilterSubOptionIndex = index;
              //   // });
                
              // },
              filterKey: widget.filterKey,
            );
          },
          itemCount: listOfSubOptions.length,
        ),
      ),
    );
  }
}
