import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/views/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductListInTab extends StatefulWidget {
  const ProductListInTab({super.key});

  @override
  State<ProductListInTab> createState() => _ProductListInTabState();
}

class _ProductListInTabState extends State<ProductListInTab> {
  bool newListLoading = true;
  bool isLoading = true;

  bool isThereMoreProducts = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    ApiService.listOfProductsCategoryWise.clear();
    //await ApiService.fetchProductsCategoryWise(id: widget.id, pageNo: 1);

    if (mounted) {
      setState(() {
        newListLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return newListLoading
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
                    if (index < ApiService.listOfProductsCategoryWise.length) {
                      return ProductItem(
                        productsModel:
                            ApiService.listOfProductsCategoryWise[index],
                        forCollections: false,
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
          );
  }
}
