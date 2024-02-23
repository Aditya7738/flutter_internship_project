import 'dart:convert';

import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/shipping_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/views/pages/signup_page.dart';
import 'package:Tiara_by_TJ/views/pages/you_page.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';

class LoginPage extends StatefulWidget {
  final bool isComeFromCart;
  const LoginPage({super.key, required this.isComeFromCart});

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

  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_outlined),
            onTap: () {
              if (widget.isComeFromCart) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
              } else {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardPage(),
                      ));
                }
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                      Text("Welcome back!",
                          style: Theme.of(context).textTheme.headline1),
                      const SizedBox(
                        height: 20.0,
                      ),

                      // isLoginUnSuccessful
                      //     ? Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             vertical: 15.0, horizontal: 25.0),
                      //         //width: MediaQuery.of(context).size.width,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.rectangle,
                      //             borderRadius: BorderRadius.circular(20.0),
                      //             color:
                      //                 const Color.fromARGB(255, 253, 233, 231),
                      //             border: Border.all(
                      //                 color: Colors.red,
                      //                 style: BorderStyle.solid)),
                      //         child: const Text(
                      //           "Email / password is wrong. Try again..",
                      //           style: TextStyle(
                      //               color: Colors.red, fontSize: 17.0),
                      //         ),
                      //       )
                      //     : const SizedBox(),

                      isLoginUnSuccessful
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 25.0),
                              //width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  color:
                                      const Color.fromARGB(255, 253, 233, 231),
                                  border: Border.all(
                                      color: Colors.red,
                                      style: BorderStyle.solid)),
                              child: Expanded(
                                child: Text(
                                  errorMsg,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 17.0),
                                ),
                              ),
                            )
                          : const SizedBox(),

                      const SizedBox(
                        height: 30.0,
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
                              if (mounted) {
      setState(() {
                                isObscured = !isObscured;
                              });
                              }
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
                            if (mounted) {
      setState(() {
                              email = _emailController.text;
                              password = _passwordController.text;
                            });
                            }
                            print("$email $password");

                            List<String> list = email.split('@');
                            String username = list[0];

                            // Map<String, dynamic> data = {
                            //   "email": email,
                            //   "password": password,
                            //   "username": username,
                            // };

                            // print("LOGIN DATA $data");
                            bool isThereInternet =
                                await ApiService.checkInternetConnection(
                                    context);
                            if (isThereInternet) {
                              if (mounted) {
      setState(() {
                                isLoading = true;
                              });
                              }

                              final response = await ApiService.loginCustomer(
                                  email, password, username);

                              if (response != null) {
                                if (response.statusCode == 200) {
                                  String body =
                                      await response.stream.bytesToString();

                                  print("BODY LOGIN $body");

                                  List<Map<String, dynamic>> data =
                                      <Map<String, dynamic>>[];
                                  try {
                                    data = List<Map<String, dynamic>>.from(
                                        jsonDecode(body));
                                    print("LOGIN JSON DECODE DATA $data");
                                  } catch (e) {
                                    print('Error decoding: $e');
                                  }

                                  customerProvider.setCustomerData(data);

                                  if (mounted) {
      setState(() {
                                    isLoading = false;
                                  });
                                  }

                                  widget.isComeFromCart
                                      ? Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => CartPage()))
                                      : Navigator.pop(context);
                                } else {
                                  String body =
                                      await response.stream.bytesToString();
                                  Map<String, dynamic> data =
                                      <String, dynamic>{};

                                  try {
                                    data = jsonDecode(body);

                                    print(
                                        "LOGIN ERROR DATA ${data["message"]}");

                                    if (mounted) {
      setState(() {
                                      isLoginUnSuccessful = true;
                                      errorMsg = data["message"];
                                    });
                                    }
                                    print("JSON DECODE DATA $data");
                                  } catch (e) {
                                    print('Error decoding: $e');
                                  }

                                  if (mounted) {
      setState(() {
                                    isLoading = false;
                                  });
                                  }
                                }
                              }
                            }
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
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
              ))),
        ));
  }
}
