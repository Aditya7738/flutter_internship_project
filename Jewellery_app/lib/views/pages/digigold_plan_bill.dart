import 'dart:convert';

import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/model/digi_gold_plan_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/digigold_provider.dart';
import 'package:Tiara_by_TJ/providers/order_provider.dart';
import 'package:Tiara_by_TJ/views/pages/payment_page.dart';
import 'package:Tiara_by_TJ/views/widgets/cart_total_row.dart';
import 'package:Tiara_by_TJ/views/widgets/shipping_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class DigiGoldPlanOrderPage extends StatefulWidget {
  final DigiGoldPlanModel digiGoldPlanModel;
  Map<String, String>? flexiPlanData;
  DigiGoldPlanOrderPage(
      {super.key, required this.digiGoldPlanModel, this.flexiPlanData});

  @override
  State<DigiGoldPlanOrderPage> createState() => _DigiGoldPlanOrderPageState();
}

class _DigiGoldPlanOrderPageState extends State<DigiGoldPlanOrderPage> {
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

  List<String> proofOptions = [
    "Aadhar card",
    "Pan card",
    "Passport",
    "Driving License"
  ];

  String selectedProof = "Aadhar card";

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

  final TextEditingController _aadharCardController = TextEditingController();

  final TextEditingController _panCardController = TextEditingController();

  final TextEditingController _passportController = TextEditingController();

  final TextEditingController _licenseNoController = TextEditingController();

  final TextEditingController _nomineeNameController = TextEditingController();

  final TextEditingController _nomineeRelationController =
      TextEditingController();

  bool isOrderCreating = false;

  int planDuration = 0;

  String digiPlanType = "";

  bool isImageUploading = false;

  bool showFileName = false;

  String imagePath = "";

  String goldGross = "";

  bool isProofSelected = false;

  bool showForgotToUploadFileMsg = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    final customerData = customerProvider.customerData[0];

    if (customerData.containsKey("first_name")) {
      _firstNameController.text = customerData["first_name"];
    }

    if (customerData.containsKey("last_name")) {
      _lastNameController.text = customerData["last_name"];
    }

    if (customerData.containsKey("email")) {
      _emailController.text = customerData["email"];
    }

    // if (customerData.containsKey("mobile_no")) {

    // }

    // if (customerData.containsKey("pincode")) {

    // }

    if (customerData.containsKey("billing")) {
      _companyNameController.text = customerData["billing"]["company"];

      _addressController1.text = customerData["billing"]["address_1"];
      _addressController2.text = customerData["billing"]["address_2"];

      _cityController.text = customerData["billing"]["city"];
      _phoneNoController.text = customerData["billing"]["phone"];
      _pinNoController.text = customerData["billing"]["postcode"];
    }

    if (customerData.containsKey("nominee_name")) {
      _nomineeNameController.text = customerData["nominee_name"];
    }

    if (customerData.containsKey("nominee_relation")) {
      _nomineeRelationController.text = customerData["nominee_relation"];
    }

    for (var i = 0; i < widget.digiGoldPlanModel.metaData.length; i++) {
      if (widget.digiGoldPlanModel.metaData[i].key == "digi_plan_duration") {
        planDuration = int.parse(widget.digiGoldPlanModel.metaData[i].value);
      }

      if (widget.digiGoldPlanModel.metaData[i].key == "digi_plan_type") {
        digiPlanType = widget.digiGoldPlanModel.metaData[i].value;
      }

      if (widget.digiGoldPlanModel.metaData[i].key == "gold_gross") {
        goldGross = widget.digiGoldPlanModel.metaData[i].value;
      }
    }

    checkIsJewellerContributing();
  }

  String getPlanDuration() {
    for (var i = 0; i < widget.digiGoldPlanModel.metaData.length; i++) {
      if (widget.digiGoldPlanModel.metaData[i].key == "digi_plan_duration") {
        return widget.digiGoldPlanModel.metaData[i].value;
      }
    }
    return "";
  }

  String jewellerContribution = "";
  checkIsJewellerContributing() {
    for (var i = 0; i < widget.digiGoldPlanModel.metaData.length; i++) {
      print(
          "widget.digiGoldPlanModel.metaData[i].key == jeweller_contribution ${widget.digiGoldPlanModel.metaData[i].key == "jeweller_contribution"}");

      if (widget.digiGoldPlanModel.metaData[i].key == "jeweller_contribution") {
        if (mounted) {
          setState(() {
            jewellerContribution = widget.digiGoldPlanModel.metaData[i].value;
          });
          print("jewellerContribution $jewellerContribution");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    LayoutDesignProvider layoutDesignProvider =
        Provider.of<LayoutDesignProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 15.0,
                // ),
                Text(
                  "Plan details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: deviceWidth > 600
                        ? Fontsizes.tabletHeadingSize
                        : Fontsizes.headingSize,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid)),
                    child: widget.flexiPlanData != null
                        ? Column(
                            children: [
                              CartTotalRow(
                                  label: 'Plan name',
                                  value: widget.digiGoldPlanModel.name ??
                                      "Digi Gold Plan",
                                  showMoney: false),
                              const Divider(
                                height: 15.0,
                                color: Colors.grey,
                              ),
                              CartTotalRow(
                                label: 'Selected plan duration',
                                value:
                                    "${widget.flexiPlanData!["plan_duration"]!} months",
                                showMoney: false,
                              ),
                              const Divider(
                                height: 15.0,
                                color: Colors.grey,
                              ),
                              CartTotalRow(
                                label: 'Amount need to pay per month',
                                value: widget.flexiPlanData!["plan_price"]!,
                                showMoney: true,
                              ),
                              const Divider(
                                height: 15.0,
                                color: Colors.grey,
                              ),
                              CartTotalRow(
                                label: 'Total amount you pay in plan',
                                value:
                                    "${int.parse(widget.flexiPlanData!["plan_price"]!) * int.parse(widget.flexiPlanData!["plan_duration"]!)}",
                                showMoney: true,
                              ),
                              const Divider(
                                height: 15.0,
                                color: Colors.grey,
                              ),
                              CartTotalRow(
                                label: 'Gold credit per month',
                                value:
                                    "${widget.flexiPlanData!["plan_gold_weight"]!} gms",
                                showMoney: false,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              CartTotalRow(
                                  label: 'Plan name',
                                  value: widget.digiGoldPlanModel.name ??
                                      "Digi Gold Plan",
                                  showMoney: false),
                              const Divider(
                                height: 15.0,
                                color: Colors.grey,
                              ),
                              CartTotalRow(
                                  label: 'Plan amount',
                                  value: widget.digiGoldPlanModel.price ?? "0",
                                  showMoney: true),
                              const Divider(
                                height: 15.0,
                                color: Colors.grey,
                              ),
                              CartTotalRow(
                                label: 'Plan duration',
                                value: "${getPlanDuration()} months",
                                showMoney: false,
                              ),
                            ],
                          )),
                SizedBox(
                  height: 30.0,
                ),
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
                    labelText: "Enter your email*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text("Personal Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceWidth > 600
                          ? Fontsizes.tabletHeadingSize
                          : Fontsizes.headingSize,
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Proof Type (optional)",
                    style: TextStyle(fontSize: deviceWidth > 600 ? 24.sp : 16.sp
                        // deviceWidth > 600 ? deviceWidth / 38 : 16.0
                        ),
                    //  TextStyle(
                    //     fontSize: deviceWidth > 600 ? deviceWidth / 38 : 16.0),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 10.0, left: 5.0),
                  width: MediaQuery.of(context).size.width,
                  height: deviceWidth > 600 ? deviceWidth / 11 : 75.0,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      border: Border.all(
                          color: const Color.fromARGB(255, 103, 103, 103),
                          style: BorderStyle.solid)),
                  // color: Colors.red,
                  child: DropdownButton(
                      itemHeight: kMinInteractiveDimension + 15,
                      isExpanded: true,
                      padding: const EdgeInsets.only(left: 10.0),
                      value: selectedProof,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: proofOptions.map((String option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(
                            option,
                            style: TextStyle(
                                fontSize: deviceWidth > 600
                                    ? Fontsizes.tabletTextFormInputFieldSize
                                    : Fontsizes.textFormInputFieldSize),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (mounted) {
                          setState(() {
                            isProofSelected = true;
                            selectedProof = newValue!;
                          });
                        }
                      }),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                isProofSelected
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getSelectedProofWidget(selectedProof, deviceWidth),
                          const SizedBox(
                            height: 10.0,
                          ),
                          showFileName
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Uploaded file name: ${path.basename(imagePath)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: deviceWidth > 600
                                                ? 26.sp
                                                : 16.sp),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          showForgotToUploadFileMsg
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "You have to upload document image",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: deviceWidth > 600
                                              ? (Fontsizes
                                                      .tabletErrorTextSize) +
                                                  2
                                              : Fontsizes.errorTextSize,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    if (mounted) {
                                      setState(() {
                                        imagePath = image.path;
                                      });
                                    }
                                    print("imagePath $imagePath");

                                    bool isThereInternet = await ApiService
                                        .checkInternetConnection(context);
                                    if (isThereInternet) {
                                      if (mounted) {
                                        setState(() {
                                          isImageUploading = true;
                                        });
                                      }

                                      http.StreamedResponse response =
                                          await ApiService.uploadDocumentImage(
                                              imagePath);

                                      if (mounted) {
                                        setState(() {
                                          isImageUploading = false;
                                        });
                                      }

                                      if (response.statusCode == 201) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                padding: EdgeInsets.all(15.0),
                                                backgroundColor: Color(int.parse(
                                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                content: Text(
                                                  "Image upload successfully",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: deviceWidth >
                                                              600
                                                          ? Fontsizes
                                                              .tabletButtonTextSize
                                                          : Fontsizes
                                                              .buttonTextSize),
                                                )));

                                        if (mounted) {
                                          setState(() {
                                            showFileName = true;
                                            showForgotToUploadFileMsg = false;
                                          });
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                padding: EdgeInsets.all(15.0),
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Failed to upload image",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: deviceWidth >
                                                                600
                                                            ? Fontsizes
                                                                .tabletButtonTextSize
                                                            : Fontsizes
                                                                .buttonTextSize))));
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(int.parse(
                                                "0xff${layoutDesignProvider.primary.substring(1)}")),
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child:
                                        //true
                                        isImageUploading
                                            ? SizedBox(
                                                width: deviceWidth > 600
                                                    ? 290.sp
                                                    : 220.sp,
                                                height: 30.0,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3.0,
                                                    color: Color(int.parse(
                                                        "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                "Upload document image",
                                                style: TextStyle(
                                                    color: Color(int.parse(
                                                        "0xff${layoutDesignProvider.primary.substring(1)}")),
                                                    fontSize: deviceWidth > 600
                                                        ? Fontsizes
                                                            .tabletButtonTextSize
                                                        : Fontsizes
                                                            .buttonTextSize),
                                              )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      )
                    : SizedBox(),

                Text("Nominee Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceWidth > 600
                          ? Fontsizes.tabletHeadingSize
                          : Fontsizes.headingSize,
                    )),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: deviceWidth > 600
                          ? Fontsizes.tabletTextFormInputFieldSize
                          : Fontsizes.textFormInputFieldSize),
                  controller: _nomineeNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        fontSize: deviceWidth > 600
                            ? Fontsizes.tabletErrorTextSize
                            : Fontsizes.errorTextSize,
                        color: Colors.red),
                    labelText: "Nominee Name (Optional)",
                    labelStyle: TextStyle(
                        fontSize: deviceWidth > 600
                            ? Fontsizes.tabletTextFormInputFieldSize
                            : Fontsizes.textFormInputFieldSize),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: deviceWidth > 600
                          ? Fontsizes.tabletTextFormInputFieldSize
                          : Fontsizes.textFormInputFieldSize),
                  controller: _nomineeRelationController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        fontSize: deviceWidth > 600
                            ? Fontsizes.tabletErrorTextSize
                            : Fontsizes.errorTextSize,
                        color: Colors.red),
                    // labelStyle: Theme.of(context).textTheme.subtitle1,
                    labelText: "Nominee Relation (Optional)",
                    labelStyle: TextStyle(
                        fontSize: deviceWidth > 600
                            ? Fontsizes.tabletTextFormInputFieldSize
                            : Fontsizes.textFormInputFieldSize),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {
                    if (isProofSelected) {
                      if (!showFileName) {
                        if (mounted) {
                          setState(() {
                            showForgotToUploadFileMsg = true;
                          });
                        }
                      } else {
                        createOrder(customerProvider, orderProvider);
                      }
                    } else {
                      createOrder(customerProvider, orderProvider);
                    }
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: deviceWidth > 600 ? 70.0 : 50.0,
                      decoration: BoxDecoration(
                          color: const Color(0xffCC868A),
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Center(
                        child: isOrderCreating
                            ? SizedBox(
                                width: 30.0,
                                height: 30.0,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                  backgroundColor: Color(0xffCC868A),
                                ),
                              )
                            : Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: deviceWidth > 600
                                        ? Fontsizes.tabletButtonTextSize
                                        : Fontsizes.buttonTextSize),
                              ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createOrder(
      CustomerProvider customerProvider, OrderProvider orderProvider) async {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          isOrderCreating = true;
        });
      }

      print("CITY1 ${_cityController.text}");
      Map<String, String> billingData = {
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

      List<Map<String, dynamic>> line_items = <Map<String, dynamic>>[];
      if (widget.flexiPlanData != null) {
        line_items = [
          {
            "product_id": widget.digiGoldPlanModel.id,
            "quantity": 1,
            "total": widget.flexiPlanData!["plan_price"]!,
            "tax_class": "zero-rate",
          },
        ];
      } else {
        line_items = [
          {
            "product_id": widget.digiGoldPlanModel.id,
            "quantity": 1,
            "total": widget.digiGoldPlanModel.price,
            "tax_class": "zero-rate",
          },
        ];
      }

      List<Map<String, dynamic>> meta_data = <Map<String, dynamic>>[];

      if (widget.flexiPlanData != null) {
        meta_data = [
          {
            "key": "virtual_order",
            "value": "digigold",
          },
          {
            "key": "gold_gross",
            "value": widget.flexiPlanData!["plan_gold_weight"]!,
          },
          {
            "key": "digi_plan_duration",
            "value": widget.flexiPlanData!["plan_duration"]!
          },
          {
            "key": "digi_plan_price",
            "value": widget.flexiPlanData!["plan_price"]!
          },
          {
            "key": "digi_plan_name",
            "value": widget.digiGoldPlanModel.name ?? "Gold plan"
          },
          {
            "key": "digi_plan_type",
            "value": widget.flexiPlanData!["digi_plan_type"]
          },
          {"key": "description", "value": widget.flexiPlanData!["description"]},
        ];
      } else {
        meta_data = [
          {
            "key": "virtual_order",
            "value": "digigold",
          },
          {
            "key": "gold_gross",
            "value": goldGross,
          },
          {"key": "digi_plan_duration", "value": "$planDuration"},
          {
            "key": "digi_plan_name",
            "value": widget.digiGoldPlanModel.name ?? "Gold plan"
          },
          {"key": "digi_plan_type", "value": digiPlanType},
          {"key": "description", "value": widget.digiGoldPlanModel.description},
          {"key": "jeweller_contribution", "value": jewellerContribution}
        ];
      }

      print("jeweller_contribution ${jewellerContribution}");
      print(
          "widget.digiGoldPlanModel.description ${widget.digiGoldPlanModel.description}");

      // print(
      //     "customerProvider.customerId ${customerProvider.customerData[0]["id"]}");

      print("DIGI ORDER META $meta_data");

      orderProvider.setBillingData(billingData);
      orderProvider.setCustomerId(customerProvider.customerData[0]["id"]);
      orderProvider.setLineItems(line_items);
      orderProvider.setMetaData(meta_data);
      orderProvider.setPrice(widget.flexiPlanData != null
          ? widget.flexiPlanData!["plan_price"]!
          : widget.digiGoldPlanModel.price!);

      ///////////////////////////////////////////////////////////////////////////////////////

      List<Map<String, dynamic>> razorpayOrderData =
          await uiCreateRazorpayOrder();

      Map<String, dynamic> personalData = {};

      switch (selectedProof) {
        case "Aadhar card":
          if (_aadharCardController.text == "") {
            personalData = {"aadhar_card_no": _aadharCardController.text};
          }

          break;
        case "Pan card":
          if (_panCardController.text == "") {
            personalData = {"pan_card_no": _panCardController.text};
          }
          break;
        case "Passport":
          if (_passportController.text == "") {
            personalData = {"passport_no": _passportController.text};
          }
          break;

        case "Driving License":
          if (_licenseNoController.text == "") {
            personalData = {"driving_license_no": _licenseNoController.text};
          }
          break;

        default:
          personalData = {};
          break;
      }

      print("CITY2 ${_cityController.text}");

      print(
          "DigiGoldPlanName ${widget.digiGoldPlanModel.name ?? "Digi Gold Plan"}");

      customerProvider.addMapToFirst({
        // "address_1": _addressController1.text,
        // "address_2": _addressController2.text,
        // "city": _cityController.text,
        // "pincode": _pinNoController.text,
        "digi_gold_billing_email": _emailController.text,
        "digi_gold_billing_phone": _phoneNoController.text,
        "digi_gold_plan_name": widget.digiGoldPlanModel.name ?? "Digi Gold Plan"
      });

      for (var i = 0; i < customerProvider.customerData.length; i++) {
        print("CUSTOMERDATA[$i] ${customerProvider.customerData[i]}");
      }

      if (_nomineeNameController.text != "" &&
          _nomineeRelationController.text != "") {
        Map<String, dynamic> nomineeData = {
          "nominee_name": _nomineeNameController.text,
          "nominee_relation": _nomineeRelationController.text
        };
        customerProvider.addMapToFirst(nomineeData);
      }

      // customerProvider.addCustomerData(personalData);

      if (mounted) {
        setState(() {
          isOrderCreating = false;
        });
      }

      if (razorpayOrderData.isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PaymentPage(
            orderId: razorpayOrderData[0]["id"],
            fromCart: false,
            // cashFreeData: impCashFreeData
          ),
        ));
      }
    }
  }

  Widget getSelectedProofWidget(String selectedProof, double deviceWidth) {
    switch (selectedProof) {
      case "Aadhar card":
        return TextFormField(
          style: TextStyle(
              fontSize: deviceWidth > 600
                  ? Fontsizes.tabletTextFormInputFieldSize
                  : Fontsizes.textFormInputFieldSize),
          controller: _aadharCardController,
          keyboardType: TextInputType.number,
          validator: (value) {
            return ValidationHelper.isAadharCardNoValid(value);
          },
          decoration: InputDecoration(
            errorStyle: TextStyle(
                fontSize: deviceWidth > 600
                    ? Fontsizes.tabletErrorTextSize
                    : deviceWidth > 600
                        ? Fontsizes.tabletErrorTextSize
                        : Fontsizes.errorTextSize,
                color: Colors.red),
            labelStyle: TextStyle(
                fontSize: deviceWidth > 600
                    ? Fontsizes.tabletTextFormInputFieldSize
                    : Fontsizes.textFormInputFieldSize),
            // errorText: ,
            labelText: "Aadhar card* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      case "Pan card":
        return TextFormField(
          style: TextStyle(
              fontSize: deviceWidth > 600
                  ? Fontsizes.tabletTextFormInputFieldSize
                  : Fontsizes.textFormInputFieldSize),
          controller: _panCardController,
          keyboardType: TextInputType.text,
          validator: (value) {
            return ValidationHelper.isPanCardValid(value);
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
            labelText: "Pan card* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      case "Passport":
        return TextFormField(
          style: TextStyle(
              fontSize: deviceWidth > 600
                  ? Fontsizes.tabletTextFormInputFieldSize
                  : Fontsizes.textFormInputFieldSize),
          controller: _passportController,
          keyboardType: TextInputType.text,
          validator: (value) {
            return ValidationHelper.isPassportValid(value);
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
            labelText: "Passport* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      case "Driving License":
        return TextFormField(
          style: TextStyle(
              fontSize: deviceWidth > 600
                  ? Fontsizes.tabletTextFormInputFieldSize
                  : Fontsizes.textFormInputFieldSize),
          controller: _licenseNoController,
          keyboardType: TextInputType.text,
          validator: (value) {
            return ValidationHelper.isDrivingLicenseValid(value);
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
            labelText: "Driving License* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      default:
        return SizedBox();
    }
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
}
