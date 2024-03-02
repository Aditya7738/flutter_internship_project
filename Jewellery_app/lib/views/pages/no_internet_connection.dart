import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/wi_fi_disconnected.png",
                width: 150.0,
                height: 150.0,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                "No internet connection!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Please check your network connection",
                style: TextStyle(
                    fontSize: 18.0, color: Theme.of(context).primaryColor),
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardPage(),
                          ));
                    }
                    Navigator.pop(context, true);
                  }
                },
                child: Container(
                    width: 155,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        isInternetChecking
                            ? CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: 2.0,
                              )
                            : Image.asset(
                                "assets/images/reload.png",
                                color: Theme.of(context).primaryColor,
                                width: 20.0,
                                height: 20.0,
                              ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Try again",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0),
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
}
