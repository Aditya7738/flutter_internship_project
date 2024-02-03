// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // ignore_for_file: public_member_api_docs

// import 'package:flutter/material.dart';
// import 'package:Tiara_by_TJ/views/pages/payment_failed.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:html/parser.dart' show parse;
// import 'package:http/http.dart' as http;

// void main() => runApp(const MaterialApp(home: WebViewExample()));

// class WebViewExample extends StatefulWidget {
//   const WebViewExample({super.key});

//   @override
//   State<WebViewExample> createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewExample> {
//   late final WebViewController controller;
//   String cancelUrl = 'http://122.182.6.216/merchant/ccavResponseHandler.jsp';
//   String redirectUrl = 'http://122.182.6.216/merchant/ccavResponseHandler.jsp';
//   String transUrl =
//       'https://test.ccavenue.com/transaction/initTrans'; // production link - //https://secure.ccavenue.com/transaction/initTrans
//   String accessCode = 'Tiara@Jwero';
//   String amount = '10';

//   String currencyType = 'INR';
//   String merchantId = 'tiarabytj@gmail.com';
//   String orderId = '519';

//   String rsaKeyUrl =
//       'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp'; //redirecting to this link

//   @override
//   void initState() {
//     super.initState();

//     // #docregion webview_controller
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
            
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) async {
//             if (url == redirectUrl) {
//               //following javascript function,could be different as per data you sent from the server
//               final Object htmlContent =
//                   await controller.runJavaScriptReturningResult(
//                       "your javascript function to fetch data");
//               final parsedJson = parse(htmlContent);
//               final jsonData = parsedJson.body?.text;
//               controller.clearCache();
//               final result = jsonDecode(jsonDecode(jsonData!));
//               log(result.toString());
//               print(result.toString());
//               //TODO: ON RESULT
//             }
//             if (url == cancelUrl) {
//               //TODO: ON RESULT
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaymentFailedPage(),
//                   ));
//             }
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             // if (request.url.startsWith('https://www.youtube.com/')) {
//             //   return NavigationDecision.prevent;
//             // }
//             // return NavigationDecision.navigate;
//             if (request.url == redirectUrl) {
//                   return NavigationDecision.navigate;
//                 }
//                 if (request.url == cancelUrl) {
//                   return NavigationDecision.navigate;
//                 }
//                 return NavigationDecision.prevent;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://test.ccavenue.com/transaction.do?command=initiateTransaction&encRequest=${res['enc_val']}&access_code=${res['access_code']}"'));
//     // #enddocregion webview_controller
//   }

//   // #docregion webview_widget
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Flutter Simple Example')),
//       body: WebViewWidget(controller: controller),
//     );
//   }
//   // #enddocregion webview_widget
// }
