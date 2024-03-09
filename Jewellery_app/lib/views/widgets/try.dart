import 'package:flutter/material.dart';

class Try extends StatelessWidget {
  const Try({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Hi@_+,", 
          style: Theme.of(context).textTheme.headline1,),
          Text("Hi@_+,", 
          style: Theme.of(context).textTheme.headline2,),
          Text("Hi@_+,", 
          style: Theme.of(context).textTheme.headline3,),
          Text("Hi@_+,", 
          style: Theme.of(context).textTheme.headline4,),
        ],
      ),
    );
  }
}