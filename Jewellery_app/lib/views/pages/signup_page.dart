import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'dart:convert';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:jwelery_app/views/pages/login_page.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String phone = "";
  String email = "";
  String first_name = "";
  String last_name = "";
  String password = "";

  List<String> options = ["+91", "+92"];

  String selectedOption = "+91";

  bool isObscured = true;
  bool isObscured2 = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    return Scaffold(
        appBar: AppBar(),
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
                      Text(
                        "Signup with Tiara By TJ",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 75.0,
                        child: TextFormField(
                          controller: _phoneNoController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            return ValidationHelper.isPhoneNoValid(value);
                          },
                          decoration: InputDecoration(
                              // suffix: GestureDetector(
                              //     onTap: () {
                              //       // value.setPhoneNoVerified(true);
                              //     },
                              //     child: value.phoneNoVerified
                              //         ? Container(
                              //             width: 100.0,
                              //             height: 40.0,
                              //             decoration: BoxDecoration(
                              //                 color: Color(0xffCC868A),
                              //                 borderRadius:
                              //                     BorderRadius.circular(10.0)),
                              //             padding: const EdgeInsets.symmetric(
                              //                 vertical: 10.0, horizontal: 20.0),
                              //             child: Center(
                              //               child: const Text(
                              //                 "VERIFY",
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 15.0),
                              //               ),
                              //             ))
                              //         : Padding(
                              //             padding:
                              //                 const EdgeInsets.only(bottom: 0.0),
                              //             child: Image.asset(
                              //               "assets/images/yes.png",
                              //               width: 30.0,
                              //               height: 25.0,
                              //             ),
                              //           )),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              prefix: DropdownButton(
                                  value: selectedOption,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  items: options.map((String option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedOption = newValue!;
                                    });
                                  }),
                              labelText: "Mobile number*"),
                          maxLines: 1,
                        ),
                      ),
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
                      Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 35,
                            child: TextFormField(
                              controller: _firstNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return ValidationHelper.nullOrEmptyString(
                                    value);
                              },
                              decoration: const InputDecoration(
                                // errorText: ,
                                labelText: "First Name*",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 28.0,
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 35,
                            child: TextFormField(
                              controller: _lastNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return ValidationHelper.nullOrEmptyString(
                                    value);
                              },
                              decoration: InputDecoration(
                                labelText: "Last Name*",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                          ),
                        ],
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
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: isObscured2,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          return ValidationHelper.isPassAndConfirmPassSame(
                              _passwordController.text, value!);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscured2 = !isObscured2;
                              });
                            },
                            icon: Icon(isObscured
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          // errorText: ,
                          labelText: "Confirm your password",
                          border: OutlineInputBorder(
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
                              phone = _phoneNoController.text;
                              email = _emailController.text;
                              first_name = _firstNameController.text;
                              last_name = _lastNameController.text;
                              password = _passwordController.text;
                            });

                            List<String> list = email.split('@');
                            String username = list[0];

                            print(
                                "$phone $email $first_name $last_name $username");

                            Map<String, dynamic> data = {
                              "phone": phone,
                              "first_name": first_name,
                              "last_name": last_name,
                              "email": email,
                              "username": username,
                              "password": password
                            };

                            print("SAVED DATA $data");

                            setState(() {
                              isLoading = true;
                            });

                            final response =
                                await ApiService.createCustomer(data);

                            setState(() {
                              isLoading = false;
                            });

                            if (response.statusCode == 201) {
                              String body = response.body;

                              try {
                                Map<String, dynamic> data = jsonDecode(body);
                                print("JSON DECODE DATA $data");
                              } catch (e) {
                                print('Error decoding: $e');
                              }

                              customerProvider.setCustomerData(data);
                            }
                          }
                          // print("$phoneNo $email $firstName $lastName");
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
                              child: isLoading
                                  ? SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                        backgroundColor: Color(0xffCC868A),
                                      ),
                                    )
                                  : const Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Already have an account?',
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                            TextSpan(
                              text: ' Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffCC868A),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                                },
                            ),
                          ]))),
                    ]),
              ))),
        ));
  }
}
