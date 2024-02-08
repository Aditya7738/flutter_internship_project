import 'package:flutter/material.dart';

class FilterSubOptions extends StatelessWidget {
  const FilterSubOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
       
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width / 3),
        height: (MediaQuery.of(context).size.height / 2) - 77,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("14 KT"), Text("2")],
              ),
            );
          },
          itemCount: 1,
        ),
      );
  }
}
