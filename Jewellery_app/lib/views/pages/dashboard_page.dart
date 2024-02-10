import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/filter_options_model.dart';
import 'package:Tiara_by_TJ/model/product_customization_option_model.dart';
import 'package:Tiara_by_TJ/providers/customize_options_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digi_gold_page.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/profile_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen.dart';
import 'package:Tiara_by_TJ/views/pages/you_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 1;

  @override
  void initState() {
    // TODO: implement initState

    getDataFromProvider();
    getProductCustomizeOptions();
    getFilterOptions();
  }

  Future<void> getFilterOptions() async {
    FilterOptionsModel? filterOptionsModel =
        await ApiService.getFilterOptions();
    final filterOptionsProvider =
        Provider.of<FilterOptionsProvider>(context, listen: false);

    //print("filterOptionsModel IS NOT NULL");
    List<Map<String, dynamic>> categoriesList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel!.categories.length; i++) {
      Map<String, dynamic> categoriesMap = <String, dynamic>{
        "id": filterOptionsModel.categories[i].id,
        "label": filterOptionsModel.categories[i].label,
        "value": filterOptionsModel.categories[i].value,
        "count": filterOptionsModel.categories[i].count
      };
      categoriesList.add(categoriesMap);
    }

    print("categoriesList $categoriesList");

    filterOptionsProvider.setCategoryFilterOptionsdata(categoriesList);

    List<Map<String, dynamic>> collectionsList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel.collections.length; i++) {
      Map<String, dynamic> collectionsMap = <String, dynamic>{
        "id": filterOptionsModel.collections[i].id,
        "label": filterOptionsModel.collections[i].label,
        "value": filterOptionsModel.collections[i].value,
        "count": filterOptionsModel.collections[i].count
      };
      collectionsList.add(collectionsMap);
    }

    print("collectionsList $collectionsList");

    filterOptionsProvider.setCollectionsFilterOptionsdata(collectionsList);

    

    List<Map<String, dynamic>> diamondWeightList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel.diamondWt.length; i++) {
      Map<String, dynamic> diamondWtMap = <String, dynamic>{
        "id": filterOptionsModel.diamondWt[i].id,
        "label": filterOptionsModel.diamondWt[i].label,
        "value": filterOptionsModel.diamondWt[i].value,
        "count": filterOptionsModel.diamondWt[i].count
      };
      diamondWeightList.add(diamondWtMap);
    }

    print("diamondWeightList $diamondWeightList");
    print("diamondWeightList length ${diamondWeightList.length}");

    filterOptionsProvider.setDiamondWtFilterOptionsdata(diamondWeightList);

    List<Map<String, dynamic>> goldWtList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel.goldWt.length; i++) {
      Map<String, dynamic> goldWt = <String, dynamic>{
        "id": filterOptionsModel.goldWt[i].id,
        "label": filterOptionsModel.goldWt[i].label,
        "value": filterOptionsModel.goldWt[i].value,
        "count": filterOptionsModel.goldWt[i].count
      };
      goldWtList.add(goldWt);
    }

    print("goldWtList $goldWtList");
      print("goldWtList length ${goldWtList.length}");

    filterOptionsProvider.setGoldWtFilterOptionsdata(goldWtList);

    List<Map<String, dynamic>> genderList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel.gender.length; i++) {
      Map<String, dynamic> gender = <String, dynamic>{
        "id": filterOptionsModel.gender[i].id,
        "label": filterOptionsModel.gender[i].label,
        "value": filterOptionsModel.gender[i].value,
        "count": filterOptionsModel.gender[i].count
      };
      genderList.add(gender);
    }
    print("genderList $genderList");
        print("genderList length ${genderList.length}");

    filterOptionsProvider.setGenderFilterOptionsdata(genderList);

    List<Map<String, dynamic>> tagsList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel.tags.length; i++) {
      Map<String, dynamic> tags = <String, dynamic>{
        "id": filterOptionsModel.tags[i].id,
        "label": filterOptionsModel.tags[i].label,
        "value": filterOptionsModel.tags[i].value,
        "count": filterOptionsModel.tags[i].count
      };
      tagsList.add(tags);
    }

    print("tagsList $tagsList");
    print("tagsList length ${tagsList.length}");

    filterOptionsProvider.setTagsFilterOptionsdata(tagsList);

    List<Map<String, dynamic>> subCategoriesList = <Map<String, dynamic>>[];
    for (var i = 0; i < filterOptionsModel.subCategories.length; i++) {
      Map<String, dynamic> subCategories = <String, dynamic>{
        "id": filterOptionsModel.subCategories[i].id,
        "label": filterOptionsModel.subCategories[i].label,
        "value": filterOptionsModel.subCategories[i].value,
        "count": filterOptionsModel.subCategories[i].count
      };
      subCategoriesList.add(subCategories);
    }

    print("subCategoriesList $subCategoriesList");
    print("subCategoriesList length ${subCategoriesList.length}");

    filterOptionsProvider.setSubCategoriesFilterOptionsdata(subCategoriesList);

    print("filterOptionsModel IS NULL");
  }

  Future<void> getProductCustomizeOptions() async {
    ProductCustomizationOptionsModel? productCustomizationOptionsModel =
        await ApiService.getProductCustomizeOptions();
    final customizationOptionsProvider =
        Provider.of<CustomizeOptionsProvider>(context, listen: false);
    Map<String, dynamic> customizeOptionsdata = <String, dynamic>{};

    if (productCustomizationOptionsModel != null) {
      if (productCustomizationOptionsModel.data != null) {
        customizeOptionsdata = {
          "enable_everything":
              productCustomizationOptionsModel.data!.display ?? "0",
          "enable_kt": productCustomizationOptionsModel.data!.kt ?? "0",
          "enable_color": productCustomizationOptionsModel.data!.color ?? "0",
          "enable_diamond":
              productCustomizationOptionsModel.data!.diamond ?? "0",
          "collections": productCustomizationOptionsModel.data!.collections,
          "colors": productCustomizationOptionsModel.data!.colors,
          "diamond_purities":
              productCustomizationOptionsModel.data!.diamondPurities,
          "purities": productCustomizationOptionsModel.data!.purities
        };
      }
    }

    customizationOptionsProvider.setCustomizeOptionsdata(customizeOptionsdata);
  }

  void getDataFromProvider() async {
    print("Callig shared prefs");

    Provider.of<CartProvider>(context, listen: false).getSharedPrefs();
    Provider.of<WishlistProvider>(context, listen: false)
        .getWishListSharedPrefs();
    print("call wishlist shared prefs");
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfileSharedPrefs();
    Provider.of<CustomerProvider>(context, listen: false)
        .getCustomerSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[DigiGoldPage(), const HomeScreen(), YouPage()];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            print("TAB O: $index");
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              icon:
                  Image.asset("assets/images/icons_gold_bars_outline.png", width: 45.0, height: 25.0, color: Theme.of(context).primaryColor,),
              label: "Digi Gold",
              activeIcon: Image.asset("assets/images/icons_gold_bars_filled.png", width: 45.0, height: 25.0,color: Theme.of(context).primaryColor,)
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Color(0xffCC868A),
              ),
              label: "Home",
              activeIcon: Icon(Icons.home_filled,  color: Theme.of(context).primaryColor),
            ),
           
             BottomNavigationBarItem(
              icon:
                  Icon(Icons.person_outline_outlined,  color: Theme.of(context).primaryColor),
              label: "My Account",
              activeIcon: Icon(Icons.person_sharp,  color: Theme.of(context).primaryColor),
            ),
          ]),
    );
  }
}
