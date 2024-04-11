import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/cancelled_order_tab.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/my_order_tab.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);
    List<Widget> tabs = [
      Tab(
        child: Text(
          "Pending orders",
          style: TextStyle(fontSize: deviceWidth > 600 ? 26.0 : 16.0),
        ),
      ),
      Tab(
        child: Text("Cancelled Orders",
            style: TextStyle(fontSize: deviceWidth > 600 ? 26.0 : 16.0)),
      )
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("My Orders"),
            bottom: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Color(int.parse(
                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                indicatorColor: Color(int.parse(
                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                tabs: tabs),
          ),
          body: TabBarView(children: [
            //EmptyListWidget(imagePath: "assets/images/delivery_service.png", message: "Oops! You haven't placed an order yet!"),
            MyOrderTab(),
            CancelledOrderTab()
            // EmptyListWidget(
            //   imagePath: "assets/images/cancel.png",
            //   message: "You don't have any cancelled order.",
            //   forCancelledOrder: true,
            // ),
          ])),
    );
  }
}
