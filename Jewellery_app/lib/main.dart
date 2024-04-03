import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/helpers/db_helper.dart';
import 'package:Tiara_by_TJ/model/layout_model.dart' as LayoutModel;
import 'package:Tiara_by_TJ/providers/cache_provider.dart';
import 'package:Tiara_by_TJ/providers/category_provider.dart';
import 'package:Tiara_by_TJ/providers/customize_options_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/providers/filteroptions_provider.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/try.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/profile_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';
import 'package:flutter/services.dart';

import 'dart:async';

//import OneSignal
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LayoutModel.LayoutModel? layoutModel = await ApiService.getHomeLayout();
  DBHelper dbHelper = DBHelper();
  dbHelper.initDatabase();
  if (layoutModel != null) {
    if (layoutModel.data != null) {
      await dbHelper.checkDataExist();

      print("dbHelper.isDataExist ${dbHelper.isDataExist}");
      // if (isDataExist == false) {
      //   await dbHelper.insert(layoutModel);
      // }
      if (dbHelper.isDataExist) {
        await dbHelper.updateTable(layoutModel);
      } else {
        await dbHelper.insert(layoutModel);
      }
    }
  }
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
  // String? _emailAddress;
  // String? _smsNumber;
  // String? _externalUserId;
  // String? _language;
  // bool _enableConsentButton = false;

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
    OneSignal.initialize(Constants.oneSignalAppId);

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
      if (mounted) {
        setState(() {
          _debugLabelString =
              " \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        });
      }
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      if (mounted) {
        setState(() {
          _debugLabelString =
              "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        });
      }
    });
  }

  /////////////////////////////////////////

  // oneSignalOutcomeExamples() async {
  //   OneSignal.Session.addOutcome("normal_1");
  //   OneSignal.Session.addOutcome("normal_2");

  //   OneSignal.Session.addUniqueOutcome("unique_1");
  //   OneSignal.Session.addUniqueOutcome("unique_2");

  //   OneSignal.Session.addOutcomeWithValue("value_1", 3.2);
  //   OneSignal.Session.addOutcomeWithValue("value_2", 3.9);
  // }

////////////////////////////////////////////////////////
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    double deviceWidth = MediaQuery.of(context).size.width;
    print("deviceWidth / 30 ${(deviceWidth / 21) + 6}");

    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: (context) => WishlistProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(create: (context) => CustomerProvider()),
          ChangeNotifierProvider(
              create: (context) => CustomizeOptionsProvider()),
          ChangeNotifierProvider(create: (context) => FilterOptionsProvider()),
          ChangeNotifierProvider(create: (context) => DigiGoldProvider()),
          ChangeNotifierProvider(create: (context) => OrderProvider()),
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => CacheProvider()),
          ChangeNotifierProvider(create: (context) => LayoutDesignProvider())
        ],
        child: MaterialApp(
          //  navigatorKey: navigatorKey,
          title: Constants.app_name,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(size: (deviceWidth / 21) + 6),
                titleTextStyle: TextStyle(
                    fontSize: deviceWidth / 25, color: Colors.black), //product
              ),
              primaryColor: Color(0xffCC868A),
              textTheme:
              // Typography.englishLike2021.apply(fontSizeFactor: 1.sp),
             TextTheme(
                // headline1: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: deviceWidth / 25,
                // ),
                // headline2: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 15.5.sp,
                // ), //product details heading
                // headline3: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 13.5.sp,
                // ), //price text style
                // headline4: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: deviceWidth / 37,
                // ),
                // headline5: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 13.5.sp,
                //     color: Color(0xffCC868A)),
                // headline6: TextStyle(
                //     // fontSize: deviceWidth / 30,
                //     fontSize: 13.5.sp,
                //     fontWeight: FontWeight.normal),
                // subtitle1: TextStyle(
                //   fontWeight: FontWeight.normal,
                //   // fontSize: (deviceWidth / 33) + 1.5,
                //   fontSize: 16.sp
                // ),
                // subtitle2: TextStyle(
                //   color: Color(0xffCC868A),
                //   fontWeight: FontWeight.normal,
                //   fontSize: (deviceWidth / 33),
                // ),
                // bodyText1: TextStyle(
                //   color: Color(0xffCC868A),
                //   fontWeight: FontWeight.bold,
                //   fontSize: deviceWidth / 25,
                // ),
                // bodyText2: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: (deviceWidth / 33) + 1.5,
                // ),
                // button: TextStyle(
                //     color: Colors.white,
                //     fontSize: (deviceWidth / 30) - 1,
                //     fontWeight: FontWeight.bold),
              )

              ),
          // builder: (context, child) {
          //   //check below
          //   // ScreenUtil.init(context);
          //   // ScreenUtil.ensureScreenSizeAndInit(context);
          //   // ScreenUtil.registerToBuild(context);
          //   return MediaQuery(
          //       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          //       child: DashboardPage());
          // },
          // home:
          // //  MediaQuery(
          // //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          // //     child:
          //      Try()
          //     // )
          //      ,

      //     builder: (context, child) {
      // //      ScreenUtil.init(context);
      //       return 
      //       Theme(
      //           child: Try(),
      //           data: ThemeData(
      //             appBarTheme: AppBarTheme(
      //               actionsIconTheme:
      //                   IconThemeData(size: (deviceWidth / 21) + 6),
      //               titleTextStyle: TextStyle(
      //                   fontSize: 15.sp,
      //                   color: Colors.black), //product
      //             ),
      //             primaryColor: Color(0xffCC868A),
      //             textTheme: TextTheme(
      //               headline1: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 16.5.sp,
      //               ),
      //               headline2: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 15.5.sp,
      //               ), //product details heading
      //               headline3: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 13.5.sp,
      //               ), //price text style
      //               headline4: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: deviceWidth / 37,
      //               ),
      //               headline5: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 13.5.sp,
      //                   color: Color(0xffCC868A)),
      //               headline6: TextStyle(
      //                   // fontSize: deviceWidth / 30,
      //                   fontSize: 13.5.sp,
      //                   fontWeight: FontWeight.normal),
      //               subtitle1: TextStyle(
      //                   fontWeight: FontWeight.normal,
      //                   // fontSize: (deviceWidth / 33) + 1.5,
      //                   fontSize: 16.sp),
      //               subtitle2: TextStyle(
      //                 color: Color(0xffCC868A),
      //                 fontWeight: FontWeight.normal,
      //                 fontSize: (deviceWidth / 33),
      //               ),
      //               bodyText1: TextStyle(
      //                 color: Color(0xffCC868A),
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: deviceWidth / 25,
      //               ),
      //               bodyText2: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: (deviceWidth / 33) + 1.5,
      //               ),
      //               button: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: (deviceWidth / 30) - 1,
      //                   fontWeight: FontWeight.bold),
      //             ),
      //           ));
      //     },
      home: DashboardPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
