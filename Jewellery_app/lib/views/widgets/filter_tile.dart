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
      
          height: 45.0,
          width: MediaQuery.of(context).size.width / 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option,
                style: TextStyle(
                  fontSize: 15.0,
                    color: isFilterTileClicked
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              ),
              isFilterTileClicked
                  ? Container(
                      color: Theme.of(context).primaryColor,
                      width: 3.0,
                    )
                  : SizedBox()
            ],
          )),
    );
  }
}
