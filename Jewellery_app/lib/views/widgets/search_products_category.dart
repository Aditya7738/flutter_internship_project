import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProductsOfCategory extends StatefulWidget
    implements PreferredSizeWidget {
  final int categoryId;
 
  const SearchProductsOfCategory(
      {super.key, required this.categoryId});

  @override
  State<SearchProductsOfCategory> createState() =>
      _SearchProductsOfCategoryState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchProductsOfCategoryState extends State<SearchProductsOfCategory> {
  // bool isSearchBarUsed = false;

  // bool isSearchFieldEmpty = false;
  // String searchText = "";

  //bool isProductListEmpty = false;
//  bool newListLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);
    filterOptionsProvider.setHaveSubmitClicked(false);
  }

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    final filterOptionsProvider = Provider.of<FilterOptionsProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;

    print("kToolbarHeight ${(kToolbarHeight / 2.6)}");
    return Container(
            padding:
                const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 10.0),
            color: Colors.white,
            width: deviceWidth,
            child: Row(
              children: [
                SizedBox(
                  height: (kToolbarHeight),
                  width: deviceWidth - 140,
                  child: TextField(
                    controller: searchTextController,
                    style: TextStyle(
                        fontSize: deviceWidth > 600
                            ? (kToolbarHeight - 37) + 8
                            : (kToolbarHeight - 40),
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    onSubmitted: (value) async {
                      print("cat search sub");
                      // if (value == "") {

                      //   // if (mounted) {
                      //   // setState(() {
                      //   //   isSearchFieldEmpty = true;
                      //   // });
                      // }

                      // if (mounted) {
                      //   setState(() {
                      //     isSearchFieldEmpty = false;
                      //   });
                      // }
                      filterOptionsProvider.setHaveSubmitClicked(true);

                      if (value.length >= 3) {
                        bool isThereInternet =
                            await ApiService.checkInternetConnection(context);
                        if (isThereInternet) {
                          ApiService.listOfProductsCategoryWise.clear();

                          categoryProvider.setIsCategoryProductFetching(true);

                          List<ProductsModel> listOfProducts =
                              await ApiService.fetchSearchedProductCategoryWise(
                                  id: widget.categoryId,
                                  pageNo: 1,
                                  searchText: value);

                          categoryProvider.setIsCategoryProductFetching(false);

                          categoryProvider.setIsProductListEmpty(listOfProducts.length == 0);

                          categoryProvider.setSearchText(value);

                          // if (mounted) {
                          //   setState(() {
                          //     // newListLoading = false;
                          //     // isProductListEmpty = listOfProducts.length == 0;

                          //   });
                          // }
                          //ApiService.searchProduct(value);
                          // print("ONCHANGED CALLED");
                          // if (mounted) {
                          //   setState(() {
                          //     // isSearchBarUsed = true;
                          //     searchText = value;
                          //   });
                          // }
                        }
                      }
                    },
                    showCursor: true,
                    maxLines: 1,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: deviceWidth > 600 ? 33.0 : 25.0,
                        ),
                        fillColor: Colors.grey,
                        hintText: "Search for jewelleries",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceWidth > 600
                              ? (kToolbarHeight - 37) + 8
                              : (kToolbarHeight - 40),
                        )),
                  ),
                ),
                SizedBox(width: 30.0),
                GestureDetector(
                  onTap: () async {
                    searchTextController.text = "";
                    print(
                        "haveSubmitClicked ${filterOptionsProvider.haveSubmitClicked}");
                    if (filterOptionsProvider.haveSubmitClicked) {
                      bool isThereInternet =
                          await ApiService.checkInternetConnection(context);
                      if (isThereInternet) {
                        categoryProvider.setIsCategoryProductFetching(true);

                        ApiService.listOfProductsCategoryWise.clear();
                        await ApiService.fetchProductsCategoryWise(
                            id: widget.categoryId, pageNo: 1);

                        categoryProvider.setIsCategoryProductFetching(false);
                      }
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: (kToolbarHeight - 34),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11.0,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints.expand(
                          width: deviceWidth,
                          height: (MediaQuery.of(context).size.height / 1.78) +
                              40.0),
                      isDismissible:
                          filterOptionsProvider.list.isEmpty ? true : false,
                      enableDrag: true,
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      builder: (context) {
                        return FilterModal(
                          searchText: categoryProvider.searchText,
                          fromProductsPage: true,
                          categoryId: widget.categoryId,
                        );
                      },
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                        size: (kToolbarHeight - 27),
                      )),
                ),
              ],
            ),
          )
      ;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight);
}
