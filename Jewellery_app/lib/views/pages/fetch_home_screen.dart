import 'dart:core';
import 'package:Tiara_by_TJ/model/layout_model.dart' as LayoutModel;
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/carousel_slider_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/category_list.dart';
import 'package:Tiara_by_TJ/views/widgets/collection_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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

    getLayoutDesign(layoutDesignProvider);
  }

  getLayoutDesign(LayoutDesignProvider layoutDesignProvider) async {
    setState(() {
      isLayoutLoading = true;
    });

    LayoutModel.LayoutModel? layoutModel = await ApiService.getHomeLayout();

    if (layoutModel != null) {
      if (layoutModel.data != null) {
        LayoutModel.Theme? theme = layoutModel.data!.theme;
        final pages = layoutModel.data!.pages;

        print("pages.runtimeType ${pages.runtimeType}");

        if (theme != null) {
          if (theme.colors != null) {
            layoutDesignProvider.setPrimary(theme.colors!.primary ?? "#CC868A");
            layoutDesignProvider
                .setSecondary(theme.colors!.secondary ?? "#FFFFFF");
            layoutDesignProvider
                .setBackground(theme.colors!.background ?? "#FFFFFF");
          } else if (theme.fontFamily != null) {
            layoutDesignProvider.setfontFamily(theme.fontFamily!);
          }
        }

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
                            Text(
                              children[i].text!,
                              style: children[i].style != null
                                  ? TextStyle(
                                      color: children[i].style!.color != null
                                          ? Color(int.parse(
                                              "0xff${children[i].style!.color!.substring(1)}"))
                                          : Color(0xff000000),
                                      fontSize:
                                          children[i].style!.fontSize != null
                                              ? children[i]
                                                  .style!
                                                  .fontSize!
                                                  .toDouble()
                                              : 20,
                                      fontFamily:
                                          layoutDesignProvider.fontFamily)
                                  : TextStyle(),
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
                                  fontSize: 18.0,
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
                      widgets.add(Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Collections",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: layoutDesignProvider.fontFamily),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CollectionSliderWidget(),
                          ],
                        ),
                      ));
                    }
                  }

                  widgets.forEach((element) {
                    print("home layoouts ${element}");
                  });

                  layoutDesignProvider.setParentWidget(Column(
                    children: widgets,
                  ));
                }
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: SingleChildScrollView(
          child: isLayoutLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : layoutDesignProvider.parentWidget,
        ));
  }
}
