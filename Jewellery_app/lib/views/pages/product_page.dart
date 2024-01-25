import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';

import 'package:jwelery_app/views/widgets/product_item.dart';


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
      appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: SizedBox(
            height: 40.0,
            child: TextField(
              onChanged: (value) async {
               
              },
              showCursor: true,
              maxLines: 1,
              
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
      body: newListLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Scrollbar(
                child: GridView.builder(
                    controller: _scrollController,
                    itemCount: ApiService.listOfProductsCategoryWise.length +
                        (isLoading || !isThereMoreProducts ? 1 : 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.74,
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 10.0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index < ApiService.listOfProductsCategoryWise.length) {
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
