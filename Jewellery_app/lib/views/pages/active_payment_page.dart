import 'package:flutter/material.dart';
import 'package:jwelery_app/views/widgets/empty_list_widget.dart';

class ActivePayments extends StatelessWidget {
  const ActivePayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Payments"),
      ),
      body: EmptyListWidget(
        imagePath: "assets/images/no_payment.png",
        message: "No Active Payments",
      ),
    );
  }
}
