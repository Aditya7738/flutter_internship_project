import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';

import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  final int productIndex;
  final bool fromFetchHome;
  const DetailsView(
      {super.key, required this.productIndex, required this.fromFetchHome});

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
    List<Widget> listOfPageView = <Widget>[];

    print("widget.fromFetchHome detailview ${widget.fromFetchHome}");

    if (widget.fromFetchHome) {
      for (int i = 0; i < ApiService.collectionList.length; i++) {


        listOfPageView.add(
            ProductDetailsPage(productsModel: ApiService.collectionList[i]));
      }
    } else {
      for (int i = 0; i < ApiService.listOfProductsCategoryWise.length; i++) {
        listOfPageView.add(ProductDetailsPage(
            productsModel: ApiService.listOfProductsCategoryWise[i]));
      }
    }

    print("listOfPageView.length ${listOfPageView.length}");

    return listOfPageView;
  }
}
