import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          height: 60.0,
          width: MediaQuery.of(context).size.width / 3,
          child: LayoutBuilder(
            builder: (context, constraints) {
              print("filter selection ${constraints.maxWidth / 45}");
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(option,
                      style:
                       isFilterTileClicked
                          ? Theme.of(context).textTheme.headline5
                          : Theme.of(context).textTheme.subtitle1
                      // TextStyle(
                      //   fontSize: (constraints.maxWidth / 9) - 2,
                      //     color: isFilterTileClicked
                      //         ? Theme.of(context).primaryColor
                      //         : Colors.black,
                      //         fontWeight: isFilterTileClicked?
                      //          FontWeight.bold:
                      //          FontWeight.normal),

                      ),
                  isFilterTileClicked
                      ? Container(
                          color: Theme.of(context).primaryColor,
                          width: constraints.maxWidth / 45,
                        )
                      : SizedBox()
                ],
              );
            },
            //   child:
          )),
    );
  }
}
