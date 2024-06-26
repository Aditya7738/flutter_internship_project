import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/helpers/db_helper.dart';
import 'package:Tiara_by_TJ/model/layout_model.dart' as LayoutModel;
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NoInternetConnectionPage extends StatefulWidget {
  const NoInternetConnectionPage({super.key});

  @override
  State<NoInternetConnectionPage> createState() =>
      _NoInternetConnectionPageState();
}

class _NoInternetConnectionPageState extends State<NoInternetConnectionPage> {
  bool isInternetChecking = false;

  @override
  Widget build(BuildContext context) {
    // LayoutDesignProvider layoutDesignProvider =
    //     Provider.of<LayoutDesignProvider>(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/wi_fi_disconnected.png",
                  width: 150.0, height: 150.0, color: Color(0xffCC868A)
                  // Color(int.parse(
                  //     "0xff${layoutDesignProvider.primary.substring(1)}")),
                  ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                "No internet connection!",
                style: TextStyle(
                  color: Color(0xffCC868A),
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth > 600
                      ? deviceWidth / 25
                      : (deviceWidth / 25).sp,
                ),
                //  TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18.0,
                //     color: Color(int.parse(
                //  "0xff${layoutDesignProvider.primary.substring(1)}")))
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Please check your network connection",
                style: TextStyle(
                  color: Color(0xffCC868A),
                  fontWeight: FontWeight.normal,
                  fontSize: deviceWidth > 600
                      ? (deviceWidth / 30)
                      : (deviceWidth / 33).sp,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isInternetChecking = true;
                    });
                  }
                  final connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (mounted) {
                    setState(() {
                      isInternetChecking = false;
                    });
                  }

                  if (connectivityResult != ConnectivityResult.none) {
                    if (Navigator.canPop(context) == false) {
                      await getLayoutDesign();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                          ));
                    } else {
                      Navigator.pop(context, true);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        padding: EdgeInsets.all(15.0),
                        backgroundColor: Color(0xffCC868A),
                        content: Text(
                          "You have not connected to internet yet",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletButtonTextSize
                                  : Fontsizes.buttonTextSize),
                        )));
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: deviceWidth > 600
                        ? deviceWidth / 3.9
                        : (deviceWidth / 2.5).sp,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffCC868A),
                            // Color(int.parse(
                            //     "0xff${layoutDesignProvider.primary.substring(1)}")),
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        isInternetChecking
                            ? SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(
                                  color:
                                      // Color(int.parse(
                                      //     "0xff${layoutDesignProvider.primary.substring(1)}")),
                                      Color(0xffCC868A),
                                  strokeWidth: 2.0,
                                ),
                              )
                            : Image.asset(
                                "assets/images/reload.png",
                                color: Color(0xffCC868A),
                                // Color(int.parse(
                                //     "0xff${layoutDesignProvider.primary.substring(1)}")),
                                width: deviceWidth > 600 ? 30.0 : 20.0,
                                height: deviceWidth > 600 ? 30.0 : 20.0,
                              ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Try again",
                          style: TextStyle(
                            color: Color(0xffCC868A),
                            fontWeight: FontWeight.normal,
                            fontSize: deviceWidth > 600
                                ? (deviceWidth / 30)
                                : (deviceWidth / 28).sp,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  getLayoutDesign() async {
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
    } else {
      LayoutModel.LayoutModel layoutModel = LayoutModel.LayoutModel(
        success: Constants.defaultLayoutDesign["success"],
        data: Constants.defaultLayoutDesign["data"] == null
            ? null
            : LayoutModel.Data.fromJson(Constants.defaultLayoutDesign["data"]),
      );
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
  }
}
