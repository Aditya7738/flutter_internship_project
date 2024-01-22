import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/views/pages/signup_page.dart';
import 'package:jwelery_app/views/pages/you_page.dart';
import 'package:provider/provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isObscured = true;

  bool isObscured2 = true;

  bool isLoading = false;
  String email = "";
  String password = "";

  bool isLoginUnSuccessful = false;

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Form(
              key: _formKey,
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
                    const Text(
                      "Welcome back!",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    isLoginUnSuccessful
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            //width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromARGB(255, 235, 93, 83),
                                border: Border.all(
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            child: Text(
                              "Email / password is wrong. Try again..",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox(),

                    const SizedBox(
                      height: 20.0,
                    ),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return ValidationHelper.isEmailValid(value);
                      },
                      decoration: const InputDecoration(
                        // errorText: ,
                        labelText: "Enter your email*",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    //  TextFormField(
                    //    keyboardType: TextInputType.visiblePassword,
                    //    validator: (value) {
                    //      return ValidationHelper.isPasswordContain(value);
                    //    },
                    //    decoration: const InputDecoration(
                    //      // errorText: ,
                    //      labelText: "Enter your password",
                    //      border: OutlineInputBorder(
                    //          borderRadius:
                    //              BorderRadius.all(Radius.circular(20.0))),
                    //    ),
                    //  ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isObscured,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return ValidationHelper.isPasswordContain(value);
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          icon: Icon(isObscured
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        // errorText: ,
                        labelText: "Enter your password",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),

                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                            password = _passwordController.text;
                          });
                          print("$email $password");

                          List<String> list = email.split('@');
                          String username = list[0];

                          // Map<String, dynamic> data = {
                          //   "email": email,
                          //   "password": password,
                          //   "username": username,
                          // };

                          // print("LOGIN DATA $data");

                          setState(() {
                            isLoading = true;
                          });

                          final response = await ApiService.loginCustomer(
                              email, password, username);

                          setState(() {
                            isLoading = false;
                          });

                          if (response != null) {
                            String body = await response.stream.bytesToString();

                            Map<String, dynamic> data = <String, dynamic>{};
                            try {
                              data = jsonDecode(body);
                              print("LOGIN JSON DECODE DATA $json");
                            } catch (e) {
                              print('Error decoding: $e');
                            }

                            // String body = response.body;

                            // Map<String, dynamic> data = <String, dynamic>{};

                            // try {
                            //   data = jsonDecode(body);
                            //   print("LOGIN JSON DECODE DATA $data");
                            // } catch (e) {
                            //   print('Error decoding: $e');
                            // }

                            customerProvider.setCustomerData(data);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => YouPage()));
                          } else {
                            setState(() {
                              isLoginUnSuccessful = true;
                            });
                          }
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color(0xffCC868A),
                              borderRadius: BorderRadius.circular(15.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                      backgroundColor: Color(0xffCC868A),
                                    ),
                                  )
                                : const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                          )),
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                        child: RichText(
                            text: TextSpan(
                                text: 'New to Tiara By TJ?',
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                          TextSpan(
                            text: '  Create Account',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffCC868A),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
                                ));
                              },
                          ),
                        ]))),
                  ]),
            ))));
  }
}
