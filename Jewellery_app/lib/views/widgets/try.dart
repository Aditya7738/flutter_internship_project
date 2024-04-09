import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Try extends StatelessWidget {
  const Try({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Hi@_+,",
            style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          ),
          Text(
            "Hi@_+,",
            style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          ),
          Text(
            "Hi@_+,",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            "Hi@_+,",
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            "Hi@_+,",
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Color(int.parse(
                      "0xff${layoutDesignProvider.primary.substring(1)}")),
                  borderRadius: BorderRadius.circular(5.0)),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              child: Text("CONTINUE SHOPPING",
                  style: Theme.of(context).textTheme.button
                  // Text//Style(
                  //     color: Colors.white,
                  //     fontSize: 17.0,
                  //     fontWeight: FontWeight.bold),
                  )),
        ],
      ),
    );
  }
}
