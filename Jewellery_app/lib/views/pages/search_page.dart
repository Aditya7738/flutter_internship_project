import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/model/products_model.dart';
import 'package:jwelery_app/views/pages/product_details_page%20copy.dart';
import 'package:jwelery_app/views/pages/product_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isSearchBarUsed = false;
  bool isThereMoreProducts = true;
  bool newListLoading = false;
  bool isSearchFieldEmpty = false;

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
    isThereMoreProducts = await ApiService.showNextPagesProduct();

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
    // _scrollController.addListener(() async {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     print("REACHED END OF LIST");

    //     setState(() {
    //       isLoading = true;
    //     });

    //     isThereMoreProducts = await ApiService.showNextPagesProduct();

    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // });

    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: SizedBox(
            height: 40.0,
            child: TextField(
              onChanged: (value) async {
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

                  await ApiService.fetchProducts(value, 1);

                  setState(() {
                    newListLoading = false;
                  });
                  //ApiService.searchProduct(value);
                  print("ONCHANGED CALLED");
                  setState(() {
                    isSearchBarUsed = true;
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
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0)),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(
                  "assets/images/ios_mic_outline.png",
                  color: Colors.grey,
                  width: 30.0,
                  height: 30.0,
                ))
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
              newListLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Color(0xffCC868A),
                    ))
                  : isSearchFieldEmpty
                      ? SizedBox()
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
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchProductDetailsPage(productsModel: productsModel)));
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
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
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
                                                            alignment:
                                                                Alignment.center,
                                                            width: 95.0,
                                                            height: 92.0,
                                                            child:
                                                                const CircularProgressIndicator(
                                                              color: Colors.black,
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
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width/2 + 30,
                                                        child: Text(
                                                          ApiService
                                                                  .listOfProductsModel[
                                                                      index]
                                                                  .name ??
                                                              "Jewellery",
                                                          softWrap: true,
                                                          overflow:
                                                              TextOverflow.ellipsis,
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
                                                          Text(ApiService
                                                                  .listOfProductsModel[
                                                                      index]
                                                                  .regularPrice ??
                                                              "20,000"),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    );
                                  } else if (!isThereMoreProducts) {
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
