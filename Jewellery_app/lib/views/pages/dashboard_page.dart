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

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    
    getDataFromProvider();
  }

  void getDataFromProvider() async {
    print("Callig shared prefs");

    Provider.of<CartProvider>(context, listen: false).getSharedPrefs();
    Provider.of<WishlistProvider>(context, listen: false)
        .getWishListSharedPrefs();
    print("call wishlist shared prefs");
    Provider.of<ProfileProvider>(context, listen: false).getProfileSharedPrefs();
    Provider.of<CustomerProvider>(context, listen: false).getCustomerSharedPrefs();

  }
 
  @override
  Widget build(BuildContext context) {
    
    
    final tabs = <Widget>[
      const HomeScreen(),
      YouPage()
    ];
    return Scaffold(
      
      
      
      body:   tabs[_currentIndex],   
       bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          print("TAB O: $index");
          setState(() {
            _currentIndex = index;
          });
          
        },
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Color(0xffCC868A),),
            label: "Home",
            activeIcon: Icon(Icons.home_filled, color: Color(0xffCC868A)),
            ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined, color: Color(0xffCC868A)),
            label: "My Account",
            activeIcon: Icon(Icons.person_2_sharp, color: Color(0xffCC868A)),
            ),
      ]),
    );
  }
}
