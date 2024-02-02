import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/model/payment_gatways_model.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:jwelery_app/views/pages/payment_failed.dart';
import 'package:jwelery_app/views/pages/payment_successful.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPaymentGateways();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    order_id = widget.orderId;
  }

  getPaymentGateways() async {
    setState(() {
      isLoading = true;
    });
    ApiService.paymentGateways.clear();
    await ApiService.getPaymentGateways();
    setState(() {
      isLoading = false;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //  Toast.show("Payment successful ${response.paymentId}", duration: 2);
    print("Payment successful ${response.paymentId}");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentSucessfulPage(),
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Toast.show("Payment failed ${response.message}", duration: 2);
    print("Payment failed ${response.message}");

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentFailedPage(),
    ));
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

  makeRazorPayment() {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final customerData = customerProvider.customerData[0];

    String productName = "";

    for (int i = 0; i < cartProvider.cart.length; i++) {
      productName += cartProvider.cart[i].productName! + ", ";
    }

    var options = {
      'key': ApiService.woocommerce_razorpay_settings[0]["data"]
          ["woocommerce_razorpay_settings"]["key_id"],
      //'amount': (cartProvider.calculateTotalPrice() * 100).toString(), //in the smallest currency sub-unit.
      'amount': '100',
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
      final response = _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final customerData = customerProvider.customerData[0];

    String productName = "";
    for (int i = 0; i < cartProvider.cart.length; i++) {
      productName += cartProvider.cart[i].productName! + ", ";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Payment methods"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Select your preferred payment method",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                itemCount: ApiService.paymentGateways.length,
                                itemBuilder: (context, index) {
                                  PaymentGatewaysModel paymentGatewaysModel =
                                      ApiService.paymentGateways[index];
                                  return GestureDetector(
                                    onTap: () {
                                      print("pay method pressed");

                                      switch (paymentGatewaysModel.id) {
                                        case "cod":
                                          break;
                                        case "cashfree":
                                          break;
                                        case "razorpay":
                                          makeRazorPayment();
                                          break;
                                        case "stripe":
                                          break;

                                        default:
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 15.0),
                                          child: Text(
                                            paymentGatewaysModel.title ??
                                                "Payment method",
                                            style:
                                                const TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),

                        // GestureDetector(
                        //   // onTap: () async {
                        //   //   var options = {
                        //   //     'key': 'rzp_test_BGgFmymAr2S4hP',
                        //   //     //'amount': (cartProvider.calculateTotalPrice() * 100).toString(), //in the smallest currency sub-unit.
                        //   //     'amount': '1',
                        //   //     'name': 'Tiara by TJ',
                        //   //     'order_id':
                        //   //         order_id, // Generate order_id using Orders API
                        //   //     'description': productName,
                        //   //     'timeout': 60, // in seconds
                        //   //     'prefill': {
                        //   //       'contact': customerData["billing"]["phone"],
                        //   //       'email': customerData["email"]
                        //   //     }
                        //   //   };

                        //   //   print("Payment $options");

                        //   //   try {
                        //   //     final response = _razorpay.open(options);
                        //   //   } catch (e) {
                        //   //     debugPrint(e.toString());
                        //   //   }
                        //   // },
                        //   child: Container(
                        //       height: 40.0,
                        //       width: MediaQuery.of(context).size.width,
                        //       decoration: BoxDecoration(
                        //           color: const Color(0xffCC868A),
                        //           borderRadius: BorderRadius.circular(15.0)),
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 10.0, horizontal: 30.0),
                        //       child: Center(
                        //         child: const Text(
                        //           "Pay now",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 17.0,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //       )),
                        // ),
                      ]),
                ),
              ));
  }
}
