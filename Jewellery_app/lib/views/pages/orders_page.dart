import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/empty_list_widget.dart';
import 'package:jwelery_app/views/widgets/my_order_tab.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      const Tab(text: "My Orders",),
      const Tab(text: "Cancelled Orders",)
    ];


    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Orders"
          ),
          bottom: TabBar(
          
          tabs: tabs
          ),
        
        ),
        body: TabBarView(
          children: [


          //EmptyListWidget(imagePath: "assets/images/delivery_service.png", message: "Oops! You haven't placed an order yet!"),
          MyOrderTab(),

          EmptyListWidget(imagePath: "assets/images/cancel.png", message: "You don't have ay completely cancelled order.", forCancelledOrder: true,),
          ]

          )
      ),
    );
  }
}