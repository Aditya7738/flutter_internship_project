import 'package:Tiara_by_TJ/views/widgets/shipping_form.dart';
import 'package:flutter/material.dart';

class DigiGoldPlanOrderPage extends StatefulWidget {
  const DigiGoldPlanOrderPage({super.key});

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ShippingForm(
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
        ),
      ),
    );
  }
}
