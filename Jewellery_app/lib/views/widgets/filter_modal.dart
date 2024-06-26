import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/model/filter_options_model.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_options.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FilterModal extends StatefulWidget {
  final String searchText;

  final bool fromProductsPage;
  int? categoryId;
  FilterModal(
      {super.key,
      required this.searchText,
      required this.fromProductsPage,
      this.categoryId});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<Map<String, String>> map = <Map<String, String>>[
    {"id": "price_range", "value": "Price"},
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

  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    /// if (selectedFilterIndex != -1) {
    final filtersToSend = map[selectedFilterIndex];

    print("filtersToSendValue ${filtersToSend["id"]!}");
    // }

    // double width = MediaQuery.of(context).size.width;
    // print("tablet width = $width");
    // if (width > 600) {
    //   width = 600.0;
    // }
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.66,
        //MediaQuery.of(context).size.height / 1.66,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: deviceWidth > 600 ? 65.0 : 45.0,
                // height:
                // //constraints.maxWidth / 12.5,
                //  (constraints.maxWidth/ 12) + 6 ,
                padding:
                    const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 5.0),
                child: FittedBox(
                  child: Text(
                    "Filter By",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            Divider(
              thickness: 2.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          vertical: BorderSide(
                              color: Colors.black, style: BorderStyle.solid))),
                  width: MediaQuery.of(context).size.width / 3,
                  height: (MediaQuery.of(context).size.height / 2) - 76,
                  child: Scrollbar(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final filters = map[index];

                          // print("filtersValue ${filters["id"]!}");

                          return FilterTile(
                            isFilterTileClicked: index == selectedFilterIndex,
                            option: filters["value"]!,
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  selectedFilterIndex = index;
                                });
                              }
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
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                // selectedFilterIndex == -1
                //     ? SizedBox()
                //     :
                FilterOptions(
                    selectedFilterIndex: selectedFilterIndex,
                    filterKey:
                        // selectedFilterIndex != -1
                        //     ?
                        map[selectedFilterIndex]["id"]!
                    //: ""
                    ),
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
                  Consumer<FilterOptionsProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.pop(context, true);
                          bool isThereInternet =
                              await ApiService.checkInternetConnection(context);

                          if (isThereInternet) {
                            value.setFilteredListLoading(true);

                            value.clearFilterList();

                            print(
                                "filterOptionsProvider.list length ${value.list.length}");
                            if (widget.fromProductsPage) {
                              ApiService.listOfProductsCategoryWise.clear();

                              await ApiService.fetchSearchedProductCategoryWise(
                                  searchText: widget.searchText,
                                  id: widget.categoryId!,
                                  pageNo: 1,
                                  filterList: value.list);
                            } else {
                              ApiService.listOfProductsModel.clear();
                              await ApiService.fetchProducts(
                                  widget.searchText, 1,
                                  filterList: value.list);
                            }

                            value.setFilteredListLoading(false);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(int.parse(
                                        "0xff${layoutDesignProvider.primary.substring(1)}")),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text("Clear all",
                                style: TextStyle(
                                    color: Color(int.parse(
                                        "0xff${layoutDesignProvider.primary.substring(1)}")),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp)
                                // TextStyle(
                                //     color: Color(int.parse(
                                // "0xff${layoutDesignProvider.primary.substring(1)}")),
                                //     fontSize: 17.0),
                                )),
                      );
                    },
                    //child:
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Consumer<FilterOptionsProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.pop(context, true);
                          bool isThereInternet =
                              await ApiService.checkInternetConnection(context);

                          if (isThereInternet) {
                            if (widget.fromProductsPage) {
                              categoryProvider
                                  .setIsCategoryProductFetching(true);
                              ApiService.listOfProductsCategoryWise.clear();

                              await ApiService.fetchSearchedProductCategoryWise(
                                  searchText: widget.searchText,
                                  id: widget.categoryId!,
                                  pageNo: 1,
                                  filterList: value.list);
                              categoryProvider
                                  .setIsCategoryProductFetching(false);
                            } else {
                              value.setFilteredListLoading(true);
                              ApiService.listOfProductsModel.clear();
                              await ApiService.fetchProducts(
                                  widget.searchText, 1,
                                  filterList: value.list);
                              value.setFilteredListLoading(false);
                            }
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child:
                                Text("Apply", style: Fontsizes.buttonTextStyle

                                    //  TextStyle(
                                    //     color: Colors.white, fontSize: 17.0),
                                    )),
                      );
                    },
                    //child:
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
