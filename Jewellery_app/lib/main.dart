import 'package:flutter/material.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:jwelery_app/providers/profile_provider.dart';
import 'package:jwelery_app/providers/wishlist_provider.dart';
import 'package:jwelery_app/views/pages/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'constants/strings.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

//TODO: call api of cart and wishlist, customer, order to get updated data to show before dashboard

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
      ],
      child: MaterialApp(
        title: Strings.app_name,
        theme: ThemeData(
          
          primaryColor: Color(0xffCC868A),
          textTheme: TextTheme(
            headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
      
            ),
            headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
      
            ), //product details heading
            headline3: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
      
            ), //price text style
             headline4: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
      
            ),
            )
          ),
        
        home: const DashboardPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
