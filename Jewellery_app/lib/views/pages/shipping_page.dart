import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:jwelery_app/views/widgets/shipping_form.dart';
import 'package:provider/provider.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedCountry = "India";

  String selectedCountry2 = "India";

  List<String> countryOptions = [
    "India",
    "United Kingdom",
    "Australia",
    "United Arab Emirates",
    "Singapore"
  ];

  String selectedState = "Maharashtra";

  String selectedState2 = "Maharashtra";

  List<String> stateOptions = [
    "Andaman and Nicobar Islands",
    "Adhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];

  List<String> countryCodeOptions = ["+91", "+92"];

  String selectedCountryCodeOption = "+91";

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _addressController1 = TextEditingController();

  final TextEditingController _addressController2 = TextEditingController();

  final TextEditingController _phoneNoController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _pinNoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  //shipping address

  final TextEditingController _firstNameController2 = TextEditingController();

  final TextEditingController _lastNameController2 = TextEditingController();

  final TextEditingController _companyNameController2 = TextEditingController();

  final TextEditingController _address2Controller1 = TextEditingController();

  final TextEditingController _address2Controller2 = TextEditingController();

  final TextEditingController _cityController2 = TextEditingController();

  final TextEditingController _pinNoController2 = TextEditingController();

  final TextEditingController _phoneNoController2 = TextEditingController();

  bool differentShippingAddress = false;

  bool isUpdateLoading = false;

  bool creatingOrder = false;

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // print("${customerProvider.customerData[0]["id"]}");
    // print("CUSTOMER DATA LIST");
    // for(int i = 0; i < customerProvider.customerData.length; i++){
    //   print(customerProvider.customerData[0].keys);
    // }

    late Map<String, String> billingData;
    late Map<String, String> shippingData;

    int customerId = customerProvider.customerData[0]["id"];

    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          Strings.app_logo,
          width: 150,
          height: 80,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShippingForm(
                        formHeading: "Fill Billing Details",
                        firstNameController2: _firstNameController,
                        lastNameController2: _lastNameController,
                        companyNameController2: _companyNameController,
                        address2Controller1: _addressController1,
                        address2Controller2: _addressController2,
                        cityController2: _cityController,
                        pinNoController2: _pinNoController,
                        phoneNoController2: _phoneNoController,
                        countryOptions: countryOptions,
                        stateOptions: stateOptions,
                        countryCodeOptions: countryCodeOptions,
                      ),
                      // TextFormField(
                      //   controller: _firstNameController,
                      //   keyboardType: TextInputType.name,
                      //   validator: (value) {
                      //     return ValidationHelper.nullOrEmptyString(value);
                      //   },
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "First name*",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // TextFormField(
                      //   controller: _lastNameController,
                      //   keyboardType: TextInputType.name,
                      //   validator: (value) {
                      //     return ValidationHelper.nullOrEmptyString(value);
                      //   },
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "Last name*",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // TextFormField(
                      //   controller: _companyNameController,
                      //   keyboardType: TextInputType.name,
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "Company name (optional)",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 10.0),
                      //   child: Text(
                      //     "Country / Region",
                      //     style: TextStyle(fontSize: 16.0),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 5.0,
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.only(right: 10.0, left: 5.0),
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(20.0)),
                      //       border: Border.all(
                      //           color: const Color.fromARGB(255, 103, 103, 103),
                      //           style: BorderStyle.solid)),
                      //   // color: Colors.red,
                      //   child: DropdownButton(
                      //       itemHeight: kMinInteractiveDimension + 15,
                      //       isExpanded: true,
                      //       padding: const EdgeInsets.only(left: 10.0),
                      //       value: selectedCountry,
                      //       icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      //       items: countryOptions.map((String option) {
                      //         return DropdownMenuItem(
                      //           value: option,
                      //           child: Text(option),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           selectedCountry = newValue!;
                      //         });
                      //       }),
                      // ),
                      // const SizedBox(
                      //   height: 20.0,
                      // ),
                      // TextFormField(
                      //   controller: _addressController1,
                      //   keyboardType: TextInputType.streetAddress,
                      //   validator: (value) {
                      //     return ValidationHelper.nullOrEmptyString(value);
                      //   },
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "Street address*",
                      //     hintText: "House umber and street name",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10.0,
                      // ),
                      // TextFormField(
                      //   controller: _addressController2,
                      //   keyboardType: TextInputType.name,
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     hintText: "Apartment, suite, unit, etc. (optional)",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // TextFormField(
                      //   controller: _cityController,
                      //   keyboardType: TextInputType.name,
                      //   validator: (value) {
                      //     return ValidationHelper.nullOrEmptyString(value);
                      //   },
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "Town / City *",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 10.0),
                      //   child: Text(
                      //     "State *",
                      //     style: TextStyle(fontSize: 16.0),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 5.0,
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.only(right: 10.0, left: 5.0),
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(20.0)),
                      //       border: Border.all(
                      //           color: const Color.fromARGB(255, 103, 103, 103),
                      //           style: BorderStyle.solid)),
                      //   // color: Colors.red,
                      //   child: DropdownButton(
                      //       itemHeight: kMinInteractiveDimension + 15,
                      //       isExpanded: true,
                      //       padding: const EdgeInsets.only(left: 10.0),
                      //       value: selectedState,
                      //       icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      //       items: stateOptions.map((String option) {
                      //         return DropdownMenuItem(
                      //           value: option,
                      //           child: Text(option),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           selectedState = newValue!;
                      //         });
                      //       }),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // TextFormField(
                      //   controller: _pinNoController,
                      //   keyboardType: TextInputType.number,
                      //   validator: (value) {
                      //     return ValidationHelper.isPincodeValid(value);
                      //   },
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "PIN code *",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      // SizedBox(
                      //   height: 75.0,
                      //   child: TextFormField(
                      //     controller: _phoneNoController,
                      //     keyboardType: TextInputType.phone,
                      //     validator: (value) {
                      //       return ValidationHelper.isPhoneNoValid(value);
                      //     },
                      //     decoration: InputDecoration(
                      //         border: const OutlineInputBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20.0))),
                      //         prefix: DropdownButton(
                      //             value: selectedCountryCodeOption,
                      //             icon: const Icon(
                      //                 Icons.keyboard_arrow_down_rounded),
                      //             items:
                      //                 countryCodeOptions.map((String option) {
                      //               return DropdownMenuItem(
                      //                 value: option,
                      //                 child: Text(option),
                      //               );
                      //             }).toList(),
                      //             onChanged: (String? newValue) {
                      //               setState(() {
                      //                 selectedCountryCodeOption = newValue!;
                      //               });
                      //             }),
                      //         labelText: "Mobile number*"),
                      //     maxLines: 1,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),

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
                      const Text(
                        "Products will delievered to billing address",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: differentShippingAddress,
                            activeColor: const Color(0xffCC868A),
                            onChanged: (value) {
                              setState(() {
                                differentShippingAddress = value!;
                              });
                            },
                          ),
                          const Text(
                            "Ship to a different address?",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      differentShippingAddress == true
                          ?
                          //      Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const Text(
                          //             "Fill Shipping Details",
                          //             style: TextStyle(
                          //                 fontSize: 20.0,
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //           const SizedBox(
                          //             height: 20.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _firstNameController2,
                          //             keyboardType: TextInputType.name,
                          //             validator: (value) {
                          //               return ValidationHelper.nullOrEmptyString(
                          //                   value);
                          //             },
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               labelText: "First name*",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 30.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _lastNameController2,
                          //             keyboardType: TextInputType.name,
                          //             validator: (value) {
                          //               return ValidationHelper.nullOrEmptyString(
                          //                   value);
                          //             },
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               labelText: "Last name*",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 30.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _companyNameController2,
                          //             keyboardType: TextInputType.name,
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               labelText: "Company name (optional)",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 30.0,
                          //           ),
                          //           const Padding(
                          //             padding: EdgeInsets.only(left: 10.0),
                          //             child: Text(
                          //               "Country / Region",
                          //               style: TextStyle(fontSize: 16.0),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 5.0,
                          //           ),
                          //           Container(
                          //             padding:
                          //                 const EdgeInsets.only(right: 10.0, left: 5.0),
                          //             width: MediaQuery.of(context).size.width,
                          //             decoration: BoxDecoration(
                          //                 borderRadius: const BorderRadius.all(
                          //                     Radius.circular(20.0)),
                          //                 border: Border.all(
                          //                     color: const Color.fromARGB(
                          //                         255, 103, 103, 103),
                          //                     style: BorderStyle.solid)),
                          //             // color: Colors.red,
                          //             child: DropdownButton(
                          //                 itemHeight: kMinInteractiveDimension + 15,
                          //                 isExpanded: true,
                          //                 padding: const EdgeInsets.only(left: 10.0),
                          //                 value: selectedCountry2,
                          //                 icon: const Icon(
                          //                     Icons.keyboard_arrow_down_rounded),
                          //                 items:
                          //                     countryOptions.map((String option) {
                          //                   return DropdownMenuItem(
                          //                     value: option,
                          //                     child: Text(option),
                          //                   );
                          //                 }).toList(),
                          //                 onChanged: (String? newValue) {
                          //                   setState(() {
                          //                     selectedCountry2 = newValue!;
                          //                   });
                          //                 }),
                          //           ),
                          //           const SizedBox(
                          //             height: 20.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _address2Controller1,
                          //             keyboardType: TextInputType.streetAddress,
                          //             validator: (value) {
                          //               return ValidationHelper.nullOrEmptyString(
                          //                   value);
                          //             },
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               labelText: "Street address*",
                          //               hintText: "House umber and street name",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 10.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _address2Controller2,
                          //             keyboardType: TextInputType.name,
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               hintText:
                          //                   "Apartment, suite, unit, etc. (optional)",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 30.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _cityController2,
                          //             keyboardType: TextInputType.name,
                          //             validator: (value) {
                          //               return ValidationHelper.nullOrEmptyString(
                          //                   value);
                          //             },
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               labelText: "Town / City *",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 30.0,
                          //           ),
                          //           const Padding(
                          //             padding: EdgeInsets.only(left: 10.0),
                          //             child: Text(
                          //               "State *",
                          //               style: TextStyle(fontSize: 16.0),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 5.0,
                          //           ),
                          //           Container(
                          //             padding:
                          //                 const EdgeInsets.only(right: 10.0, left: 5.0),
                          //             width: MediaQuery.of(context).size.width,
                          //             decoration: BoxDecoration(
                          //                 borderRadius: const BorderRadius.all(
                          //                     Radius.circular(20.0)),
                          //                 border: Border.all(
                          //                     color: const Color.fromARGB(
                          //                         255, 103, 103, 103),
                          //                     style: BorderStyle.solid)),
                          //             // color: Colors.red,
                          //             child: DropdownButton(
                          //                 itemHeight: kMinInteractiveDimension + 15,
                          //                 isExpanded: true,
                          //                 padding: const EdgeInsets.only(left: 10.0),
                          //                 value: selectedState2,
                          //                 icon: const Icon(
                          //                     Icons.keyboard_arrow_down_rounded),
                          //                 items: stateOptions.map((String option) {
                          //                   return DropdownMenuItem(
                          //                     value: option,
                          //                     child: Text(option),
                          //                   );
                          //                 }).toList(),
                          //                 onChanged: (String? newValue) {
                          //                   setState(() {
                          //                     selectedState2 = newValue!;
                          //                   });
                          //                 }),
                          //           ),
                          //           const SizedBox(
                          //             height: 30.0,
                          //           ),
                          //           TextFormField(
                          //             controller: _pinNoController2,
                          //             keyboardType: TextInputType.number,
                          //             validator: (value) {
                          //               return ValidationHelper.isPincodeValid(
                          //                   value);
                          //             },
                          //             decoration: const InputDecoration(
                          //               // errorText: ,
                          //               labelText: "PIN code *",
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(20.0))),
                          //             ),
                          //           ),
                          //           const SizedBox(height: 30.0,),
                          //           SizedBox(
                          //   height: 75.0,
                          //   child: TextFormField(
                          //     controller: _phoneNoController2,
                          //     keyboardType: TextInputType.phone,
                          //     validator: (value) {
                          //       return ValidationHelper.isPhoneNoValid(value);
                          //     },
                          //     decoration: InputDecoration(
                          //         border: const OutlineInputBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(20.0))),
                          //         prefix: DropdownButton(
                          //             value: selectedCountryCodeOption,
                          //             icon: const Icon(
                          //                 Icons.keyboard_arrow_down_rounded),
                          //             items:
                          //                 countryCodeOptions.map((String option) {
                          //               return DropdownMenuItem(
                          //                 value: option,
                          //                 child: Text(option),
                          //               );
                          //             }).toList(),
                          //             onChanged: (String? newValue) {
                          //               setState(() {
                          //                 selectedCountryCodeOption = newValue!;
                          //               });
                          //             }),
                          //         labelText: "Mobile number*"),
                          //     maxLines: 1,
                          //   ),
                          // ),

                          //         ],
                          //       )
                          ShippingForm(
                              formHeading: "Fill Shipping Details",
                              firstNameController2: _firstNameController2,
                              lastNameController2: _lastNameController2,
                              companyNameController2: _companyNameController2,
                              address2Controller1: _address2Controller1,
                              address2Controller2: _address2Controller2,
                              cityController2: _cityController2,
                              pinNoController2: _pinNoController2,
                              phoneNoController2: _phoneNoController2,
                              countryOptions: countryOptions,
                              stateOptions: stateOptions,
                              countryCodeOptions: countryCodeOptions,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            billingData = {
                              "first_name": _firstNameController.text,
                              "last_name": _lastNameController.text,
                              "company": _companyNameController.text,
                              "country": selectedCountry,
                              "address_1": _addressController1.text,
                              "address_2": _addressController2.text,
                              "city": _cityController.text,
                              "state": selectedState,
                              "email": _emailController.text,
                              "phone": _phoneNoController.text,
                              "postcode": _pinNoController.text
                            };

                            differentShippingAddress
                                ? shippingData = {
                                    "first_name": _firstNameController2.text,
                                    "last_name": _lastNameController2.text,
                                    "company": _companyNameController2.text,
                                    "address_1": _address2Controller1.text,
                                    "address_2": _address2Controller2.text,
                                    "city": _cityController2.text,
                                    "postcode": _pinNoController2.text,
                                    "country": selectedCountry2,
                                    "state": selectedState2,
                                    "phone": _phoneNoController2.text
                                  }
                                : shippingData = billingData;

                            setState(() {
                              isUpdateLoading = true;
                            });

                            await ApiService.updateCustomer(
                                customerId,
                                billingData,
                                shippingData);

                            setState(() {
                              isUpdateLoading = false;
                            });
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
                              child: isUpdateLoading
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
                                      "CONTINUE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                            )),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {

                            billingData = {
                              "first_name": _firstNameController.text,
                              "last_name": _lastNameController.text,
                              "company": _companyNameController.text,
                              "country": selectedCountry,
                              "address_1": _addressController1.text,
                              "address_2": _addressController2.text,
                              "city": _cityController.text,
                              "state": selectedState,
                              "email": _emailController.text,
                              "phone": _phoneNoController.text,
                              "postcode": _pinNoController.text
                            };

                            differentShippingAddress
                                ? shippingData = {
                                    "first_name": _firstNameController2.text,
                                    "last_name": _lastNameController2.text,
                                    "company": _companyNameController2.text,
                                    "address_1": _address2Controller1.text,
                                    "address_2": _address2Controller2.text,
                                    "city": _cityController2.text,
                                    "postcode": _pinNoController2.text,
                                    "country": selectedCountry2,
                                    "state": selectedState2,
                                    "phone": _phoneNoController2.text
                                  }
                                : shippingData = billingData;

                            List<Map<String, dynamic>> productData =
                                <Map<String, dynamic>>[];

                            final cartList = cartProvider.cart;

                            for (int i = 0; i < cartList.length; i++) {
                              productData.add({
                                "name": cartList[i].productName ?? "Jewellery",
                                "product_id": cartList[i].cartProductid,

                                "quantity": cartList[i].quantity,

                                // "subtotal": cartProvider.calculateTotalPrice(),

                                // "total": cartProvider.calculateTotalPrice(),

                                "sku": cartList[i].sku,
                                "price": cartList[i].price,
                                "image": {
                                  "id": cartList[i].imageId,
                                  "src": cartList[i].imageUrl
                                },
                                "parent_name": ""
                           
                              });
                            }

                            print("STORED PRODUCT $productData");

                            setState(() {
                              creatingOrder = true;
                            });

                            await ApiService.createOrder(
                                billingData, shippingData, productData, customerId, cartProvider.calculateTotalPrice());

                            setState(() {
                              creatingOrder = false;
                            });
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
                              child: creatingOrder
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
                                      "Create order",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                            )),
                      ),
                    ],
                  )))),
    );
  }
}
