import 'package:flutter/material.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/profile_provider.dart';
import 'package:jwelery_app/providers/wishlist_provider.dart';
import 'package:jwelery_app/views/pages/dashboard_page.dart';
import 'package:jwelery_app/views/pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'constants/strings.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown
]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: Strings.app_name,
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        home: const DashboardPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
