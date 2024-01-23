import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:provider/provider.dart';

class ShippingPage extends StatefulWidget {
  ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedOption = "India";

  List<String> options = [
    "India",
    "United Kingdom",
    "Australia",
    "United Arab Emirates",
    "Singapore"
  ];

  String selectedState = "Maharashtra";

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

  



  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _addressController1 = TextEditingController();

  final TextEditingController _addressController2 = TextEditingController();
  
  final TextEditingController _phoneNoController = TextEditingController();
  
  final TextEditingController _cityController = TextEditingController();
  
  final TextEditingController _pinNoController = TextEditingController();
  
  final TextEditingController _emailController = TextEditingController();
  
  bool differentShippingAddress = false;

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
    
    // print("${customerProvider.customerData[0]["id"]}");
    // print("CUSTOMER DATA LIST");
    // for(int i = 0; i < customerProvider.customerData.length; i++){
    //   print(customerProvider.customerData[0].keys);
    // }
    
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
                      Text(
                        "Billing details",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          return ValidationHelper.nullOrEmptyString(value);
                        },
                        decoration: const InputDecoration(
                          // errorText: ,
                          labelText: "First name*",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
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
                          // errorText: ,
                          labelText: "Last name*",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: _companyNameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          // errorText: ,
                          labelText: "Company name (optional)",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Country / Region",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0, left: 5.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                              color: Color.fromARGB(255, 103, 103, 103), style: BorderStyle.solid)),
                        // color: Colors.red,
                        child: DropdownButton(
                            itemHeight: kMinInteractiveDimension + 15,
                            isExpanded: true,
                            padding: EdgeInsets.only(left: 10.0),
                            value: selectedOption,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
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
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _addressController1,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          return ValidationHelper.nullOrEmptyString(value);
                        },
                        decoration: const InputDecoration(
                          // errorText: ,
                          labelText: "Street address*",
                          hintText: "House umber and street name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _addressController2,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          // errorText: ,
                          hintText: "Apartment, suite, unit, etc. (optional)",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: _cityController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          return ValidationHelper.nullOrEmptyString(value);
                        },
                        decoration: const InputDecoration(
                          // errorText: ,
                          labelText: "Town / City *",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "State *",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0, left: 5.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                              color: Color.fromARGB(255, 103, 103, 103), style: BorderStyle.solid)),
                        // color: Colors.red,
                        child: DropdownButton(
                            itemHeight: kMinInteractiveDimension + 15,
                            isExpanded: true,
                            padding: EdgeInsets.only(left: 10.0),
                            value: selectedState,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            items: stateOptions.map((String option) {
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
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: _pinNoController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return ValidationHelper.nullOrEmptyString(value);
                        },
                        decoration: const InputDecoration(
                          // errorText: ,
                          labelText: "PIN code *",
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
                          controller: _phoneNoController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            return ValidationHelper.isPhoneNoValid(value);
                          },
                          decoration: InputDecoration(
                             
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

                      Row(
                        children: [
                          Checkbox(value: differentShippingAddress, 
                          onChanged: (value) {
                            setState(() {
                              differentShippingAddress = !differentShippingAddress;
                            });

                          },),
                       
                          Text("Ship to a different address?", style: TextStyle(fontSize: 16.0),),
                        ],
                      ),


                      const SizedBox(
                        height: 30.0,
                      ),

                      // differentShippingAddress == true ?

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //   "Shipping details",
                      //   style: TextStyle(
                      //       fontSize: 20.0, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
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
                      // Padding(
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
                      //   padding: EdgeInsets.only(right: 10.0, left: 5.0),
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0)),
                      //     border: Border.all(
                      //         color: Color.fromARGB(255, 103, 103, 103), style: BorderStyle.solid)),
                      //   // color: Colors.red,
                      //   child: DropdownButton(
                      //       itemHeight: kMinInteractiveDimension + 15,
                      //       isExpanded: true,
                      //       padding: EdgeInsets.only(left: 10.0),
                      //       value: selectedOption,
                      //       icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      //       items: options.map((String option) {
                      //         return DropdownMenuItem(
                      //           value: option,
                      //           child: Text(option),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           selectedOption = newValue!;
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
                      // Padding(
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
                      //   padding: EdgeInsets.only(right: 10.0, left: 5.0),
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0)),
                      //     border: Border.all(
                      //         color: Color.fromARGB(255, 103, 103, 103), style: BorderStyle.solid)),
                      //   // color: Colors.red,
                      //   child: DropdownButton(
                      //       itemHeight: kMinInteractiveDimension + 15,
                      //       isExpanded: true,
                      //       padding: EdgeInsets.only(left: 10.0),
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
                      //           selectedOption = newValue!;
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
                      //     return ValidationHelper.nullOrEmptyString(value);
                      //   },
                      //   decoration: const InputDecoration(
                      //     // errorText: ,
                      //     labelText: "PIN code *",
                      //     border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20.0))),
                      //   ),
                      // ),

                      //   ],
                      // )

                      // :

                      // SizedBox(),

                      const SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> customerData = {
                              "firstName" : _firstNameController.text,
                              "lastName" : _lastNameController.text,
                              "companyName" : _firstNameController.text,
                              "country" : _firstNameController.text,
                              "address1" : _firstNameController.text,
                              "address2" : _firstNameController.text,
                              "city" : _firstNameController.text,
                              "stat" : _firstNameController.text,
                              "firstName" : _firstNameController.text,

                              
                            };
                          

                          

                          await ApiService.updateCustomer(customerProvider.customerData[0]["id"], );
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
                                child: 
                                // isLoading
                                //     ? const SizedBox(
                                //         width: 20.0,
                                //         height: 20.0,
                                //         child: CircularProgressIndicator(
                                //           color: Colors.white,
                                //           strokeWidth: 2.0,
                                //           backgroundColor: Color(0xffCC868A),
                                //         ),
                                //       )
                                //     :
                                     const Text(
                                        "CONTINUE",
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
