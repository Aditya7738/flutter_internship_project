import 'package:flutter/material.dart';

class Try extends StatelessWidget {
  const Try({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Hi@_+,",
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            "Hi@_+,",
            style: Theme.of(context).textTheme.headline2,
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5.0)),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              child: Text("CONTINUE SHOPPING",
                  style: Theme.of(context).textTheme.button
                  // TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 17.0,
                  //     fontWeight: FontWeight.bold),
                  )),
        ],
      ),
    );
  }
}
