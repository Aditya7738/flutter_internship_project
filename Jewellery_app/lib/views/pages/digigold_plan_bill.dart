import 'dart:convert';
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
  DigiGoldPlanOrderPage({super.key, required this.digiGoldPlanModel});

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

    if (customerProvider.customerData[0].containsKey("address_1")) {
      _addressController1.text = customerProvider.customerData[0]["address_1"];
    }

    if (customerProvider.customerData[0].containsKey("address_2")) {
      _addressController2.text = customerProvider.customerData[0]["address_2"];
    }

    if (customerProvider.customerData[0].containsKey("pincode")) {
      _pinNoController.text = customerProvider.customerData[0]["pincode"];
    }

    if (customerProvider.customerData[0].containsKey("company")) {
      _companyNameController.text = customerProvider.customerData[0]["company"];
    }

    if (customerProvider.customerData[0].containsKey("city")) {
      _cityController.text = customerProvider.customerData[0]["city"];
      print("CITY ${_cityController.text}");
    }

    if (customerProvider.customerData[0].containsKey("aadhar_card_no")) {
      _aadharCardController.text =
          customerProvider.customerData[0]["aadhar_card_no"];
    }

    if (customerProvider.customerData[0].containsKey("pan_card_no")) {
      _panCardController.text = customerProvider.customerData[0]["pan_card_no"];
    }

    if (customerProvider.customerData[0].containsKey("passport_no")) {
      _passportController.text =
          customerProvider.customerData[0]["passport_no"];
    }

    if (customerProvider.customerData[0].containsKey("driving_license_no")) {
      _licenseNoController.text =
          customerProvider.customerData[0]["driving_license_no"];
    }

    if (customerProvider.customerData[0].containsKey("nominee_name")) {
      _nomineeNameController.text =
          customerProvider.customerData[0]["nominee_name"];
    }

    if (customerProvider.customerData[0].containsKey("nominee_relation")) {
      _nomineeRelationController.text =
          customerProvider.customerData[0]["nominee_relation"];
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
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context);

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
                Text("Your order",
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid)),
                  child: Column(
                    children: [
                      CartTotalRow(
                          label: 'Product',
                          value:
                              widget.digiGoldPlanModel.name ?? "Digi Gold Plan",
                          showMoney: false),
                      const Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      CartTotalRow(
                          label: 'Subtotal',
                          value: widget.digiGoldPlanModel.price ?? "0",
                          showMoney: true),
                      const Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      CartTotalRow(
                        label: 'Total',
                        value: widget.digiGoldPlanModel.price ?? "0",
                        showMoney: true,
                      ),
                    ],
                  ),
                ),
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return ValidationHelper.isEmailValid(value);
                  },
                  decoration: const InputDecoration(
                    // errorText: ,
                    labelText: "Enter your email*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text("Personal Details",
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 10.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Proof Type (optional)",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10.0, left: 5.0),
                  width: MediaQuery.of(context).size.width,
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
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedProof = newValue!;
                        });
                      }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                getSelectedProofWidget(selectedProof),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
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
                          setState(() {
                            imagePath = image.path;
                          });
                          print("imagePath $imagePath");

                          bool isThereInternet =
                              await ApiService.checkInternetConnection(context);
                          if (isThereInternet) {
                            setState(() {
                              isImageUploading = true;
                            });

                            http.StreamedResponse response =
                                await ApiService.uploadDocumentImage(imagePath);

                            setState(() {
                              isImageUploading = false;
                            });

                            if (response.statusCode == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      padding: EdgeInsets.all(15.0),
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      content: Text(
                                        "Image upload successfully",
                                        style: TextStyle(color: Colors.white),
                                      )));

                              setState(() {
                                showFileName = true;
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      padding: EdgeInsets.all(15.0),
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Failed upload image",
                                        style: TextStyle(color: Colors.white),
                                      )));
                            }
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: isImageUploading
                              ? SizedBox(
                                  width: 200.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Upload document image",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 17.0),
                                )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text("Nominee Details",
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _nomineeNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Nominee Name (Optional)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _nomineeRelationController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Nominee Relation (Optional)",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isOrderCreating = true;
                      });

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

                      List<Map<String, dynamic>> line_items = [
                        {
                          "product_id": widget.digiGoldPlanModel.id,
                          "quantity": 1,
                          "total": widget.digiGoldPlanModel.price,
                          "tax_class": "zero-rate",
                        },
                      ];

                      List<Map<String, dynamic>> meta_data = [
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
                        {
                          "key": "payment_date",
                          "value": DateTime.now().toString()
                        },
                        {
                          "key": "digi_plan_type",
                          "value": digiPlanType
                        },
                        {
                          "key": "description",
                          "value": widget.digiGoldPlanModel.description
                        },
                      ];

                      print(
                          "customerProvider.customerId ${customerProvider.customerData[0]["id"]}");

                      orderProvider.setBillingData(billingData);
                      orderProvider.setCustomerId(
                          customerProvider.customerData[0]["id"]);
                      orderProvider.setLineItems(line_items);
                      orderProvider.setMetaData(meta_data);
                      orderProvider
                          .setPrice(widget.digiGoldPlanModel.price ?? "");

                      List<Map<String, dynamic>> razorpayOrderData =
                          await uiCreateRazorpayOrder();

                      Map<String, dynamic> personalData = {};

                      switch (selectedProof) {
                        case "Aadhar card":
                          if (_aadharCardController.text == "") {
                            personalData = {
                              "aadhar_card_no": _aadharCardController.text
                            };
                          }

                          break;
                        case "Pan card":
                          if (_panCardController.text == "") {
                            personalData = {
                              "pan_card_no": _panCardController.text
                            };
                          }
                          break;
                        case "Passport":
                          if (_passportController.text == "") {
                            personalData = {
                              "passport_no": _passportController.text
                            };
                          }
                          break;

                        case "Driving License":
                          if (_licenseNoController.text == "") {
                            personalData = {
                              "driving_license_no": _licenseNoController.text
                            };
                          }
                          break;

                        default:
                          personalData = {};
                          break;
                      }

                      print("CITY2 ${_cityController.text}");

                      customerProvider.addCustomerData({
                        "address_1": _addressController1.text,
                        "address_2": _addressController2.text,
                        "city": _cityController.text,
                        "digi_gold_billing_email": _emailController.text,
                        "digi_gold_billing_phone": _phoneNoController.text,
                        "digi_gold_plan_name":
                            widget.digiGoldPlanModel.name ?? "Digi Gold Plan"
                      });

                      if (_nomineeNameController.text != "" &&
                          _nomineeRelationController.text != "") {
                        Map<String, dynamic> nomineeData = {
                          "nominee_name": _nomineeNameController.text,
                          "nominee_relation": _nomineeRelationController.text
                        };
                        customerProvider.addCustomerData(nomineeData);
                      }

                      customerProvider.addCustomerData(personalData);

                      setState(() {
                        isOrderCreating = false;
                      });

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
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: const Color(0xffCC868A),
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Center(
                        child: isOrderCreating
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
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.0),
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

  Widget getSelectedProofWidget(String selectedProof) {
    switch (selectedProof) {
      case "Aadhar card":
        return TextFormField(
          controller: _aadharCardController,
          keyboardType: TextInputType.number,
          validator: (value) {
            return ValidationHelper.isAadharCardNoValid(value);
          },
          decoration: const InputDecoration(
            // errorText: ,
            labelText: "Aadhar card* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      case "Pan card":
        return TextFormField(
          controller: _panCardController,
          keyboardType: TextInputType.text,
          validator: (value) {
            return ValidationHelper.isPanCardValid(value);
          },
          decoration: const InputDecoration(
            // errorText: ,
            labelText: "Pan card* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      case "Passport":
        return TextFormField(
          controller: _passportController,
          keyboardType: TextInputType.text,
          validator: (value) {
            return ValidationHelper.isPassportValid(value);
          },
          decoration: const InputDecoration(
            // errorText: ,
            labelText: "Passport* ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        );

      case "Driving License":
        return TextFormField(
          controller: _licenseNoController,
          keyboardType: TextInputType.text,
          validator: (value) {
            return ValidationHelper.isDrivingLicenseValid(value);
          },
          decoration: const InputDecoration(
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
