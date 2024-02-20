import 'package:Tiara_by_TJ/providers/customize_options_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/pages/digi_gold_page.dart';
import 'package:Tiara_by_TJ/views/pages/filter.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen2.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen3.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/profile_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'constants/strings.dart';
import 'package:flutter/services.dart';

import 'dart:async';

//import OneSignal
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(const MyApp());
}

//TODO: call api of cart and wishlist, customer, order to get updated data to show before dashboard

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String _debugLabelString = "";
  String? _emailAddress;
  String? _smsNumber;
  String? _externalUserId;
  String? _language;
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    try {
      Map<Permission, PermissionStatus> status =
          await [Permission.notification, Permission.storage].request();

      if (status[Permission.notification] == PermissionStatus.denied) {
        Permission.notification.request();
      } else if (status[Permission.notification] ==
          PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }

      if (status[Permission.storage] == PermissionStatus.denied) {
        Permission.storage.request();
      } else if (status[Permission.storage] ==
          PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    } catch (e) {
      print("Error requesting permissions: $e");
    }
  }

  Future<void> initPlatformState() async {
    print("runing initPlatformState");
    print("ismounted $mounted");
    if (!mounted) return;

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(_requireConsent);

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    OneSignal.initialize("c58ace4e-b5d1-4ebe-b769-c0705eeac0db");

    OneSignal.Notifications.clearAll();

    // await Permission.notification.isDenied.then((value) {
    //   if (value) {
    //     Permission.notification.request();
    //   }
    // });

    // await Permission.mediaLibrary.isDenied.then((value){
    //   if (value) {
    //     Permission.mediaLibrary.request();
    //   }
    // });

    // await Permission.accessMediaLocation.isDenied.then((value){
    //   if (value) {
    //     Permission.accessMediaLocation.request();
    //   }
    // });

    // await Permission.storage.isDenied.then((value) {
    //   if (value) {
    //     Permission.storage.request();
    //   }
    // });

    // await Permission.notification.isPermanentlyDenied.then((value) async {
    //   if (value) {
    //     await openAppSettings();
    //   }
    // });

    // await Permission.storage.isPermanentlyDenied.then((value) async {
    //   if (value) {
    //     await openAppSettings();
    //   }
    // });

    OneSignal.User.pushSubscription.addObserver((state) {
      print("PERMISSION STATE ${state.current.optedIn}");
      print("optedIn ${OneSignal.User.pushSubscription.optedIn}");
      print("id ${OneSignal.User.pushSubscription.id}");
      print("token ${OneSignal.User.pushSubscription.token}");
      print("desc ${state.current.jsonRepresentation()}");
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("HAS PERMISSION " + state.toString());
      // if(state == false){
      //   Permission.notification.request();
      // }
    });

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
      setState(() {
        _debugLabelString =
            " \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      setState(() {
        _debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });
  }

  /////////////////////////////////////////

  oneSignalOutcomeExamples() async {
    OneSignal.Session.addOutcome("normal_1");
    OneSignal.Session.addOutcome("normal_2");

    OneSignal.Session.addUniqueOutcome("unique_1");
    OneSignal.Session.addUniqueOutcome("unique_2");

    OneSignal.Session.addOutcomeWithValue("value_1", 3.2);
    OneSignal.Session.addOutcomeWithValue("value_2", 3.9);
  }

////////////////////////////////////////////////////////
 final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    getBasicAuthForRazorPay(context);



    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => CustomizeOptionsProvider()),
        ChangeNotifierProvider(create: (context) => FilterOptionsProvider()),
        ChangeNotifierProvider(create: (context) => DigiGoldProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: Strings.app_name,
        theme: ThemeData(
            primaryColor: Color(0xffCC868A),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              headline2: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ), //product details heading
              headline3: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ), //price text style
              headline4: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            )),
        home: DashboardPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  void getBasicAuthForRazorPay(BuildContext context) async {
    print("getBasicAuthForRazorPay");
    await ApiService.generateBasicAuthForRazorPay(context);
  }
}
