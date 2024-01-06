import 'package:flutter/material.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const SizedBox(
          height: 40.0,
          child: TextField(
            showCursor: true,
            maxLines: 1,
            autofocus: true,
            cursorColor: Colors.grey,
            decoration: InputDecoration(

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey
                )
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.grey,
                size: 30.0,
              ),

                fillColor: Colors.grey,
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0

                )

            ),

          ),
        ),

        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                  "assets/images/ios_mic_outline.png",
                color: Colors.grey,
                width: 30.0,
                height: 30.0,
              )          )
        ],
        )

      // AppBar(
      //   actions: const [
      //     TextField(
      //       showCursor: true,
      //         maxLines: 1,
      //       autofocus: true,
      //       decoration: InputDecoration(
      //         icon: Icon(Icons.search_rounded),
      //         hintText: "Search",
      //         hintStyle: TextStyle(
      //           color: Colors.grey
      //         )
      //       ),
      //     ),
      //     Icon(Icons.mic_none_rounded),
      //
      //   ],
      // ),
    );
  }
}
