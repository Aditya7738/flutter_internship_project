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
  int selectedFilterSubOptionIndex = -1;
  @override
  Widget build(BuildContext context) {
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    List<Map<String, dynamic>> listOfSubOptions = <Map<String, dynamic>>[];

    print(
        "filterOptionsProvider.filterCollectionsOptionsdata length ${filterOptionsProvider.filterCollectionsOptionsdata.length}");

    // switch (widget.selectedFilterIndex) {
    //   case 1:
    //     listOfSubOptions = filterOptionsProvider.filterCollectionsOptionsdata;
    //     break;
    //   case 2:
    //     listOfSubOptions = filterOptionsProvider.filterCategoryOptionsdata;
    //     break;
    //   case 3:
    //     listOfSubOptions = filterOptionsProvider.filterSubCategoriesOptionsdata;
    //     break;
    //   case 4:
    //     listOfSubOptions = filterOptionsProvider.filterTagsOptionsdata;
    //     break;
    //   case 5:
    //     listOfSubOptions = filterOptionsProvider.filterDiamondWtOptionsdata;
    //     break;
    //   case 6:
    //     listOfSubOptions = filterOptionsProvider.filterGoldWtOptionsdata;
    //     break;
    //   case 7:
    //     listOfSubOptions = filterOptionsProvider.filterGenderOptionsdata;
    //     break;
    //   default:
    //     listOfSubOptions = <Map<String, dynamic>>[];
    // }

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
           
            print("listOfSubOptions legth ${listOfSubOptions.length}");
            Map<String, dynamic> subOptions = listOfSubOptions[index];
        
            print("subOptions $subOptions");
        
            return FilterSubOptionsWidget(
              subOptions: subOptions,
              index: index,
              isFilterSubOptionClicked: index == selectedFilterSubOptionIndex,
              onTap: () {
                setState(() {
                  selectedFilterSubOptionIndex = index;
                });
        
                switch (widget.filterKey) {
                  case "collection":
                    filterOptionsProvider.setSelectedSubOptionsdata({
                      "collection": subOptions["id"],
                      "collectionCount": subOptions["count"]

                    });
                    break;
                  case "categories":
                     filterOptionsProvider.setSelectedSubOptionsdata({
                      "categories": subOptions["id"],
                      "categoriesCount": subOptions["count"]
                    });
                    break;
                  case "sub-categories":
                     filterOptionsProvider.setSelectedSubOptionsdata({
                      "sub-categories": subOptions["id"],
                      "subCategoriesCount": subOptions["count"]
                    });
                    break;
                  case "tags":
                     filterOptionsProvider.setSelectedSubOptionsdata({
                      "tags": subOptions["id"],
                      "tagsCount": subOptions["count"]
                    });
                    break;
                  case "diamond_wt":
                     filterOptionsProvider.setSelectedSubOptionsdata({
                      "diamond_wt": subOptions["id"],
                      "diamond_wtCount": subOptions["count"]
                    });
                    break;
                  case "gold_wt":
                     filterOptionsProvider.setSelectedSubOptionsdata({
                      "gold_wt": subOptions["id"],
                      "gold_wtCount": subOptions["count"]
                    });
                    break;
                  case "gender":
                     filterOptionsProvider.setSelectedSubOptionsdata({
                      "gender": subOptions["id"],
                      "genderCount": subOptions["count"]
                    });
                    break;
                  default:
                    listOfSubOptions = <Map<String, dynamic>>[];
                }
        
                print("filterOptionsProvider.selectedSubOptionsdata ${filterOptionsProvider.selectedSubOptionsdata}");
              },
            );
        
            // return Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SizedBox(
            //           width: MediaQuery.of(context).size.width / 2,
            //           child: Text(
            //             subOptions["label"] ?? "filter$index",
            //             maxLines: 2,
            //             style: TextStyle(fontSize: 15.0),
            //           )),
            //       Text(subOptions["count"].toString())
            //     ],
            //   ),
            // );
          },
          itemCount: listOfSubOptions.length,
        ),
      ),
    );
  }
}
