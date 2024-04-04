import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterTile extends StatelessWidget {
  final bool isFilterTileClicked;
  final String option;
  final VoidCallback onTap;

  FilterTile(
      {super.key,
      required this.isFilterTileClicked,
      required this.option,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    print(
        "(MediaQuery.of(context).size.width / 20) ${(MediaQuery.of(context).size.width / 20)}");
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          height: deviceWidth > 600 ? 60.0 : 43.0,
          width: (MediaQuery.of(context).size.width / 3) - 2,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  option,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: isFilterTileClicked
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5.sp,
                          color: Theme.of(context).primaryColor)
                      : TextStyle(
                          fontWeight: FontWeight.normal,
                          // fontSize: (deviceWidth / 33) + 1.5,
                          // fontSize: 16.sp
                        ),
                  // TextStyle(
                  //   fontSize: (constraints.maxWidth / 9) - 2,
                  //     color: isFilterTileClicked
                  //         ? Theme.of(context).primaryColor
                  //         : Colors.black,
                  //         fontWeight: isFilterTileClicked?
                  //          FontWeight.bold:
                  //          FontWeight.normal),
                ),
                // isFilterTileClicked
                //     ? Container(
                //         color: Theme.of(context).primaryColor,
                //         width: deviceWidth > 600 ? 8.0 : 5.0,
                //       )
                //     : SizedBox()
              ],
            ),
          )),
    );
  }
}
