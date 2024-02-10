import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/views/pages/filter.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService.listOfProductsModel.clear();
    _scrollController.addListener(() async {
      print(
          "CONDITION ${_scrollController.position.pixels == _scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("REACHED END OF LIST");

        loadMoreData();
      }
    });
  }

  void loadMoreData() async {
    setState(() {
      isLoading = true;
    });

    // Fetch more data (e.g., using ApiService)
    isThereMoreProducts = await ApiService.showNextPagesProduct(context);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterOptionsProvider = Provider.of<FilterOptionsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: SizedBox(
            height: 40.0,
            child: TextField(
              onSubmitted: (value) async {
                if (value == "") {
                  ApiService.listOfProductsModel.clear();
                  // setState(() {
                  //   isSearchFieldEmpty = true;
                  // });
                }

                setState(() {
                  isSearchFieldEmpty = false;
                });

                if (value.length >= 3 && !newListLoading) {
                  ApiService.listOfProductsModel.clear();
                  setState(() {
                    newListLoading = true;
                  });

                  List<ProductsModel> listOfProducts = await ApiService.fetchProducts(value, 1, context);

                  setState(() {
                    newListLoading = false;
                    isProductListEmpty = listOfProducts.length == 0;
                  });
                  //ApiService.searchProduct(value);
                  print("ONCHANGED CALLED");
                  setState(() {
                    isSearchBarUsed = true;
                    searchText = value;

                  });
                }
              },
              showCursor: true,
              maxLines: 1,
              autofocus: true,
              cursorColor: Colors.grey,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                  fillColor: Colors.grey,
                  hintText: "Search for jewelleries",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0)),
            ),
          ),
          actions: [
            // Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //     child: Image.asset(
            //       "assets/images/ios_mic_outline.png",
            //       color: Colors.grey,
            //       width: 30.0,
            //       height: 30.0,
            //     )),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  builder: (context) {
                    return Filter(searchText: searchText);
                  },
                );
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.grey,
                    size: 30.0,
                  )),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight +
              kToolbarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              newListLoading || filterOptionsProvider.isFilteredListLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Color(0xffCC868A),
                    ))
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
                                    ProductsModel productsModel =
                                        ApiService.listOfProductsModel[index];
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
                                              vertical: 5.0, horizontal: 10.0),
                                          child: Card(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                          BorderRadius.circular(
                                                              25.0),
                                                      child: Image.network(
                                                        productsModel
                                                                .images.isEmpty
                                                            ? Strings
                                                                .defaultImageUrl
                                                            : productsModel
                                                                    .images[0]
                                                                    .src ??
                                                                Strings
                                                                    .defaultImageUrl,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 95.0,
                                                            height: 92.0,
                                                            child:
                                                                const CircularProgressIndicator(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          );
                                                        },
                                                        fit: BoxFit.fill,
                                                        width: 95.0,
                                                        height: 92.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2 +
                                                            30,
                                                        child: Text(
                                                          ApiService
                                                                  .listOfProductsModel[
                                                                      index]
                                                                  .name ??
                                                              "Jewellery",
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/rupee.png",
                                                            width: 20.0,
                                                            height: 20.0,
                                                          ),
                                                          Text(productsModel
                                                                      .regularPrice !=
                                                                  ""
                                                              ? productsModel
                                                                      .regularPrice ??
                                                                  "20000"
                                                              : "20000")
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    );
                                  } else if (!isThereMoreProducts || isProductListEmpty) {
                                    
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
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: Color(0xffCC868A),
                                      )),
                                    );
                                  }
                                }),
                          ),
                        ),
            ],
          ),
        ));
  }
}
