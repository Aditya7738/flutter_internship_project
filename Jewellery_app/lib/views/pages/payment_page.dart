import 'dart:convert';

import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/helpers/payment_helper.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/helpers/hashservice.dart';
import 'package:Tiara_by_TJ/helpers/pay_u_params.dart';
import 'package:Tiara_by_TJ/model/payment_gatways_model.dart';
import 'package:Tiara_by_TJ/model/step.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/views/pages/payment_failed.dart';
import 'package:Tiara_by_TJ/views/pages/payment_successful.dart';
import 'package:Tiara_by_TJ/views/widgets/steplist.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
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
// import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

// import 'package:toast/toast.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;
  final bool fromCart;
  //final Map<String, String> cashFreeData;

  const PaymentPage({
    super.key,
    required this.orderId,
    required this.fromCart,
    //required this.cashFreeData
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    implements PayUCheckoutProProtocol {
  bool razorpayLoading = false;
  Razorpay _razorpay = Razorpay();
  late String order_id;
  // late Map<String, String> cashFreeData;
  //late String payableAmount;
  bool isLoading = false;
  late PayUCheckoutProFlutter _checkoutPro;

  int _expandedIndex = -1;

  String selectedPaymentMethod = "";

  //var cfPaymentGatewayService = CFPaymentGatewayService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    order_id = widget.orderId;
    //  cashFreeData = widget.cashFreeData;
    _checkoutPro = PayUCheckoutProFlutter(this as PayUCheckoutProProtocol);

    //cfPaymentGatewayService.setCallback(verifyPayment, onErrorPay);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    //  Toast.show("Payment successful ${response.paymentId}", duration: 2);
    print("Payment successful ${response.paymentId}");

//write method to call and create order at everytime payment get successful

    if (widget.fromCart == false) {
      createDigiGoldOrder(orderProvider, response.paymentId);
    } else {
      createCartOrder(orderProvider, cartProvider);
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => PaymentSucessfulPage(),
    ));
  }

  createCartOrder(
      OrderProvider orderProvider, CartProvider cartProvider) async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      cartProvider.setIsOrderCreating(true);
      orderProvider.setIsOrderCreating(true);

      print("cartProvider.isCouponApplied ${cartProvider.isCouponApplied}");

      print(
          "cartProvider.totalAfterCouponApplied ${cartProvider.totalAfterCouponApplied}");

      print("orderProvider.price ${orderProvider.price}");

      http.Response response = await ApiService.createOrder(
          orderProvider.billingData,
          orderProvider.shippingData,
          orderProvider.lineItems,
          orderProvider.customerId,
          cartProvider.isCouponApplied
              ? cartProvider.totalAfterCouponApplied.toString()
              : orderProvider.price.toString(),
          null);

      orderProvider.setIsOrderCreating(false);
      cartProvider.setIsOrderCreating(false);

      print("cart pay status ${response.statusCode}");

      if (response.statusCode == 201) {
        print("CartOrder CREATED SUCCESSFULLY");
        cartProvider.clearCartList();
        cartProvider.clearCartProductIds();
      }
    }
  }

  createDigiGoldOrder(OrderProvider orderProvider, String? paymentId) async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      orderProvider.setIsOrderCreating(true);
      print("selectedPaymentMethod $selectedPaymentMethod");
      orderProvider.addToMetaData([
        {"key": "payment_method", "value": selectedPaymentMethod},
        {"key": "payment_ref_id", "value": paymentId ?? "paymentId"},
        {"key": "payment_date", "value": DateTime.now().toString()},
      ]);

      print("digi billingData ${orderProvider.billingData}");
      print("digi shippingData ${orderProvider.shippingData}");
      print("digi lineItems ${orderProvider.lineItems}");
      print("digi customerId ${orderProvider.customerId}");
      print("digi price ${orderProvider.price}");
      print("digi metaData ${orderProvider.metaData}");

      http.Response response = await ApiService.createOrder(
          orderProvider.billingData,
          orderProvider.shippingData,
          orderProvider.lineItems,
          orderProvider.customerId,
          orderProvider.price,
          orderProvider.metaData);

      //jeweller contribution is not adding in metadata

      orderProvider.setIsOrderCreating(false);

      print("digi pay status ${response.statusCode}");

      if (response.statusCode == 201) {
        print("DigiGoldOrder CREATED SUCCESSFULLY");
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Toast.show("Payment failed ${response.message}", duration: 2);
    print("Payment failed ${response.message}");

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentFailedPage(fromCart: false),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Toast.show("External wallet ${response.walletName}", duration: 2);
    print("External wallet ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  makeRazorPayment() {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final customerData = customerProvider.customerData[0];

    print("customerData $customerData");
    String productName = "";
    String contact = "";
    String email = "";

    if (widget.fromCart) {
      for (int i = 0; i < cartProvider.cart.length; i++) {
        productName += cartProvider.cart[i].productName! + ", ";
      }
      contact = customerData["billing"]["phone"];
      email = customerData["email"];
    } else {
      print("digi_gold_plan_name ${customerData["digi_gold_plan_name"]}");
      productName = customerData["digi_gold_plan_name"];
      print(
          "digi_gold_billing_email ${customerData["digi_gold_billing_email"]}");
      email = customerData["digi_gold_billing_email"];
      print(
          "digi_gold_billing_phone ${customerData["digi_gold_billing_phone"]}");
      contact = customerData["digi_gold_billing_phone"];
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
      'prefill': {'contact': contact, 'email': email}
    };

    print("Payment $options");

    try {
      setState(() {
        razorpayLoading = true;
      });

      final response = _razorpay.open(
          options); // add await, setstate and make async func, since it taking time to open
      setState(() {
        razorpayLoading = false;
      });
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
          rsaKeyUrl:
              'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp' //redirecting to this link
          );
    } on PlatformException {
      print('PlatformException');
    } catch (e) {
      print("CcAvenue error ${e.toString()}");
    }
  }

  //CASHFREE ---------------------------------------------------

  // void verifyPayment(String orderId) {
  //   print("Verify Payment of order - $orderId");
  // }

  // void onErrorPay(CFErrorResponse errorResponse, String orderId) {
  //   print("Error while making payment ${errorResponse.getMessage()}");

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

  //PayU --------------------------------------------------------

  // openPayUCheckoutScreen() async {
  //   _checkoutPro.openCheckoutScreen(
  //     payUPaymentParams: PayUParams.createPayUPaymentParams(),
  //     payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
  //   );
  // }

  //------------------------------------------------------------------

  Future<List<ExpansionListItemModel>> getSteps() async {
    //ApiService.paymentGateways.clear();
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      await ApiService.getPaymentGateways();

      List<ExpansionListItemModel> list = <ExpansionListItemModel>[];

      for (int i = 0; i < ApiService.paymentGateways.length; i++) {
        list.add(ExpansionListItemModel(
            ApiService.paymentGateways[i].id ?? "0",
            ApiService.paymentGateways[i].title ?? "Payment method",
            ApiService.paymentGateways[i].description ?? ""));
      }

      print("list length ${list.length}");

      // var _items = [
      //   ExpansionListItemModel('Step 0: Install Flutter',
      //       'Install Flutter development tools according to the official documentation.'),
      //   ExpansionListItemModel('Step 1: Create a project',
      //       'Open your terminal, run `flutter create <project_name>` to create a new project.'),
      //   ExpansionListItemModel('Step 2: Run the app',
      //       'Change your terminal directory to the project directory, enter `flutter run`.'),
      // ];
      return list;
    }
    return <ExpansionListItemModel>[];
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // final customerProvider =
    //     Provider.of<CustomerProvider>(context, listen: false);
    //final customerData = customerProvider.customerData[0];
    final deviceWidth = MediaQuery.of(context).size.width;
    String productName = "";
    for (int i = 0; i < cartProvider.cart.length; i++) {
      productName += cartProvider.cart[i].productName! + ", ";
    }

    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Payment methods",
              style: TextStyle(fontSize: deviceWidth > 600 ? 28.sp : 17.sp)),
        ),
        body:
            //  isLoading
            //     ?
            //  Center(
            //     child: CircularProgressIndicator(
            //       backgroundColor: Colors.white,
            //     ),
            //   )
            // :
            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Select your preferred payment method",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: deviceWidth > 600
                                ? Fontsizes.tabletHeadingSize
                                : Fontsizes.headingSize)),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FutureBuilder(
                    future: getSteps(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ExpansionListItemModel>> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        List<ExpansionListItemModel>? expansionListItem =
                            snapshot.data;
                        //return SizedBox();
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ExpansionPanelList(
                                expansionCallback: (panelIndex, isExpanded) {
                                  print("pressed $panelIndex");
                                  if (expansionListItem != null) {
                                    //    ExpansionListItemModel expansionListItemModel = expansionListItem[panelIndex];

                                    // switch (expansionListItemModel.id) {
                                    //       case "cod":
                                    //         break;
                                    //       case "cashfree":
                                    //          //webCheckout();
                                    //         break;
                                    //       case "razorpay":
                                    //         makeRazorPayment();
                                    //         break;

                                    //       case "ccavenue":

                                    //       //Navigate to PaymentScreen - ccavenue _paymet_page.dart
                                    //         initPlatformState();
                                    //         break;
                                    //       case "stripe":
                                    //         break;

                                    //         // case "payubiz":
                                    //         // openPayUCheckoutScreen();
                                    //         // break;

                                    //       default:
                                    //     }

                                    if (mounted) {
                                      setState(() {
                                        print(
                                            " ExpansionPanelList $isExpanded");
                                        expansionListItem[panelIndex]
                                            .isExpanded = isExpanded;
                                      });
                                    }
                                  }
                                },
                                children: expansionListItem!
                                    .map<ExpansionPanel>((ExpansionListItemModel
                                        expansionListItemModel) {
                                  return ExpansionPanel(
                                      headerBuilder: (context, isExpanded) {
                                        expansionListItemModel.isExpanded =
                                            isExpanded;
                                        print(" ExpansionPanel $isExpanded");
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListTile(
                                            title: Text(
                                                expansionListItemModel.title,
                                                style: TextStyle(
                                                    fontSize: deviceWidth > 600
                                                        ? 25.sp
                                                        : 19.sp)),
                                          ),
                                        );
                                      },
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              HtmlWidget(
                                                  expansionListItemModel.body,
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                          deviceWidth > 600
                                                              ? 26.sp
                                                              : 18.sp)),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  switch (expansionListItemModel
                                                      .id) {
                                                    case "cod":
                                                      break;
                                                    case "cashfree":
                                                      //webCheckout();
                                                      break;
                                                    case "razorpay":
                                                      makeRazorPayment();
                                                      if (mounted) {
                                                        setState(() {
                                                          selectedPaymentMethod =
                                                              expansionListItemModel
                                                                  .title;
                                                        });
                                                      }

                                                      break;

                                                    case "ccavenue":

                                                      //Navigate to PaymentScreen - ccavenue _paymet_page.dart
                                                      initPlatformState();
                                                      break;
                                                    case "stripe":
                                                      break;

                                                    // case "payubiz":
                                                    // openPayUCheckoutScreen();
                                                    // break;

                                                    default:
                                                  }
                                                },
                                                child: Container(
                                                    width: 200.0,
                                                    // height: 40.0,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffCC868A),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.0)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Center(
                                                      child: razorpayLoading
                                                          ? CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : Text("Pay now",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: deviceWidth >
                                                                          600
                                                                      ? 25.sp
                                                                      : 17.sp)),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      isExpanded:
                                          expansionListItemModel.isExpanded);
                                }).toList(),
                              ),
                            ]);
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(int.parse(
                                  "0xff${layoutDesignProvider.primary.substring(1)}")),
                            ),
                          ),
                        );
                      }
                    },
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
