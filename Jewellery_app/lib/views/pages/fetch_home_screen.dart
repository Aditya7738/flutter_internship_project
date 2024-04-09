import 'dart:core';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/db_helper.dart';
import 'package:Tiara_by_TJ/model/layout_model.dart' as LayoutModel;
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/product_page.dart';
import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/widgets/carousel_slider_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/category_list.dart';
import 'package:Tiara_by_TJ/views/widgets/collection_grid_list.dart';
import 'package:Tiara_by_TJ/views/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:Tiara_by_TJ/api/api_service.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FetchHomeScreen extends StatefulWidget {
  const FetchHomeScreen({super.key});

  @override
  State<FetchHomeScreen> createState() => _FetchHomeScreenState();
}

class _FetchHomeScreenState extends State<FetchHomeScreen> {
  int currentIndex = 0;

  bool isLayoutLoading = false;

  @override
  void initState() {
    super.initState();

    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLayoutDesign(layoutDesignProvider);
    });
  }

  getLayoutDesign(LayoutDesignProvider layoutDesignProvider) async {
    double deviceWidth = MediaQuery.of(context).size.width;
    setState(() {
      isLayoutLoading = true;
    });
    DBHelper dbHelper = DBHelper();
    LayoutModel.LayoutModel layoutModel;
    if (layoutDesignProvider.layoutModel != null) {
      layoutModel = layoutDesignProvider.layoutModel!;
    } else {
      await dbHelper.readData();
      layoutModel = dbHelper.layoutModel;
      layoutDesignProvider.setLayoutModel(layoutModel);
    }

    print("layoutModel.toJson() ${layoutModel.toJson()}");
    // LayoutModel.LayoutModel? layoutModel = await ApiService.getHomeLayout();

    if (layoutModel.data != null) {
     // LayoutModel.Theme? theme = layoutModel.data!.theme;
      final pages = layoutModel.data!.pages;
      LayoutModel.Placeholders? placeholders = layoutModel.data!.placeholders;
      print("pages.runtimeType ${pages.runtimeType}");

      if (placeholders != null) {
        if (placeholders.productImage != null) {
          layoutDesignProvider.setPlaceHolder(placeholders.productImage!);
        }
      }

      // if (theme != null) {
      //   if (theme.colors != null) {
      //     layoutDesignProvider.setPrimary(theme.colors!.primary ?? "#CC868A");
      //     layoutDesignProvider
      //         .setSecondary(theme.colors!.secondary ?? "#FFFFFF");
      //     layoutDesignProvider
      //         .setBackground(theme.colors!.background ?? "#FFFFFF");
      //   } else if (theme.fontFamily != null) {
      //     layoutDesignProvider.setfontFamily(theme.fontFamily!);
      //   }
      // }

      if (pages.isNotEmpty) {
        for (var i = 0; i < 1; i++) {
          if (pages[i].name != null) {
            if (pages[i].name == "HomePage") {
              if (pages[i].layout == "column") {
                List<Widget> widgets = <Widget>[];

                List<LayoutModel.Child> children = pages[i].children;
                for (var i = 0; i < children.length; i++) {
                  if (children[i].type == "header") {
                    if (children[i].text != null) {
                      widgets.add(Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              children[i].text!,
                              // "HI",
                              style: children[i].style != null
                                  ? TextStyle(
                                      color: children[i].style!.color != null
                                          ? Color(int.parse(
                                              "0xff${children[i].style!.color!.substring(1)}"))
                                          : Color(0xff000000),
                                      fontSize:
                                          // children[i].style!.fontSize != null
                                          //     ? children[i]
                                          //         .style!
                                          //         .fontSize!
                                          //         .toDouble()
                                          //     :
                                          deviceWidth > 600 ? 40.0 : 20,
                                      fontFamily:
                                          layoutDesignProvider.fontFamily)
                                  : TextStyle(),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          )
                        ],
                      ));
                    } else {
                      widgets.add(SizedBox());
                    }
                  }

                  if (children[i].type == "image_slider") {
                    widgets.add(SizedBox(
                        height: (MediaQuery.of(context).size.height / 2) + 30,
                        child: CarouselSliderWidget()));
                  }

                  if (children[i].type == "categories") {
                    widgets.add(Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: deviceWidth > 600 ? 30.0 : 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: layoutDesignProvider.fontFamily),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CategoryList(),
                        ],
                      ),
                    ));
                  }

                  if (children[i].type == "collections") {
                    if (children[i].meta != null) {
                      if (children[i].meta!.id != null &&
                          children[i].meta!.label != null) {
                        String label = children[i].meta!.label!;

                        widgets.add(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                label,
                                style: TextStyle(
                                    fontSize: deviceWidth > 600 ? 30.0 : 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        layoutDesignProvider.fontFamily),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CollectionGridList(
                                collectionId: children[i].meta!.id!),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  id: children[i].meta!.id!,
                                                  forCollections: true,
                                                )));
                                  },
                                  child: Text(
                                    "Show more",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.underline,
                                        fontSize:
                                            deviceWidth > 600 ? 25.sp : 13.sp),
                                  ),
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ));
                      }
                    }
                  }
                }

                widgets.forEach((element) {
                  print("home layouts ${element}");
                });

                layoutDesignProvider.setParentWidget(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ));
              }
            }
          }
        }
      }
    }

    setState(() {
      isLayoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    print("deviceWidth / 20 ${deviceWidth / 31}");
    return Consumer<LayoutDesignProvider>(
      builder: (context, value, child) {
        Color primaryColor = Color(0xffCC868A);
        if (value.primary != "") {
          primaryColor = Color(int.parse("0xff${value.primary.substring(1)}"));
        }

        return Scaffold(
            appBar: AppBar(
              toolbarHeight: (kToolbarHeight + kToolbarHeight) - 26,
              automaticallyImplyLeading: false,
              title: Image.network(
                Constants.app_logo,
                width: 239,
                height: kToolbarHeight,
                fit: BoxFit.fitWidth,
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                Container(
                  width: (deviceWidth / 16) + 4,
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(badgeColor: primaryColor),
                    badgeContent: Consumer<WishlistProvider>(
                        builder: (context, value, child) {
                      print("LENGTH OF FAV: ${value.favProductIds}");
                      return Text(
                        value.favProductIds.length.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: (deviceWidth / 31) - 1),
                      );
                    }),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WishListPage()));
                      },
                      icon:
                          const Icon(Icons.favorite_sharp, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Container(
                  width: (deviceWidth / 16) + 4,
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(badgeColor: primaryColor),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartPage()));
                      },
                      icon: const Icon(Icons.shopping_cart),
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 34,
                ),
              ],
              bottom: CustomSearchBar(),
            ),
            body: SingleChildScrollView(
              child: isLayoutLoading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    )
                  : layoutDesignProvider.parentWidget,
            ));
      },
      //  child:
    );
  }
}
