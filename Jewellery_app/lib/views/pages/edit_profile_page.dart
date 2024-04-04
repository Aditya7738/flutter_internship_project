import 'dart:convert';

import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/profile_provider.dart';
import 'package:Tiara_by_TJ/views/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _anniversarydateController = TextEditingController();
  TextEditingController _spousebirthdateController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneNoController = TextEditingController();

  final TextEditingController _pinNoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  List<String> options = ["+91", "+92"];

  String selectedOption = "+91";

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  bool isUpdating = false;

  Future<String> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945),
        lastDate: DateTime(2025));

    if (picked != null && picked != selectedDate) {
      print(" DATE ${picked.toLocal().toString()}");
      return "${picked.day}/${picked.month}/${picked.year}";
    } else {
      return "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    customerProvider.customerData.forEach((element) {
      print("profile customerData $element");
    });

    if (customerProvider.customerData[0].containsKey("first_name")) {
      _firstNameController.text =
          customerProvider.customerData[0]["first_name"];
    }

    if (customerProvider.customerData[0].containsKey("last_name")) {
      _lastNameController.text = customerProvider.customerData[0]["last_name"];
    }

    if (customerProvider.customerData[0].containsKey("email")) {
      _emailController.text = customerProvider.customerData[0]["email"];
    }

    if (customerProvider.customerData[0].containsKey("mobile_no")) {
      _phoneNoController.text = customerProvider.customerData[0]["mobile_no"];
    }

    if (customerProvider.customerData[0].containsKey("fulladdress")) {
      _addressController.text = customerProvider.customerData[0]["fulladdress"];
    }
    if (customerProvider.customerData[0].containsKey("pincode")) {
      _pinNoController.text = customerProvider.customerData[0]["pincode"];
    }

    if (customerProvider.customerData[0].containsKey("birthday")) {
      _birthdateController.text = customerProvider.customerData[0]["birthday"];
    }

    if (customerProvider.customerData[0].containsKey("anniversary")) {
      _anniversarydateController.text =
          customerProvider.customerData[0]["anniversary"];
    }

    if (customerProvider.customerData[0].containsKey("spouse_birthday")) {
      _spousebirthdateController.text =
          customerProvider.customerData[0]["spouse_birthday"];
    }
  }

  bool isPhoneValid = true;

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    int customerId = customerProvider.customerData[0]["id"];
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(child:
              Consumer<ProfileProvider>(builder: (context, value, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: TextFormField(
                      style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        return ValidationHelper.nullOrEmptyString(value);
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                             fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                            color: Colors.red),
                        labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                        // errorText: ,
                        labelText: "First Name*",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return ValidationHelper.nullOrEmptyString(value);
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                           fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      labelText: "Last Name*",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: isPhoneValid ?
                    deviceWidth > 600 ? 85 : 60.0
                     :
                     deviceWidth > 600 ? 130 : 90.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      keyboardType: TextInputType.phone,
                      controller: _phoneNoController,
                      validator: (value) {
                        setState(() {
                          isPhoneValid =
                              ValidationHelper.isPhoneNoValidbool(value);
                        });
                        return ValidationHelper.isPhoneNoValid(value);
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                              color: Colors.red),
                          labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                          // suffix: GestureDetector(
                          //     onTap: () {
                          //       value.setPhoneNoVerified(true);
                          //     },
                          //     child: value.phoneNoVerified
                          //         ? Container(
                          //             width: 100.0,
                          //             height: 40.0,
                          //             decoration: BoxDecoration(
                          //                 color: const Color(0xffCC868A),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10.0)),
                          //             padding: const EdgeInsets.symmetric(
                          //                 vertical: 10.0, horizontal: 20.0),
                          //             child: const Center(
                          //               child: Text(
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
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
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
                    style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                    minLines: 2,
                    maxLines: 3,
                    controller: _addressController,
                    validator: (value) {
                      return ValidationHelper.isFullAddress(value);
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                           fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      labelText: "Address*",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                    controller: _pinNoController,
                    validator: (value) {
                      return ValidationHelper.isPincodeValid(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                           fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      labelText: "Pin code*",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                    controller: _birthdateController,
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      _birthdateController.text = await _selectedDate(context);
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                           fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      suffixIcon: SuffixIcon(icon: Icons.calendar_month),
                      labelText: "Birthday (Optional)",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      _anniversarydateController.text =
                          await _selectedDate(context);
                    },
                    controller: _anniversarydateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                           fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      suffixIcon: SuffixIcon(icon: Icons.calendar_month),
                      labelText: "Anniversary (Optional)",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      _spousebirthdateController.text =
                          await _selectedDate(context);
                    },
                    controller: _spousebirthdateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                           fontSize: deviceWidth > 600 ? (deviceWidth / 37) + 1.5 : (deviceWidth / 33) + 1.5,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                      suffixIcon: SuffixIcon(icon: Icons.calendar_month),
                      labelText: "Spouse Birthday (Optional)",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    maxLines: 1,
                  ),

                  const SizedBox(
                    height: 50.0,
                  ),

                  // Center(
                  //   child: Text("*By clicking on Save chage, you accept our"),

                  // ),

                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> updatedData = {
                          "email": _emailController.text,
                          "first_name": _firstNameController.text,
                          "last_name": _lastNameController.text,
                          "mobile_no": _phoneNoController.text,
                          "fulladdress": _addressController.text,
                          "pincode": _pinNoController.text,
                          "birthday": _birthdateController.text,
                          "anniversary": _anniversarydateController.text,
                          "spouse_birthday": _spousebirthdateController.text,
                        };

                        // if (_phoneNoController.text != "") {
                        // } else if (_phoneNoController.text != "") {
                        // } else if (_addressController.text != "") {
                        // } else if (_pinNoController.text != "") {
                        // } else if (_birthdateController.text!) {}

                        bool isThereInternet =
                            await ApiService.checkInternetConnection(context);
                        if (isThereInternet) {
                          if (mounted) {
                            setState(() {
                              isUpdating = true;
                            });
                          }

                          final response =
                              await ApiService.updateCustomerProfile(
                                  customerId, updatedData);

                          if (response != null) {
                            if (response.statusCode == 200) {
                              List<Map<String, dynamic>> data =
                                  <Map<String, dynamic>>[];

                              String body =
                                  await response.stream.bytesToString();
                              print("update customer $body");

                              try {
                                data.add(jsonDecode(body));
                                print("${body.runtimeType}");
                                print("JSON DECODE DATA $data");

                                // customerProvider.addToFirst(data);
                                customerProvider.addMapToFirst(updatedData);

                                customerProvider.customerData
                                    .forEach((element) {
                                  print("after get customerData $element");
                                });

                                // if (customerProvider.customerData[0]
                                //     .containsKey("mobile_no")) {
                                //   print(
                                //       "mobile_no ${customerProvider.customerData[0]["mobile_no"]}");
                                // }

                                // if (customerProvider.customerData[0]
                                //     .containsKey("fulladdress")) {
                                //   print(
                                //       "fulladdress ${customerProvider.customerData[0]["fulladdress"]}");
                                // }
                                // if (customerProvider.customerData[0]
                                //     .containsKey("pincode")) {
                                //   print(
                                //       "pincode ${customerProvider.customerData[0]["pincode"]}");
                                // }
                              } catch (e) {
                                print('Error decoding: $e');
                              }

                              //  customerProvider.setCustomerData(data);

                              // Map<String, String> updatedData2 = {
                              //   "mobile_no": _phoneNoController.text,
                              //   "fulladdress": _addressController.text,
                              //   "pincode": _pinNoController.text,
                              //   "birthday": _birthdateController.text,
                              //   "anniversary": _anniversarydateController.text,
                              //   "spouse_birthday":
                              //       _spousebirthdateController.text,
                              // };

                              // customerProvider.addCustomerData(updatedData2);

                              // print(
                              //     "updated customerData list ${customerProvider.customerData[0]}");

                              Navigator.pop(context);
                            }
                          }
                          if (mounted) {
                            setState(() {
                              isUpdating = false;
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xffCC868A),
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Center(
                          child: isUpdating
                              ? const SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                    backgroundColor: Color(0xffCC868A),
                                  ),
                                )
                              : Text(
                                  "SAVE CHANGES",
                                  style: Fontsizes.buttonTextStyle
                                ),
                        )),
                  ),
                ],
              ),
            );
          })),
        ));
  }
}
