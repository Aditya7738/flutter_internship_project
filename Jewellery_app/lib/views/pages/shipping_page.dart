import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/customer_provider.dart';
import 'package:jwelery_app/views/pages/payment_page.dart';
import 'package:jwelery_app/views/pages/payment_successful.dart';
import 'package:jwelery_app/views/widgets/shipping_form.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  final _formKey = GlobalKey<FormState>();

  // Razorpay _razorpay = Razorpay();
  late String order_id;
  late String payableAmount;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController.text = "abc";
    _firstNameController2.text = "abc";
    _lastNameController.text = "def";
    _lastNameController2.text = "def";
    _addressController1.text = "ghi";
    _addressController2.text = "ghi";
    _address2Controller1.text = "jkl";
    _address2Controller2.text = "jkl";
    _cityController.text = "mno";
    _cityController2.text = "mno";
    _pinNoController.text = "466432";
    _pinNoController2.text = "466432";
    _phoneNoController.text = "2638746434";
    _emailController.text = "eg@gmail.com";

    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   //  Toast.show("Payment successful ${response.paymentId}", duration: 2);
  //   //print("Payment successful ${response.paymentId}");
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => PaymentSucessfulPage(),
  //   ));
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Toast.show("Payment failed ${response.message}", duration: 2);
  //   print("Payment failed ${response.message}");
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Toast.show("External wallet ${response.walletName}", duration: 2);
  //   print("External wallet ${response.walletName}");
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _razorpay.clear();
  // }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final customerData = customerProvider.customerData[0];

    String productName = "";
    for (int i = 0; i < cartProvider.cart.length; i++) {
      productName += cartProvider.cart[i].productName! + ", ";
    }

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
        surfaceTintColor: Colors.white,
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

                          //customer_id = 230999
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
                                customerId, billingData, shippingData);

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
                                "quantity": int.parse(cartList[i].quantity!),
                                "sku": cartList[i].sku,
                                "price": int.parse(cartList[i].price!),
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
                                billingData,
                                shippingData,
                                productData,
                                customerId,
                                cartProvider.calculateTotalPrice());

                                

                            // final response =
                            //     await ApiService.createRazorpayOrder();

                            

                            // if (response != null) {
                            //   String body =
                            //       await response.stream.bytesToString();
                            //   print("Payment body $body");

                            //   try {
                            //     data.add(jsonDecode(body));
                            //     print("${body.runtimeType}");
                            //     print("JSON DECODE DATA $data");
                            //   } catch (e) {
                            //     print('Error decoding: $e');
                            //   }

                              // var options = {
                              //   'key': ApiService
                              //               .woocommerce_razorpay_settings[0]
                              //           ["data"]
                              //       ["woocommerce_razorpay_settings"]["key_id"],
                              //   //'amount': (cartProvider.calculateTotalPrice() * 100).toString(), //in the smallest currency sub-unit.
                              //   'amount': '100',
                              //   'name': 'Tiara by TJ',
                              //   'order_id': data[0][
                              //       "id"], // Generate order_id using Orders API
                              //   'description': productName,
                              //   'timeout': 60, // in seconds
                              //   'prefill': {
                              //     'contact': customerData["billing"]["phone"],
                              //     'email': customerData["email"]
                              //   }
                              // };

                              // print("Payment $options");

                              // try {
                              //   final response = _razorpay.open(options);
                              // } catch (e) {
                              //   debugPrint(e.toString());
                              // }

                              List<Map<String, dynamic>> data =
                                await uiCreateRazorpayOrder();
                            

                            setState(() {
                              creatingOrder = false;
                            });

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PaymentPage(orderId: data[0]["id"]),
                            ));
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

  Future<List<Map<String, dynamic>>> uiCreateRazorpayOrder() async {
    List<Map<String, dynamic>> data = <Map<String, dynamic>>[];
    final response = await ApiService.createRazorpayOrder();

    if (response != null) {
      String body = await response.stream.bytesToString();
      print("Payment body $body");

      try {
        print("${body.runtimeType}");
        print("JSON DECODE DATA $data");
        data.add(jsonDecode(body));
        return data;
      } catch (e) {
        print('Error decoding: $e');
        return <Map<String, dynamic>>[];
      }
    }
    return <Map<String, dynamic>>[];
  }

   
}
