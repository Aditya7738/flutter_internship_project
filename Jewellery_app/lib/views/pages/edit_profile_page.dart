import 'dart:convert';

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

  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneNoController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

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
      // if (mounted) {
      // setState(() {
      //   print("CALENDAR PRESSED");
      //   // selectedDate = picked;

      // });
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
    // _phoneNoController.text = customerProvider.customerData[0]["mobile_no"];
    // _addressController.text = customerProvider.customerData[0]["fulladdress"];
    if (customerProvider.customerData[0].containsKey("fulladdress")) {
      _addressController.text = customerProvider.customerData[0]["fulladdress"];
    }
    if (customerProvider.customerData[0].containsKey("pincode")) {
      _pinNoController.text = customerProvider.customerData[0]["pincode"];
    }

    //_pinNoController.text = customerProvider.customerData[0]["pincode"];
    if (customerProvider.customerData[0].containsKey("birthday")) {
      _birthdateController.text = customerProvider.customerData[0]["birthday"];
    }
    // _birthdateController.text = customerProvider.customerData[0]["birthday"];
    if (customerProvider.customerData[0].containsKey("anniversary")) {
      _anniversarydateController.text =
          customerProvider.customerData[0]["anniversary"];
    }

    // _anniversarydateController.text =
    //     customerProvider.customerData[0]["anniversary"];
    if (customerProvider.customerData[0].containsKey("spouse_birthday")) {
      _spousebirthdateController.text =
          customerProvider.customerData[0]["spouse_birthday"];
    }
    // _spousebirthdateController.text =
    //     customerProvider.customerData[0]["spouse_birthday"];
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    int customerId = customerProvider.customerData[0]["id"];
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
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        return ValidationHelper.nullOrEmptyString(value);
                      },
                      decoration: const InputDecoration(
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
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return ValidationHelper.nullOrEmptyString(value);
                    },
                    decoration: const InputDecoration(
                      labelText: "Last Name*",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 75.0,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNoController,
                      validator: (value) {
                        return ValidationHelper.isPhoneNoValid(value);
                      },
                      decoration: InputDecoration(
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

                  SizedBox(
                    height: 75.0,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        return ValidationHelper.isEmailValid(value);
                      },
                      decoration: InputDecoration(
                        //labelText: "Enter your email",
                        labelText: "Enter your email*",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        // suffix: GestureDetector(
                        //     onTap: () {
                        //       value.setEmailVerified(true);
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
                        //             padding: const EdgeInsets.only(bottom: 0.0),
                        //             child: Image.asset(
                        //               "assets/images/yes.png",
                        //               width: 30.0,
                        //               height: 25.0,
                        //             ),
                        //           )),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: (){}, child: Text("VERIFY")),

                  const SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    minLines: 2,
                    maxLines: 3,
                    controller: _addressController,
                    validator: (value) {
                      return ValidationHelper.isFullAddress(value);
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
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
                    controller: _pinNoController,
                    validator: (value) {
                      return ValidationHelper.isPincodeValid(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
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
                    controller: _birthdateController,
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      _birthdateController.text = await _selectedDate(context);
                    },
                    decoration: const InputDecoration(
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
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      _anniversarydateController.text =
                          await _selectedDate(context);
                    },
                    controller: _anniversarydateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
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
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      _spousebirthdateController.text =
                          await _selectedDate(context);
                    },
                    controller: _spousebirthdateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      suffixIcon: SuffixIcon(icon: Icons.calendar_month),
                      labelText: "Spouse Birthday (Optional)",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    maxLines: 1,
                  ),

                  const SizedBox(
                    height: 30.0,
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
                        };

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
                              print(body);

                              try {
                                data.add(jsonDecode(body));
                                print("${body.runtimeType}");
                                print("JSON DECODE DATA $data");
                              } catch (e) {
                                print('Error decoding: $e');
                              }

                              customerProvider.setCustomerData(data);

                              Map<String, String> updatedData2 = {
                                "mobile_no": _phoneNoController.text,
                                "fulladdress": _addressController.text,
                                "pincode": _pinNoController.text,
                                "birthday": _birthdateController.text,
                                "anniversary": _anniversarydateController.text,
                                "spouse_birthday":
                                    _spousebirthdateController.text,
                              };

                              customerProvider.addCustomerData(updatedData2);

                              print(
                                  "updated customerData list ${customerProvider.customerData[0]}");
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
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: const Color(0xffCC868A),
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                  "SAVE CHAGES",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
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
