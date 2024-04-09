import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isSearchBarUsed = false;
  bool isThereMoreProducts = true;
  bool newListLoading = false;
  bool isSearchFieldEmpty = false;

  String searchText = "";

  bool isProductListEmpty = false;
  //List<Map<String, dynamic>> appliedFilter = <Map<String, dynamic>>[];
  late FilterOptionsProvider filterOptionsProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    print(
        "filterOptionsProvider.list.length ${filterOptionsProvider.list.length}");
    filterOptionsProvider.clearFilterList();
    ApiService.listOfProductsModel.clear();
    _scrollController.addListener(() async {
      print(
          "CONDITION ${_scrollController.position.pixels == _scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("REACHED END OF LIST");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          // This code will run after the layout and rendering are complete
          // Access the size or position of the widget
          loadMoreData();
        });
      }
    });
  }

  void loadMoreData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // Fetch more data (e.g., using ApiService)
    isThereMoreProducts = await ApiService.showNextPagesProduct(context);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("search page dispose called");
    _scrollController.dispose();

    // final filterOptionsProvider =
    //     Provider.of<FilterOptionsProvider>(context, listen: false);
    filterOptionsProvider.setFilteredListLoading(false);
    filterOptionsProvider.clearFilterList();
    super.dispose();
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    final filterOptionsProvider = Provider.of<FilterOptionsProvider>(context);
    print("kToolbarHeight - 37.5 ${kToolbarHeight - 37.5}");
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: SizedBox(
            height: 50.0,
            child: TextField(
              controller: textEditingController,
              style: TextStyle(
                  fontSize: deviceWidth > 600
                      ? (kToolbarHeight - 37) + 2
                      : (kToolbarHeight - 40),
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              onSubmitted: (value) async {
                if (value == "") {
                  ApiService.listOfProductsModel.clear();
                  // if (mounted) {
                  // setState(() {
                  //   isSearchFieldEmpty = true;
                  // });
                }

                if (mounted) {
                  setState(() {
                    isSearchFieldEmpty = false;
                  });
                }

                if (value.length >= 3 && !newListLoading) {
                  bool isThereInternet =
                      await ApiService.checkInternetConnection(context);

                  if (isThereInternet) {
                    ApiService.listOfProductsModel.clear();
                    if (mounted) {
                      setState(() {
                        newListLoading = true;
                      });
                    }

                    List<ProductsModel> listOfProducts =
                        await ApiService.fetchProducts(value, 1);

                    if (mounted) {
                      setState(() {
                        newListLoading = false;
                        isProductListEmpty = listOfProducts.length == 0;
                      });
                    }

                    //ApiService.searchProduct(value);
                    print("ONCHANGED CALLED");
                    if (mounted) {
                      setState(() {
                        isSearchBarUsed = true;
                        searchText = value;
                      });
                    }
                  }
                }
              },
              showCursor: true,
              maxLines: 1,
              autofocus: true,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                  fillColor: Colors.grey,
                  hintText: "Search for jewelleries",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: deviceWidth > 600
                        ? (kToolbarHeight - 37) + 2
                        : (kToolbarHeight - 39),
                  )),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (textEditingController.text == "") {
                  return;
                } //- uncomment it
                showModalBottomSheet(
                  constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width,
                      height:
                          (MediaQuery.of(context).size.height / 1.78) + 40.0),
                  isDismissible:
                      filterOptionsProvider.list.isEmpty ? true : false,
                  enableDrag: true,
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  builder: (context) {
                    return FilterModal(
                      searchText: searchText,
                      fromProductsPage: false,
                    );
                  },
                );

                // if (filterChanged) {
                //   if (mounted) {
                setState(() {});
                // }
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.black,
                    size: 30.0,
                  )),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - (kToolbarHeight * 2),
          child:
              Consumer<FilterOptionsProvider>(builder: (context, value, child) {
            List<Map<String, dynamic>> selectedSubOptionsdata = value.list;
            print("LENGTH ${value.list.length}");
            //value.clearFilterList;
            print("LENGTH ${value.list.length}");
            print("selectedSubOptionsdata ${selectedSubOptionsdata}");

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                value.list.isEmpty
                    ? SizedBox()
                    : SizedBox(
                        height: 70.0,
                        width: MediaQuery.of(context).size.width,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Consumer<FilterOptionsProvider>(
                                builder: (context, value, child) {
                              return ListView.builder(
                                padding: EdgeInsets.all(5.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: value.list.length,
                                itemBuilder: (context, index) {
                                  // print("value.list[index][parent] == price_range ${value.list[index]["parent"] == "price_range"}");

                                  // print( "₹${value.list[index]["price_range"]["min_price"]}");
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Chip(
                                        padding: EdgeInsets.all(7.0),
                                        label: Text(
                                            value.list[index]["parent"] ==
                                                    "price_range"
                                                ? "₹ ${value.list[index]["price_range"]["min_price"]} - ₹ ${value.list[index]["price_range"]["max_price"]}"
                                                : value.list[index]["label"],
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: deviceWidth > 600
                                                    ? constraints.maxHeight - 45
                                                    : constraints.maxHeight - 55
                                                // deviceWidth / 37,
                                                )

                                            // Theme.of(context)
                                            //     .textTheme
                                            //     .headline4

                                            //  TextStyle(
                                            //     fontSize: 16.0,
                                            //     fontWeight: FontWeight.bold),
                                            ),
                                        deleteIcon: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                            size:
                                                deviceWidth > 600 ? 24.0 : 16.0,
                                          ),
                                        ),
                                        onDeleted: () async {
                                          print("ONDELETED CALLED");

                                          print("index to remove $index");

                                          value.removeFromList(index);

                                          print("_list ${value.list}");

                                          //value.setFilteredListLoading(true);

                                          // Map<String, dynamic> selectedSubOptionsdata =
                                          //     value.selectedSubOptionsdata;

                                          // if (selectedSubOptionsdata
                                          //     .containsKey("collection")) {
                                          //   selectedSubOptionsdata["collection"] =
                                          //       "";
                                          // }

                                          // if (selectedSubOptionsdata
                                          //     .containsKey("categories")) {
                                          //   selectedSubOptionsdata["categories"] =
                                          //       "";
                                          // }

                                          // if (selectedSubOptionsdata
                                          //     .containsKey("sub-categories")) {
                                          //   selectedSubOptionsdata[
                                          //       "sub-categories"] = "";
                                          // }

                                          // if (selectedSubOptionsdata
                                          //     .containsKey("tags")) {
                                          //   selectedSubOptionsdata["tags"] = "";
                                          // }

                                          // if (selectedSubOptionsdata
                                          //     .containsKey("price_range")) {
                                          //   selectedSubOptionsdata["price_range"] =
                                          //       "";
                                          // }
                                          bool isThereInternet =
                                              await ApiService
                                                  .checkInternetConnection(
                                                      context);
                                          if (isThereInternet) {
                                            value.setFilteredListLoading(true);

                                            ApiService.listOfProductsModel
                                                .clear();
                                            await ApiService.fetchProducts(
                                                textEditingController.text, 1,
                                                filterList: value.list);
                                            value.setFilteredListLoading(false);
                                          }
                                        }),
                                  );
                                },
                              );

                              // print("appliedFilter legth 1 ${appliedFilter.length}");

                              // appliedFilter.clear();

                              // print("appliedFilter length 2 ${appliedFilter.length}");

                              // for (var i = 0; i < selectedSubOptionsdata.length; i++) {
                              //   appliedFilter[i] =
                              // }
                              // if (selectedSubOptionsdata.containsKey("collection")) {
                              //   appliedFilter["collection"] = {
                              //     "id":  selectedSubOptionsdata["collection"],
                              //     "label": selectedSubOptionsdata["collectionLabel"],
                              //   };

                              // }

                              // if (selectedSubOptionsdata.containsKey("categories")) {
                              //    appliedFilter["category"] = {
                              //     "id":  selectedSubOptionsdata["categories"],
                              //     "label": selectedSubOptionsdata["categoriesLabel"]
                              // };
                              // }

                              // if (selectedSubOptionsdata
                              //     .containsKey("sub-categories")) {
                              //   appliedFilter["subcategory"] = {
                              //     "id":  selectedSubOptionsdata["sub-categories"],
                              //     "label": selectedSubOptionsdata["subCategoriesLabel"]
                              // };
                              //     }

                              // if (selectedSubOptionsdata.containsKey("tags")) {
                              //    appliedFilter["tag"] = {
                              //     "id":  selectedSubOptionsdata["tags"],
                              //     "label": selectedSubOptionsdata["tagsLabel"],
                              // };
                              // }

                              // if (selectedSubOptionsdata.containsKey("price_range")) {
                              //    appliedFilter["price_range"] = {
                              //     "id":  selectedSubOptionsdata["price_range"],
                              //     "label": "₹ ${selectedSubOptionsdata["price_range"]["min_price"]} - ₹  ${selectedSubOptionsdata["price_range"]["max_price"]}"

                              // };
                              // }

                              // print("appliedFilter length ${appliedFilter.length}");
                            });
                          },
                          //  child:
                        )),
                value.list.isEmpty
                    ? SizedBox()
                    : Divider(
                        thickness: 2.0,
                      ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        print(
                            "constraints.maxWidth / 16 ${(constraints.maxWidth / 26) - 0.9}");
                        return Text(
                            "Showing ${ApiService.listOfProductsModel.length} results",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 27.0 : 15.0,
                                fontWeight: FontWeight.normal)
                            // TextStyle(
                            //     fontSize: (constraints.maxWidth / 26) - 0.9),
                            );
                      },
                    )),
                newListLoading || value.isFilteredListLoading
                    ? Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Color(int.parse(
                                "0xff${layoutDesignProvider.primary.substring(1)}")),
                          )),
                        ),
                      )
                    : isSearchFieldEmpty
                        ? const SizedBox()
                        : Expanded(
                            child: Scrollbar(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount:
                                      ApiService.listOfProductsModel.length +
                                          (isLoading || !isThereMoreProducts
                                              ? 1
                                              : 0), //TODO: error +1
                                  itemBuilder: (context, index) {
                                    if (index <
                                        ApiService.listOfProductsModel.length) {
                                      print(
                                          "ApiService.listOfProductsModel.length ${ApiService.listOfProductsModel.length}");
                                      ProductsModel productsModel =
                                          ApiService.listOfProductsModel[index];

                                      print(
                                          "${MediaQuery.of(context).size.width / 4}");
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailsPage(
                                                          productsModel:
                                                              productsModel)));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                            child: Card(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Card(
                                                      elevation: 0.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          child: LayoutBuilder(
                                                            builder: (context,
                                                                constraints) {
                                                              print(
                                                                  "constraints2.maxWidth ${(constraints.maxWidth)}");
                                                              return Image
                                                                  .network(
                                                                productsModel
                                                                        .images
                                                                        .isEmpty
                                                                    ? Constants
                                                                        .defaultImageUrl
                                                                    : productsModel
                                                                            .images[
                                                                                0]
                                                                            .src ??
                                                                        Constants
                                                                            .defaultImageUrl,
                                                                loadingBuilder:
                                                                    (context,
                                                                        child,
                                                                        loadingProgress) {
                                                                  if (loadingProgress ==
                                                                      null) {
                                                                    return child;
                                                                  }
                                                                  return Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: 95.0,
                                                                    height:
                                                                        92.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Color(
                                                                          int.parse(
                                                                              "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                                    ),
                                                                  );
                                                                },
                                                                fit:
                                                                    BoxFit.fill,
                                                                width: (constraints
                                                                        .maxWidth /
                                                                    20),
                                                                height: (constraints
                                                                        .maxWidth /
                                                                    20),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Container(
                                                    width:
                                                        // MediaQuery.of(context)
                                                        //             .size
                                                        //             .width /
                                                        //         2 +
                                                        //     38,
                                                        deviceWidth > 600
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                280
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                160,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ApiService
                                                                      .listOfProductsModel[
                                                                          index]
                                                                      .name ??
                                                                  "Jewellery",
                                                              // softWrap: true,
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: deviceWidth >
                                                                          600
                                                                      ? (constraints.maxWidth /
                                                                              20) +
                                                                          1
                                                                      : (constraints.maxWidth /
                                                                              20) +
                                                                          3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Text(
                                                              productsModel
                                                                          .regularPrice !=
                                                                      ""
                                                                  ? "₹ ${productsModel.regularPrice ?? 20000}"
                                                                  : "₹ 20000",
                                                              style: TextStyle(
                                                                  fontSize: deviceWidth >
                                                                          600
                                                                      ? (constraints.maxWidth /
                                                                              20) +
                                                                          1
                                                                      : (constraints.maxWidth /
                                                                              20) +
                                                                          3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      );
                                    } else if (!isThereMoreProducts ||
                                        isProductListEmpty) {
                                      print(
                                          "isProductListEmpty $isProductListEmpty");
                                      print(
                                          "isThereMoreProducts ${!isThereMoreProducts}");
                                      print(
                                          "ApiService.listOfProductsModel.length ${ApiService.listOfProductsModel.length}");
                                      return const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        child: Center(
                                            child: Text(
                                          "No more products are left",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 10.0),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: Color(int.parse(
                                              "0xff${layoutDesignProvider.primary.substring(1)}")),
                                        )),
                                      );
                                    }
                                  }),
                            ),
                          ),
              ],
            );
          }),
        ));
  }
}
