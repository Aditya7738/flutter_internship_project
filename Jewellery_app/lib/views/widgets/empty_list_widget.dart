import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/views/pages/search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EmptyListWidget extends StatelessWidget {
  final String imagePath;
  final String message;
  bool forCancelledOrder;

  EmptyListWidget({
    super.key,
    required this.imagePath,
    required this.message,
    this.forCancelledOrder = false,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //           padding: const EdgeInsets.only(top: 28.0),
  //           child: Center(
  //             child: Column(

  //               mainAxisAlignment: MainAxisAlignment.center,

  //               children: [
  //                 Image.asset(

  //                   imagePath,
  //                   width: 150.0,
  //                   height: 150.0,
  //                   color: Colors.green,
  //                 ),
  //                 const SizedBox(
  //                   height: 40.0,
  //                 ),
  //                 Center(
  //                   child: Text(

  //                     message,
  //                     style: const TextStyle(fontSize: 18.0),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 50.0,
  //                 ),

  //                 !forCancelledOrder ?

  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                         builder: (context) => const SearchPage()));
  //                   },
  //                   child: Container(
  //                       decoration: BoxDecoration(
  //                           color: Colors.green,
  //                           borderRadius: BorderRadius.circular(5.0)),
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 10.0, horizontal: 40.0),
  //                       child: const Text(
  //                         "CONTIUE SHOPPING",
  //                         style:
  //                             TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
  //                       )),
  //                 )
  //                 :
  //                 const SizedBox()
  //               ],
  //             ),
  //           ),
  //         );
  // }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath,
                width: 150.0,
                height: 150.0,
                color: Color(int.parse(
                    "0xff${layoutDesignProvider.primary.substring(1)}"))),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Color(int.parse(
                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                fontWeight: FontWeight.normal,
                fontSize: deviceWidth > 600 ? 25.sp : 16.sp,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            !forCancelledOrder
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DashboardPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: const Text(
                          "CONTINUE SHOPPING",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
