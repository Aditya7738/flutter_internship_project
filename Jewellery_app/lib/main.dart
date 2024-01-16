import 'package:flutter/material.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/wishlist_provider.dart';
import 'package:jwelery_app/views/pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: MaterialApp(
        title: Strings.app_name,
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
