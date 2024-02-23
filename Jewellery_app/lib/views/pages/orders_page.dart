import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/my_order_tab.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      const Tab(child: Text("Pending orders", style: TextStyle(fontSize: 16.0),),),
      const Tab(child: Text("Cancelled Orders", style: TextStyle(fontSize: 16.0)),)
    ];


    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Orders"
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Theme.of(context).primaryColor,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: tabs
          ),
        
        ),
        body: TabBarView(
          children: [


          //EmptyListWidget(imagePath: "assets/images/delivery_service.png", message: "Oops! You haven't placed an order yet!"),
          MyOrderTab(),

          EmptyListWidget(imagePath: "assets/images/cancel.png", message: "You don't have any completely cancelled order.", forCancelledOrder: true,),
          ]

          )
      ),
    );
  }
}