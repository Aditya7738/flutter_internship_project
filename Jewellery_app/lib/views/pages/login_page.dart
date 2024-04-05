import 'dart:convert';

import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';
import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/shipping_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/views/pages/signup_page.dart';
import 'package:Tiara_by_TJ/views/pages/account_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController.text = "Sldi4e@#45";
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final deviceWidth = MediaQuery.of(context).size.width;
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
                child: Container(
                  width: MediaQuery.of(context).size.width > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.network(
                        //   Constants.app_logo,
                        //   // width: 150.0,
                        //   height: 70.0,
                        //   fit: BoxFit.fill,
                        // ),
                        CachedNetworkImage(
                          imageUrl: Constants.app_logo,
                          fit: BoxFit.fill,
                          height: 70.0,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Text("Welcome back!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletHeadingSize
                                  : Fontsizes.headingSize,
                            )),
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
                                    color: const Color.fromARGB(
                                        255, 253, 233, 231),
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
                          style: TextStyle(
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletTextFormInputFieldSize
                                  : Fontsizes.textFormInputFieldSize),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return ValidationHelper.isEmailValid(value);
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: deviceWidth > 600
                                    ? Fontsizes.tabletErrorTextSize
                                    : Fontsizes.errorTextSize,
                                color: Colors.red),
                            labelStyle: TextStyle(
                                fontSize: deviceWidth > 600
                                    ? Fontsizes.tabletTextFormInputFieldSize
                                    : Fontsizes.textFormInputFieldSize),
                            // errorText: ,
                            labelText: "Enter your email*",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),

                        TextFormField(
                          style: TextStyle(
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletTextFormInputFieldSize
                                  : Fontsizes.textFormInputFieldSize),
                          controller: _passwordController,
                          obscureText: isObscured,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            return ValidationHelper.isPasswordContain(value);
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontSize: deviceWidth > 600
                                    ? Fontsizes.tabletErrorTextSize
                                    : Fontsizes.errorTextSize,
                                color: Colors.red),
                            labelStyle: TextStyle(
                                fontSize: deviceWidth > 600
                                    ? Fontsizes.tabletTextFormInputFieldSize
                                    : Fontsizes.textFormInputFieldSize),
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                }
                              },
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 35.0,
                              ),
                            ),
                            // errorText: ,
                            labelText: "Enter your password*",
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

                                // final response = await ApiService.loginCustomer(
                                //     email, password, username);
                                final response = await ApiService.loginToken(
                                    email, password);

                                if (response != null) {
                                  if (response.statusCode == 200) {
                                    String body =
                                        await response.stream.bytesToString();

                                    print("BODY LOGIN $body");

                                    Map<String, dynamic> data =
                                        <String, dynamic>{};
                                    try {
                                      data = Map<String, dynamic>.from(
                                          jsonDecode(body));

                                      if (data.isEmpty) {
                                        errorMsg =
                                            "User with this email id not exist";
                                        customerProvider
                                            .setIsUserLoggedIn(false);
                                      } else {
                                        customerProvider
                                            .setIsUserLoggedIn(true);
                                        customerProvider.addCustomerData(data);

                                        customerProvider.customerData
                                            .forEach((element) {
                                          print("customerData $element");
                                        });

                                        final response =
                                            await ApiService.getCustomerData(
                                                email);

                                        if (response != null) {
                                          if (response.statusCode == 200) {
                                            String body = await response.stream
                                                .bytesToString();

                                            print("get customer body $body");

                                            List<Map<String, dynamic>>
                                                customerData =
                                                <Map<String, dynamic>>[];
                                            try {
                                              customerData = List<
                                                      Map<String,
                                                          dynamic>>.from(
                                                  jsonDecode(body));

                                              if (customerData.isEmpty) {
                                                print("customer data empty");
                                              } else {
                                                print(
                                                    "List<Map<String, dynamic>> customerData $customerData");
                                                customerProvider
                                                    .addToFirst(customerData);

                                                customerProvider.customerData
                                                    .forEach((element) {
                                                  print(
                                                      "after get customerData $element");
                                                });
                                              }
                                            } catch (e) {
                                              print(
                                                  "get customer data error $e");
                                            }
                                          }
                                        }
                                      }

                                      print("LOGIN JSON DECODE DATA $data");
                                    } catch (e) {
                                      print('Error decoding: $e');
                                      //: Error decoding: type '_Map<String, dynamic>' is not a subtype of type 'Iterable<dynamic>'
                                    }

                                    // customerProvider.setCustomerData(data);

                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }

                                    //

                                    widget.isComeFromCart
                                        ? Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartPage()))
                                        : Navigator.pop(context);
                                  } else {
                                    String body =
                                        await response.stream.bytesToString();
                                    Map<String, dynamic> data =
                                        <String, dynamic>{};

                                    customerProvider.setIsUserLoggedIn(false);

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
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                      isLoginUnSuccessful = true;
                                      errorMsg =
                                          "Email and password don't match";
                                    });
                                  }
                                }
                              }
                            }
                          },
                          child: Container(
                              //TODO: give height to button container after it start loading
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: const Color(0xffCC868A),
                                  borderRadius: BorderRadius.circular(15.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                child: isLoading
                                    ? Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        width: (deviceWidth / 28),
                                        height: (deviceWidth / 28) + 9,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.0,
                                          backgroundColor: Color(0xffCC868A),
                                        ),
                                      )
                                    : Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: deviceWidth > 600
                                                ? Fontsizes.tabletButtonTextSize
                                                : Fontsizes.buttonTextSize
                                                ),
                                      ),
                              )),
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                            child: RichText(
                                text: TextSpan(
                                    children: <TextSpan>[
                              TextSpan(
                                text: 'New to Tiara By TJ?',
                                style: TextStyle(
                                    //  fontWeight: FontWeight.bold,
                                    //  fontSize: 14.5.sp,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '  Create Account',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    //  fontSize: 14.5.sp,
                                    color: Theme.of(context).primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ));
                                  },
                              ),
                            ],
                                    style: TextStyle(
                                        fontSize: deviceWidth > 600
                                            ? 24.sp
                                            : 16.sp)
                                            ))),
                      ]),
                ),
              ))),
        ));
  }
}
