import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/slide_drawer.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBarWidget(
        menuIcon: Icons.clear,
        onPressed: () {
          Navigator.pop(context);
          print("HOME PAGE");
        }, isNeededForHome: true,
        isNeededForProductPage: false
      ),
      body: const SlideDrawer(),
    );
  }
}
