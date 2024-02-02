import 'dart:convert';

// @pragma('vm:web')
// import 'dart:html' as html show window;
// @pragma('vm:web')
// import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/helpers/hashservice.dart';
import 'package:jwelery_app/helpers/pay_u_params.dart';
import 'package:jwelery_app/model/payment_gatways_model.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:jwelery_app/views/pages/payment_failed.dart';
import 'package:jwelery_app/views/pages/payment_successful.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:provider/provider.dart';

//cashfree import
// import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardlistener.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardvalidator.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardwidget.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfnetwork/CFNetworkManager.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcard.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcardpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbanking.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbankingpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupi.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupipayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfupi/cfupiutils.dart';
// import 'package:flutter_cashfree_pg_sdk/flutter_cashfree_pg_sdk_web.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfexceptionconstants.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

//payu
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';

//cc_avenue

import 'dart:async';

import 'package:cc_avenue/cc_avenue.dart';

import 'package:flutter/services.dart';

//flutter_stripe
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

// import 'package:toast/toast.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;
  final Map<String, String> cashFreeData;

  const PaymentPage(
      {super.key, required this.orderId, required this.cashFreeData});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    implements PayUCheckoutProProtocol {
  Razorpay _razorpay = Razorpay();
  late String order_id;
  late Map<String, String> cashFreeData;
  late String payableAmount;
  bool isLoading = false;
  late PayUCheckoutProFlutter _checkoutPro;

  //var cfPaymentGatewayService = CFPaymentGatewayService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPaymentGateways();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    order_id = widget.orderId;
    cashFreeData = widget.cashFreeData;
    _checkoutPro = PayUCheckoutProFlutter(this as PayUCheckoutProProtocol);

    //cfPaymentGatewayService.setCallback(verifyPayment, onError);
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

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await CcAvenue.cCAvenueInit(
          transUrl:
              'https://test.ccavenue.com/transaction/initTrans', // production link - //https://secure.ccavenue.com/transaction/initTrans
          accessCode: 'Tiara@Jwero',
          amount: '10',
          cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
          currencyType: 'INR',
          merchantId: 'tiarabytj@gmail.com',
          orderId: '519',
            redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
        rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp'  //redirecting to this link
          );
    } on PlatformException {
      print('PlatformException');
    } catch (e) {
      print("CcAvenue error ${e.toString()}");
    }
  }
  // void verifyPayment(String orderId) {
  //   print("Verify Payment");
  // }

  // void onError(CFErrorResponse errorResponse, String orderId) {
  //   print(errorResponse.getMessage());
  //   print("Error while making payment");
  // }

  // webCheckout() async {
  //   try {
  //     var session = createSession();
  //     var cfWebCheckout = CFWebCheckoutPaymentBuilder().setSession(session!).build();
  //     cfPaymentGatewayService.doPayment(cfWebCheckout);
  //   } on CFException catch (e) {
  //     print("CFException ${e.message}");
  //   }
  // }

  //  CFSession? createSession() {
  //   try {
  //     CFEnvironment environment = CFEnvironment.SANDBOX;
  //     var session = CFSessionBuilder().setEnvironment(environment).setOrderId(cashFreeData["order_id"]!).setPaymentSessionId(cashFreeData["payment_session_id"]!).build();
  //     return session;
  //   } on CFException catch (e) {
  //     print(e.message);
  //   }
  //   return null;
  // }

  openPayUCheckoutScreen() async {
    _checkoutPro.openCheckoutScreen(
      payUPaymentParams: PayUParams.createPayUPaymentParams(),
      payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
    );
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
                                          // webCheckout();
                                          break;
                                        case "razorpay":
                                          makeRazorPayment();
                                          break;

                                        case "ccavenue":

                                        //Navigate to PaymentScreen - ccavenue _paymet_page.dart
                                          initPlatformState();
                                          break;
                                        case "stripe":
                                          openPayUCheckoutScreen();
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
                      ]),
                ),
              ));
  }

  showAlertDialog(BuildContext context, String title, String content) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Text(content),
            ),
            actions: [okButton],
          );
        });
  }

  @override
  generateHash(Map response) {
    // TODO: implement generateHash
    // Map hashResponse = HashService.generateHash(response);
    // _checkoutPro.hashGenerated(hash: hashResponse);
    // Pass response param to your backend server
    // Backend will generate the hash and will callback to
    Map hashResponse = HashService.generateHash(response);
    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onError(Map? response) {
    // TODO: implement onError
    showAlertDialog(context, "onError", response.toString());
  }

  @override
  onPaymentCancel(Map? response) {
    // TODO: implement onPaymentCancel
    showAlertDialog(context, "onPaymentCancel", response.toString());
  }

  @override
  onPaymentFailure(response) {
    // TODO: implement onPaymentFailure
    showAlertDialog(context, "onPaymentFailure", response.toString());
  }

  @override
  onPaymentSuccess(response) {
    // TODO: implement onPaymentSuccess
    showAlertDialog(context, "onPaymentSuccess", response.toString());
  }
}
