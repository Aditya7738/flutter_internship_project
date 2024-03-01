import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_modal.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
import 'package:Tiara_by_TJ/views/widgets/search_products_category.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';

import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductPage extends StatefulWidget {
  final int id;
  const ProductPage({super.key, required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //List<ProductOfCategoryModel> listOfProductsCategoryWise = [];
  final ScrollController _scrollController = ScrollController();

  bool isLoading = true;

  bool isThereMoreProducts = false;

  bool newListLoading = false;

  late CategoryProvider categoryProvider;
  late FilterOptionsProvider filterOptionsProvider;

  @override
  void initState() {
    super.initState();

    categoryProvider = Provider.of(context, listen: false);
    filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    getProducts();
    

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
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // Fetch more data (e.g., using ApiService)
    isThereMoreProducts = await ApiService.showNextPagesCategoryProduct();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getProducts() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      // if (mounted) {
      // setState(() {
      //   newListLoading = true;
      // });
      // }
      categoryProvider.setIsCategoryProductFetching(true);
      ApiService.listOfProductsCategoryWise.clear();
      await ApiService.fetchProductsCategoryWise(id: widget.id, pageNo: 1);

      // if (mounted) {
      // setState(() {
      //   newListLoading = false;
      // });
      // }
      categoryProvider.setIsCategoryProductFetching(false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  //  final filterProvider = Provider.of<FilterOptionsProvider>(context);
    filterOptionsProvider.clearFilterList();
    _scrollController.dispose();
    super.dispose();
  }

  // bool isSearchBarUsed = false;

  // bool isSearchFieldEmpty = false;
  // String searchText = "";

  // bool isProductListEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Products"),
            actions: <Widget>[
              SizedBox(
                height: 40.0,
                width: 32.0,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
                  badgeContent: Consumer<WishlistProvider>(
                      builder: (context, value, child) {
                    print("LENGTH OF FAV: ${value.favProductIds}");
                    return Text(
                      value.favProductIds.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WishListPage()));
                    },
                    icon: const Icon(Icons.favorite_sharp, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                height: 40.0,
                width: 32.0,
                child: badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.purple),
                  badgeContent: Consumer<CartProvider>(
                      builder: (context, value, child) => Text(
                            value.cart.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                  child: IconButton(
                    onPressed: () {
                      print("CART CLICKED");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
            bottom: SearchProductsOfCategory(categoryId: widget.id)),
        body: SingleChildScrollView(
          child: Consumer<CategoryProvider>(
              builder: (context, categoryProviderValue, child) {
            // if (categoryProviderValue.isCategoryProductFetching
            //     //|| filterOptionsProvider.isFilteredListLoading
            //     ) {
            //   return SizedBox(
            //     height: MediaQuery.of(context).size.height - 150,
            //     child: const Center(
            //       child: CircularProgressIndicator(
            //         backgroundColor: Colors.black,
            //         color: Colors.white,
            //       ),
            //     ),
            //   );
            // } else {
            return Column(
              children: [
                Consumer<FilterOptionsProvider>(
                  builder: (context, value, child) {
                    return value.list.isEmpty
                        ? SizedBox()
                        : SizedBox(
                            height: 70.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
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
                                            ? "₹${value.list[index]["price_range"]["min_price"]} - ₹${value.list[index]["price_range"]["max_price"]}"
                                            : value.list[index]["label"],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      deleteIcon: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 19.0,
                                        ),
                                      ),
                                      onDeleted: () async {
                                        print("ONDELETED CALLED");

                                        print("index to remove $index");

                                        value.removeFromList(index);

                                        print("_list ${value.list}");

                                        bool isThereInternet = await ApiService
                                            .checkInternetConnection(context);
                                        if (isThereInternet) {
                                          categoryProviderValue
                                              .setIsCategoryProductFetching(
                                                  true);

                                          ApiService.listOfProductsModel
                                              .clear();
                                          await ApiService.fetchProducts(
                                              categoryProviderValue.searchText,
                                              1,
                                              filterList: value.list);
                                          categoryProviderValue
                                              .setIsCategoryProductFetching(
                                                  false);
                                        }
                                      }),
                                );
                              },
                            ),
                          );
                  },
                ),
                //  if (categoryProviderValue.isCategoryProductFetching
                //       //|| filterOptionsProvider.isFilteredListLoading
                //       ) {
                //     return SizedBox(
                //       height: MediaQuery.of(context).size.height - 150,
                //       child: const Center(
                //         child: CircularProgressIndicator(
                //           backgroundColor: Colors.black,
                //           color: Colors.white,
                //         ),
                //       ),
                //     );
                //   } else {
                categoryProviderValue.isCategoryProductFetching
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 150,
                        child: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 136,
                        child: Scrollbar(
                          child: GridView.builder(
                              controller: _scrollController,
                              itemCount:
                                  ApiService.listOfProductsCategoryWise.length +
                                      (isLoading || !isThereMoreProducts
                                          ? 1
                                          : 0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.64,
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 4
                                              : 2,
                                      crossAxisSpacing: 0.0,
                                      mainAxisSpacing: 0.0),
                              itemBuilder: (BuildContext context, int index) {
                                if (index <
                                    ApiService
                                        .listOfProductsCategoryWise.length) {
                                  return ProductItem(
                                    productIndex: index,
                                    productsModel: ApiService
                                        .listOfProductsCategoryWise[index],
                                  );
                                } else if (!isThereMoreProducts ||
                                    categoryProviderValue.isProductListEmpty) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    child: Center(
                                        child: Text(
                                      "There are no more products",
                                      style: TextStyle(
                                          fontSize: 18.0,
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
            );
          }),
        ));

    // newListLoading
    //     ?
    //     :     );
  }
}
