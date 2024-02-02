import 'package:flutter/material.dart';
import 'package:jwelery_app/views/pages/dashboard_page.dart';
import 'package:jwelery_app/views/pages/search_page.dart';
import 'package:jwelery_app/views/widgets/empty_list_widget.dart';
import 'package:lottie/lottie.dart';

class PaymentSucessfulPage extends StatelessWidget {
  const PaymentSucessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  Lottie.asset("assets/animation/payment_successful.json",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    repeat: false,
                    backgroundLoading: true

                   
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    
                   "Thank you for shopping with us. Your account has been charged and your transaction is suceessful. We will be processing your order soon."
                    ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),

            

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DashboardPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: const Text(
                          "CONTIUE SHOPPING",
                          style:
                              TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                        )),
                  )
                 
                ],
              ),
    );
  }
}