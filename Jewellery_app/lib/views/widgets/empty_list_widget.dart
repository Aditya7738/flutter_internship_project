import 'package:flutter/material.dart';
import 'package:jwelery_app/views/pages/search_page.dart';

class EmptyListWidget extends StatelessWidget {
  final String imagePath;
  final String message;
  bool forCancelledOrder;
  EmptyListWidget({
    super.key, required this.imagePath, required this.message, this.forCancelledOrder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Center(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  Image.asset(
                  
                    imagePath,
                    width: 150.0,
                    height: 150.0,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Text(
                     
                      message,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),

                  !forCancelledOrder ?

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SearchPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: const Text(
                          "CONTIUE SHOPPING",
                          style:
                              TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                        )),
                  )
                  :
                  SizedBox()
                ],
              ),
            ),
          );
  }
}