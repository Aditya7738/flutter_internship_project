import 'package:flutter/material.dart';

class ProductGridListItem extends StatefulWidget {
  const ProductGridListItem({super.key});

  @override
  State<ProductGridListItem> createState() => _ProductGridListItemState();
}

class _ProductGridListItemState extends State<ProductGridListItem> {
  @override
  Widget build(BuildContext context) {
    var icon = Icons.favorite_border_outlined;

    return Container(
      alignment: Alignment.topLeft,
              
        child: Column(
      children: [
        Stack(
          children: [
            Image.network(src),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(right: 5.0, top: 5.0),
              width: 7.0,
              height: 7.0,
              child: GestureDetector(
                child: Icon(
                  icon,
                  color: Color(0xFFCC868A),
                  size: 5.0,
                ),
                onTap: () {
                  setState(() {
                    icon = Icons.favorite;
                  });
                },
              ),
            ),
            Container(
                alignment: Alignment.bottomLeft,
                width: 20.0,
                height: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ))
          ],
        ),
        Text(productName),
        Text(price)
      ],
    )
    );
  }
}
