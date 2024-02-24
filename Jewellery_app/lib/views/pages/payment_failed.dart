
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digigold_plan_bill.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/payment_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/pages/shipping_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
class PaymentFailedPage extends StatelessWidget {

    final bool fromCart;
  PaymentFailedPage({super.key, required this.fromCart});

  @override
  Widget build(BuildContext context) {
     final digiGoldProvider =
        Provider.of<DigiGoldProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animation/payment_failed.json",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              repeat: false,
              backgroundLoading: true),
         
          const SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              // fromCart ?
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => ShippingPage()))
              //     :
                  Navigator.pop(context);
                  // Navigator.of(context).pushReplacement(
                  // MaterialPageRoute(builder: (context) => DigiGoldPlanOrderPage(digiGoldPlanModel: digiGoldProvider.digiGoldPlanModel!,)));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: const Text(
                  "RETRY",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
