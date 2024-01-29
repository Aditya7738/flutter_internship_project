import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;

  const PaymentPage({super.key, required this.orderId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay _razorpay = Razorpay();
  late String order_id;
  late String payableAmount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    order_id = widget.orderId;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //  Toast.show("Payment successful ${response.paymentId}", duration: 2);
    print("Payment successful ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Toast.show("Payment failed ${response.message}", duration: 2);
    print("Payment failed ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Toast.show("External wallet ${response.walletName}", duration: 2);
    print("External wallet ${response.walletName}");
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final customerData = customerProvider.customerData[0];

    bool isPaymentLoading = false;

    String productName = "";
    for (int i = 0; i < cartProvider.cart.length; i++) {
      productName += cartProvider.cart[i].productName! + ", ";
    }

    return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () async {
              setState(() {});
          
              var options = {
                'key': 'rzp_test_BGgFmymAr2S4hP',
                //'amount': (cartProvider.calculateTotalPrice() * 100).toString(), //in the smallest currency sub-unit.
                'amount': '1',
                'name': 'Tiara by TJ',
                'order_id': order_id, // Generate order_id using Orders API
                'description': productName,
                'timeout': 60, // in seconds
                'prefill': {
                  'contact': customerData["billing"]["phone"],
                  'email': customerData["email"]
                }
              };
          
              print("Payment $options");
          
              try {
                setState(() {
                  isPaymentLoading = true;
                });
                final response = _razorpay.open(options);
          
                setState(() {
                  isPaymentLoading = false;
                });
              } catch (e) {
                debugPrint(e.toString());
              }
          
              // if (response != null) {
              //   setState(() {});
              //   String body = await response.stream.bytesToString();
          
              //   print("BODY LOGIN $body");
          
              //   List<Map<String, dynamic>> data = <Map<String, dynamic>>[];
              //   try {
              //     data = List<Map<String, dynamic>>.from(jsonDecode(body));
              //     print("LOGIN JSON DECODE DATA $data");
              //   } catch (e) {
              //     print('Error decoding: $e');
              //   }
          
              //   setState(() {});
              // } else {
              //   setState(() {});
              // }
            },
            child: Container(
            
              height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xffCC868A),
                    borderRadius: BorderRadius.circular(15.0)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Center(
                  child: isPaymentLoading
                      ? const SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                            backgroundColor: Color(0xffCC868A),
                          ),
                        )
                      : const Text(
                          "Pay now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                )),
          ),
        ));
  }
}
