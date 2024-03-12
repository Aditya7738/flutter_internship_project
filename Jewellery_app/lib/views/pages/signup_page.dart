import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'dart:convert';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  bool isRegisterUnSuccessful = false;
  String errorMsg = "";

  Future<void> onLinkClicked(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print("Could not launch Terms and condition's URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    _passwordController.text = "Sldi4e@#45";
    _confirmPasswordController.text = "Sldi4e@#45";
    _phoneNoController.text = "4153516564";

    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              child: Icon(Icons.arrow_back_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        isComeFromCart: false,
                      ),
                    ));
              }),
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
                        Constants.app_logo,
                      height: 60.0,
                          fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text("Signup with Tiara By TJ",
                          style: Theme.of(context).textTheme.headline1),
                      const SizedBox(
                        height: 20.0,
                      ),
                      isRegisterUnSuccessful
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
                      SizedBox(
                        height: 75.0,
                        child: TextFormField(
                           style: Theme.of(context).textTheme.subtitle1,
                          controller: _phoneNoController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            return ValidationHelper.isPhoneNoValid(value);
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontSize: (deviceWidth / 33) + 1.5,
                                  color: Colors.red),
                              labelStyle: Theme.of(context).textTheme.subtitle1,
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
                                    if (mounted) {
                                      setState(() {
                                        selectedOption = newValue!;
                                      });
                                    }
                                  }),
                              labelText: "Mobile number*"),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.subtitle1,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return ValidationHelper.isEmailValid(value);
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: (deviceWidth / 33) + 1.5,
                              color: Colors.red),
                          labelStyle: Theme.of(context).textTheme.subtitle1,
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
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 35,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.subtitle1,
                              controller: _firstNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return ValidationHelper.nullOrEmptyString(
                                    value);
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    fontSize: (deviceWidth / 33) + 1.5,
                                    color: Colors.red),
                                labelStyle:
                                    Theme.of(context).textTheme.subtitle1,
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
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 35,
                            child: TextFormField(
                           style: Theme.of(context).textTheme.subtitle1,
                              controller: _lastNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return ValidationHelper.nullOrEmptyString(
                                    value);
                              },
                              decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: (deviceWidth / 33) + 1.5,
                              color: Colors.red
                            ),
                            labelStyle: Theme.of(context).textTheme.subtitle1,
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
                           style: Theme.of(context).textTheme.subtitle1,
                        controller: _passwordController,
                        obscureText: isObscured,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          return ValidationHelper.isPasswordContain(value);
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: (deviceWidth / 33) + 1.5,
                              color: Colors.red
                            ),
                            labelStyle: Theme.of(context).textTheme.subtitle1,
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
                                : Icons.visibility_off,
                                
                                size: 34.0,),
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
                      TextFormField(
                           style: Theme.of(context).textTheme.subtitle1,
                        controller: _confirmPasswordController,
                        obscureText: isObscured2,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          return ValidationHelper.isPassAndConfirmPassSame(
                              _passwordController.text, value!);
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(
                              fontSize: (deviceWidth / 33) + 1.5,
                              color: Colors.red
                            ),
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  isObscured2 = !isObscured2;
                                });
                              }
                            },
                            icon: Icon(isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                                 size: 34.0,),
                          ),
                          // errorText: ,
                          labelText: "Confirm your password",
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                          child: RichText(
                              text: TextSpan(
                                  text:
                                      '*By clicking on Save chage, you accept our ',
                                  style: Theme.of(context).textTheme.subtitle1,
                                  children: <TextSpan>[
                            TextSpan(
                              text: 'T&C',
                              style: Theme.of(context).textTheme.headline5,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the click event for the specific word.
                                  print('You clicked on T&C');
                                  onLinkClicked(
                                      "https://tiarabytj.com/terms-conditions/");
                                  // Add your custom action here.
                                },
                            ),
                            TextSpan(
                              text: ' and ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: Theme.of(context).textTheme.headline5,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the click event for the specific word.
                                  print('You clicked on Privacy Policy');
                                  onLinkClicked(
                                      "https://tiarabytj.com/privacy-policy/");
                                  // Add your custom action here.
                                },
                            ),
                          ]))),
                      const SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (mounted) {
                              setState(() {
                                phone = _phoneNoController.text;
                                email = _emailController.text;
                                first_name = _firstNameController.text;
                                last_name = _lastNameController.text;
                                password = _passwordController.text;
                              });
                            }

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
                            bool isThereInternet =
                                await ApiService.checkInternetConnection(
                                    context);
                            if (isThereInternet) {
                              if (mounted) {
                                setState(() {
                                  isLoading = true;
                                });
                              }

                              // final response =
                              //     await ApiService.createCustomer(data);

                              await ApiService.signupCustomer({
                                //   "phone": phone,
                                "first_name": first_name,
                                "last_name": last_name,
                                "email": email,
                                "username": username,
                                "password": password
                              });

                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }

                              // if (response.statusCode == 201) {
                              //   String body = response.body;
                              //   // List<Map<String, dynamic>> data =
                              //   //     <Map<String, dynamic>>[];
                              //   Map<String, dynamic> data = <String, dynamic>{};
                              //   try {
                              //     data = jsonDecode(body);
                              //     print("JSON DECODE DATA $data");
                              //   } catch (e) {
                              //     print('Error decoding: $e');
                              //   }

                              // customerProvider.addCustomerData(data);

                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => LoginPage(
                              //           isComeFromCart: false,
                              //         ),
                              //       ));
                              // } else {
                              //   String body = response.body;
                              //   Map<String, dynamic> data = <String, dynamic>{};

                              //   try {
                              //     data = jsonDecode(body);

                              //     if (mounted) {
                              //       setState(() {
                              //         isRegisterUnSuccessful = true;
                              //         errorMsg = data["message"];
                              //       });
                              //     }
                              //     print("JSON DECODE DATA $data");
                              //   } catch (e) {
                              //     print('Error decoding: $e');
                              //   }
                              // }
                            }
                          }
                          // print("$phoneNo $email $firstName $lastName");
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 65.0,
                            decoration: BoxDecoration(
                                color: const Color(0xffCC868A),
                                borderRadius: BorderRadius.circular(15.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                            child: Center(
                              child: isLoading
                                  ?  Container(
                                     padding: EdgeInsets.symmetric(vertical: 5.0),
                                        width: (deviceWidth / 28),
                                        height:(deviceWidth / 28) + 5 ,
                                        child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                        backgroundColor: Color(0xffCC868A),
                                      ),
                                    )
                                  :  Text(
                                      "Sign up",
                                     style: Theme.of(context).textTheme.button,
                                    ),
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Already have an account?',
                                  style: Theme.of(context).textTheme.subtitle1,
                                  children: <TextSpan>[
                            TextSpan(
                              text: ' Login',
                              style: Theme.of(context).textTheme.headline5,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginPage(
                                      isComeFromCart: false,
                                    ),
                                  ));
                                },
                            ),
                          ]))),
                    ]),
              ))),
        ));
  }
}
