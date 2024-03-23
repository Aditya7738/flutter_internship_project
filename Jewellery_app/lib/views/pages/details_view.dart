import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/api/cache_memory.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';
import 'package:Tiara_by_TJ/views/pages/product_page.dart';
import 'package:Tiara_by_TJ/views/widgets/collection_grid_list.dart';

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
    return Scaffold(
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
