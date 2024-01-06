import 'package:flutter/material.dart';

import '../../model/navigation_model.dart';

class NavDrawer extends StatelessWidget {
  final Color? backgroundColor;
  final Color? fontColor;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final List<NavigationModel> listOfNavigationModel;

  const NavDrawer(
      {super.key,
      this.backgroundColor,
      this.fontColor,
      this.fontSize,
      this.fontFamily,
      required this.listOfNavigationModel,
      this.fontWeight});

  List<Widget> renderListTiles() {
    List<Widget> listOfWidget = <Widget>[];
    for (int i = 0; i < listOfNavigationModel.length; i++) {
      listOfWidget.add(ListTile(
        leading: listOfNavigationModel[i].menuIcon,
        title: Text(
          listOfNavigationModel[i].destination,
          style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: fontWeight),
        ),
      ));
    }

    return listOfWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        children: [
          DrawerHeader(
              child: Image.asset("assets/images/malabar_gold_logo.png")),
          ...renderListTiles()
        ],
      ),
    );
  }
}
