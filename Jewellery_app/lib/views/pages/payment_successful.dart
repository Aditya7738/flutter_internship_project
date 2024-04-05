import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class PaymentSucessfulPage extends StatelessWidget {
  PaymentSucessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/animation/payment_successful.json",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 50,
              repeat: false,
              backgroundLoading: true),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            "Thank you for shopping with us. Your account has been charged and your transaction is suceessful. We will be processing your order soon.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: deviceWidth > 600 ? 30.0 : 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
          const SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashboardPage()));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 40.0),
                child: Text("CONTINUE SHOPPING",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceWidth > 600 ? 26.sp : 16.sp,
                      color: Colors.white
                    ))),
          )
        ],
      ),
    );
  }
}
