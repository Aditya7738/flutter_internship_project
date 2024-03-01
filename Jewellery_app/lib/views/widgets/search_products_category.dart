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
  const SearchProductsOfCategory({super.key, required this.categoryId});

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

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 10.0),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            height: 46.0,
            width: MediaQuery.of(context).size.width - 105,
            child: TextField(
              controller: searchTextController,
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

                    categoryProvider
                        .setIsProductListEmpty(listOfProducts.length == 0);

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
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  fillColor: Colors.grey,
                  hintText: "Search for jewelleries",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0)),
            ),
          ),
          GestureDetector(
            onTap: () async {
              searchTextController.text = "";
              bool isThereInternet =
                  await ApiService.checkInternetConnection(context);
              if (isThereInternet) {
                categoryProvider.setIsCategoryProductFetching(true);

                ApiService.listOfProductsCategoryWise.clear();
                await ApiService.fetchProductsCategoryWise(
                    id: widget.categoryId, pageNo: 1);

                categoryProvider.setIsCategoryProductFetching(false);
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
                size: 19.0,
              ),
            ),
          ),
          SizedBox(
            width: 11.0,
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
