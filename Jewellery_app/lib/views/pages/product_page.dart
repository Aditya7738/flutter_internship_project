import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
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

  bool newListLoading = true;

  @override
  void initState() {
    super.initState();

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
    setState(() {
      isLoading = true;
    });

    // Fetch more data (e.g., using ApiService)
    isThereMoreProducts = await ApiService.showNextPagesCategoryProduct();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getProducts() async {
    ApiService.listOfProductsCategoryWise.clear();
    await ApiService.fetchProductsCategoryWise(id: widget.id, pageNo: 1);

    setState(() {
      newListLoading = false;
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
    return Scaffold(
      appBar: AppBar(title: Text("Products"), actions: <Widget>[
        SizedBox(
          height: 40.0,
          width: 32.0,
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            badgeContent:
                Consumer<WishlistProvider>(builder: (context, value, child) {
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
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) => Text(
                      value.cart.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
            child: IconButton(
              onPressed: () {
                print("CART CLICKED");
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartPage()));
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
      bottom: CustomSearchBar(),

      
      ),
      body: newListLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(0.0),
              child: Scrollbar(
                child: GridView.builder(
                    controller: _scrollController,
                    itemCount: ApiService.listOfProductsCategoryWise.length +
                        (isLoading || !isThereMoreProducts ? 1 : 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.64,
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index <
                          ApiService.listOfProductsCategoryWise.length) {
                        return ProductItem(
                          productsModel:
                              ApiService.listOfProductsCategoryWise[index],
                        );
                      } else if (!isThereMoreProducts) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Center(
                              child: Text(
                            "No more products are left",
                            style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
