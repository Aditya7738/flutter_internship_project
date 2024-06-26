import 'dart:convert';
import 'dart:ffi';

import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/views/pages/payment_page.dart';
import 'package:Tiara_by_TJ/views/pages/payment_successful.dart';
import 'package:Tiara_by_TJ/views/widgets/shipping_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final customerData = customerProvider.customerData[0];
    if (customerData.containsKey("first_name")) {
      _firstNameController.text = customerData["first_name"];
      _firstNameController2.text = customerData["first_name"];
    }

    if (customerData.containsKey("last_name")) {
      _lastNameController.text = customerData["last_name"];
      _lastNameController2.text = customerData["last_name"];
    }

    if (customerData.containsKey("email")) {
      _emailController.text = customerData["email"];
    }

    // if (customerData.containsKey("phone")) {

    // }

    // if (customerData.containsKey("postcode")) {

    // }

    if (customerData.containsKey("billing")) {
      _companyNameController.text = customerData["billing"]["company"];
      _companyNameController2.text = customerData["billing"]["company"];

      _addressController1.text = customerData["billing"]["address_1"];
      _addressController2.text = customerData["billing"]["address_1"];

      _address2Controller1.text = customerData["billing"]["address_2"];
      _address2Controller2.text = customerData["billing"]["address_2"];

      _cityController.text = customerData["billing"]["city"];
      _cityController2.text = customerData["billing"]["city"];

      _phoneNoController.text = customerData["billing"]["phone"];
      _phoneNoController2.text = customerData["billing"]["phone"];

      _pinNoController.text = customerData["billing"]["postcode"];
      _pinNoController2.text = customerData["billing"]["postcode"];
    }

    // _addressController1.text = "ghi";
    // _addressController2.text = "ghi";
    // _address2Controller1.text = "jkl";
    // _address2Controller2.text = "jkl";
    // _cityController.text = "mno";
    // _cityController2.text = "mno";
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context);

    String productName = "";
    for (int i = 0; i < cartProvider.cart.length; i++) {
      productName += cartProvider.cart[i].productName! + ", ";
    }

    late Map<String, String> billingData;
    late Map<String, String> shippingData;

    int customerId = customerProvider.customerData[0]["id"];

    double deviceWidth = MediaQuery.of(context).size.width;

    LayoutDesignProvider layoutDesignProvider =
        Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Image.network(
          Constants.app_logo,
          width: 150,
          height: 80,
        ),
      ),
      body: SingleChildScrollView(
          //phoneno, pincode not comming
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
                      TextFormField(
                        style: TextStyle(

                            // fontSize: (deviceWidth / 33) + 1.5,
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
                          labelText: "Enter your email*",
                          labelStyle: TextStyle(

                              // fontSize: (deviceWidth / 33) + 1.5,
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletTextFormInputFieldSize
                                  : Fontsizes.textFormInputFieldSize),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Products will delievered to billing address",
                        style: TextStyle(
                            fontSize: deviceWidth > 600
                                ? Fontsizes.tabletTextFormInputFieldSize
                                : Fontsizes.textFormInputFieldSize),
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.199,
                            child: Checkbox(
                              value: differentShippingAddress,
                              activeColor: const Color(0xffCC868A),
                              onChanged: (value) {
                                if (mounted) {
                                  setState(() {
                                    differentShippingAddress = value!;
                                  });
                                }
                              },
                            ),
                          ),
                          Text(
                            "Ship to a different address?",
                            style: TextStyle(
                                fontSize: deviceWidth > 600
                                    ? Fontsizes.tabletTextFormInputFieldSize
                                    : Fontsizes.textFormInputFieldSize),
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
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            List<Map<String, dynamic>> razorpayOrderData =
                                <Map<String, dynamic>>[];
                            bool isThereInternet =
                                await ApiService.checkInternetConnection(
                                    context);
                            if (isThereInternet) {
                              if (mounted) {
                                setState(() {
                                  creatingOrder = true;
                                });
                              }
                              billingData = {
                                "first_name": _firstNameController.text,
                                "last_name": _lastNameController.text,
                                "company": _companyNameController.text,
                                "address_1": _addressController1.text,
                                "address_2": _addressController2.text,
                                "city": _cityController.text,
                                "postcode": _pinNoController.text,
                                "country": selectedCountry,
                                "state": selectedState,
                                "email": _emailController.text,
                                "phone": _phoneNoController.text,
                              };

                              // Map<String, dynamic> customerBillingData = {
                              //   "company": _companyNameController.text,
                              //   "address_1": _addressController1.text,
                              //   "address_2": _addressController2.text,
                              //   "city": _cityController.text,
                              // };

                              customerProvider.addMapToBilling(billingData);

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

                              List<Map<String, dynamic>> lineItems =
                                  <Map<String, dynamic>>[];

                              final cartList = cartProvider.cart;

                              for (int i = 0; i < cartList.length; i++) {
                                lineItems.add({
                                  "name":
                                      cartList[i].productName ?? "Jewellery",
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

                              print("STORED PRODUCT $lineItems");

                              //do it after payment successful - redirect user to this page and modify this page where login, shipping ajd paymet will be on same page
                              orderProvider.setBillingData(billingData);
                              orderProvider.setShippingData(shippingData);
                              orderProvider.setCustomerId(customerId);
                              orderProvider.setLineItems(lineItems);
                              orderProvider.setCustomerId(customerId);
                              orderProvider.setPrice(
                                  cartProvider.isCouponApplied
                                      ? cartProvider.totalAfterCouponApplied
                                          .toString()
                                      : cartProvider
                                          .calculateTotalPrice()
                                          .toString());

                              await ApiService.updateCustomer(
                                  customerId, billingData, shippingData);

                              razorpayOrderData = await uiCreateRazorpayOrder();

                              // List<Map<String, dynamic>> cashFreeOrderData =
                              //     await uiCreateCashFreeOrder();

                              if (mounted) {
                                setState(() {
                                  creatingOrder = false;
                                });
                              }
                            }

                            // Map<String, String> impCashFreeData =
                            //     <String, String>{};

                            // if (cashFreeOrderData.isNotEmpty) {
                            //   impCashFreeData = {
                            //     "order_id": cashFreeOrderData[0]["order_id"],
                            //     "cf_order_id": cashFreeOrderData[0]
                            //         ["cf_order_id"],
                            //     "payment_session_id": cashFreeOrderData[0]
                            //         ["payment_session_id"],
                            //     "order_status": cashFreeOrderData[0]
                            //         ["order_status"],
                            //   };
                            // }

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                orderId: razorpayOrderData[0]["id"],
                                fromCart: true,
                                // cashFreeData: impCashFreeData
                              ),
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
                              child:
                                  //true
                                  creatingOrder
                                      ? SizedBox(
                                          width: 35.0,
                                          height: 35.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.0,
                                            backgroundColor: Color(int.parse(
                                                "0xff${layoutDesignProvider.primary.substring(1)}")),
                                          ),
                                        )
                                      : Text(
                                          "Create order",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: deviceWidth > 600
                                                  ? (Fontsizes
                                                          .tabletButtonTextSize) +
                                                      2
                                                  : Fontsizes.buttonTextSize,
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
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      final response = await ApiService.createRazorpayOrder();

      if (response != null) {
        String body = await response.stream.bytesToString();
        print("Razorpay Payment body $body");

        try {
          print("${body.runtimeType}");
          print("Razorpay JSON DECODE DATA $data");
          data.add(jsonDecode(body));
          return data;
        } catch (e) {
          print('Razorpay Error decoding: $e');
          return <Map<String, dynamic>>[];
        }
      }
    }
    return <Map<String, dynamic>>[];
  }

  Future<List<Map<String, dynamic>>> uiCreateCashFreeOrder() async {
    List<Map<String, dynamic>> data = <Map<String, dynamic>>[];
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      final response = await ApiService.createCashFreeOrder();

      if (response != null) {
        String body = await response.stream.bytesToString();
        print("CashFree Payment body $body");

        try {
          print("${body.runtimeType}");
          print("CashFree JSON DECODE DATA $data");
          data.add(jsonDecode(body));
          return data;
        } catch (e) {
          print('CashFree Error decoding: $e');
          return <Map<String, dynamic>>[];
        }
      }
    }
    return <Map<String, dynamic>>[];
  }
}
