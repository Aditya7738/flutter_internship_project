import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/views/pages/you_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  Image.network(
                  
                    Strings.app_logo,
                    width: 150.0,
                    height: 70.0,
                   
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Welcome back!", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 20.0,
                  ),
                   TextFormField(
                     keyboardType: TextInputType.name,
                     validator: (value) {
                       return ValidationHelper.isEmailValid(value);
                     },
                     decoration: const InputDecoration(
                       // errorText: ,
                       labelText: "Enter your email",
                       border: OutlineInputBorder(
                           borderRadius:
                               BorderRadius.all(Radius.circular(20.0))),
                     ),
                   ),
                  const SizedBox(
                    height: 30.0,
                  ),
                   TextFormField(
                     keyboardType: TextInputType.name,
                     validator: (value) {
                       return ValidationHelper.isEmailValid(value);
                     },
                     decoration: const InputDecoration(
                       // errorText: ,
                       labelText: "Enter your password",
                       border: OutlineInputBorder(
                           borderRadius:
                               BorderRadius.all(Radius.circular(20.0))),
                     ),
                   ),
                   const SizedBox(
                    height: 30.0,
                  ),

                   GestureDetector(
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => YouPage()));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xffCC868A),
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Center(
                          child: const Text(
                            "LOGIN",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),

                  SizedBox(height: 20.0,),
                  Center(
                      child: RichText(
                          text: TextSpan(
                              text:
                                  'New to Tiara By TJ?',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                        TextSpan(
                          text: '  Create Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffCC868A),
                            
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              
                            },
                        ),
                      ]))),



                ]
              )
            )
      )
    

      );
    
  }
}