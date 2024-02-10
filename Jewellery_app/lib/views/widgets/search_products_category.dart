import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/views/pages/filter.dart';
import 'package:flutter/material.dart';

class SearchProductsOfCategory extends StatefulWidget
    implements PreferredSizeWidget {
  const SearchProductsOfCategory({super.key});

  @override
  State<SearchProductsOfCategory> createState() =>
      _SearchProductsOfCategoryState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchProductsOfCategoryState extends State<SearchProductsOfCategory> {
  bool isSearchBarUsed = false;

  bool isSearchFieldEmpty = false;
  String searchText = "";

  bool isProductListEmpty = false;
  bool newListLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(bottom: 15.0, left: 15.0,right: 10.0),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            height: 46.0,
            width:  MediaQuery.of(context).size.width - 80,
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
          
                  List<ProductsModel> listOfProducts =
                      await ApiService.fetchProducts(value, 1, context);
          
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
