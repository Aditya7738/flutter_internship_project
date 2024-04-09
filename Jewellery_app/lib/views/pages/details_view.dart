import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';
import 'package:Tiara_by_TJ/views/pages/product_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/collection_grid_list.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  final int productIndex;
  final bool forCollections;
  final bool? fromHomeScreen;
  const DetailsView(
      {super.key,
      required this.productIndex,
      required this.forCollections,
      this.fromHomeScreen});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initStateFF
    super.initState();
    pageController = PageController(initialPage: widget.productIndex);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
     LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Details"), actions: <Widget>[
        Container(
          height: kToolbarHeight,
          width: (deviceWidth / 16) + 4,
          child: badges.Badge(
            badgeStyle:  badges.BadgeStyle(badgeColor:Color(int.parse("0xff${layoutDesignProvider.primary.substring(1)}"))),
            badgeContent:
                Consumer<WishlistProvider>(builder: (context, value, child) {
              print("LENGTH OF FAV: ${value.favProductIds}");
              return Text(
                value.favProductIds.length.toString(),
                style: TextStyle(
                    color: Colors.white, fontSize: (deviceWidth / 31) - 1),
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
          width: 24,
        ),
        Container(
          width: (deviceWidth / 16) + 4,
          child: badges.Badge(
            badgeStyle:  badges.BadgeStyle(badgeColor:Color(int.parse("0xff${layoutDesignProvider.primary.substring(1)}"))),
            badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) => Text(
                      value.cart.length.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (deviceWidth / 31) - 1),
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
          width: 24,
        ),
      ]),
      body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: showListOfPageView()),
    );
  }

  List<Widget> showListOfPageView() {
    FilterOptionsProvider filterOptionsProvider =
        Provider.of(context, listen: false);
    List<Widget> listOfPageView = <Widget>[];

    print("widget.forCollections detailview ${widget.forCollections}");

    if (widget.forCollections) {
      for (int i = 0; i < ProductPage.listOfCollections.length; i++) {
        listOfPageView.add(ProductDetailsPage(
            productsModel: ProductPage.listOfCollections[i]));
      }
    } else if (widget.fromHomeScreen != null) {
      if (widget.fromHomeScreen!) {
        for (int i = 0; i < CollectionGridList.listOfCollections.length; i++) {
          listOfPageView.add(ProductDetailsPage(
              productsModel: CollectionGridList.listOfCollections[i]));
        }
      }
    } else if (filterOptionsProvider.haveSubmitClicked) {
      for (int i = 0; i < ApiService.listOfProductsCategoryWise.length; i++) {
        listOfPageView.add(ProductDetailsPage(
            productsModel: ApiService.listOfProductsCategoryWise[i]));
      }
    } else {
      for (int i = 0; i < CacheMemory.listOfProducts.length; i++) {
        listOfPageView.add(
            ProductDetailsPage(productsModel: CacheMemory.listOfProducts[i]));
      }
    }

    print("listOfPageView.length ${listOfPageView.length}");

    return listOfPageView;
  }
}
