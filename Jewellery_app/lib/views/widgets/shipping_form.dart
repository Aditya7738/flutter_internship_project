import 'package:Tiara_by_TJ/constants/fontsizes.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingForm extends StatefulWidget {
  final TextEditingController firstNameController2;

  final List<String> countryOptions;

  final TextEditingController lastNameController2;

  final TextEditingController companyNameController2;

  final TextEditingController address2Controller1;

  final TextEditingController address2Controller2;

  final TextEditingController cityController2;

  final TextEditingController pinNoController2;

  final TextEditingController phoneNoController2;

  final List<String> stateOptions;

  final List<String> countryCodeOptions;
  final String formHeading;

  ShippingForm(
      {super.key,
      required this.firstNameController2,
      required this.lastNameController2,
      required this.companyNameController2,
      required this.address2Controller1,
      required this.address2Controller2,
      required this.cityController2,
      required this.pinNoController2,
      required this.phoneNoController2,
      required this.countryOptions,
      required this.stateOptions,
      required this.countryCodeOptions,
      required this.formHeading});

  @override
  State<ShippingForm> createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  String selectedState2 = "Maharashtra";
  String selectedCountry2 = "India";
  String selectedCountryCodeOption = "+91";

  late TextEditingController firstNameController2;

  late List<String> countryOptions;

  late TextEditingController lastNameController2;

  late TextEditingController companyNameController2;

  late TextEditingController address2Controller1;

  late TextEditingController address2Controller2;

  late TextEditingController cityController2;

  late TextEditingController pinNoController2;

  late TextEditingController phoneNoController2;

  late List<String> stateOptions;

  late List<String> countryCodeOptions;
  late String formHeading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController2 = widget.firstNameController2;

    countryOptions = widget.countryOptions;

    formHeading = widget.formHeading;

    stateOptions = widget.stateOptions;

    countryCodeOptions = widget.countryCodeOptions;

    lastNameController2 = widget.lastNameController2;

    companyNameController2 = widget.companyNameController2;

    address2Controller1 = widget.address2Controller1;

    address2Controller2 = widget.address2Controller2;

    cityController2 = widget.cityController2;

    pinNoController2 = widget.pinNoController2;

    phoneNoController2 = widget.phoneNoController2;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textFormFieldStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: Fontsizes.textFormInputFieldSize);

    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formHeading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Fontsizes.headingSize,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: firstNameController2,
          keyboardType: TextInputType.name,
          validator: (value) {
            return ValidationHelper.nullOrEmptyString(value);
          },
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            labelText: "First name*",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: lastNameController2,
          keyboardType: TextInputType.name,
          validator: (value) {
            return ValidationHelper.nullOrEmptyString(value);
          },
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            labelText: "Last name*",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: companyNameController2,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            // errorText: ,
            labelText: "Company name (optional)",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Country / Region",
            style: TextStyle(fontSize: 16.sp
                // deviceWidth > 600 ? deviceWidth / 38 : 16.0
                ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          padding: const EdgeInsets.only(right: 10.0, left: 5.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(
                  color: const Color.fromARGB(255, 103, 103, 103),
                  style: BorderStyle.solid)),
          // color: Colors.red,
          child: DropdownButton(
              itemHeight: kMinInteractiveDimension + 15,
              isExpanded: true,
              padding: const EdgeInsets.only(left: 10.0),
              value: selectedCountry2,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: countryOptions.map((String option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (mounted) {
                  setState(() {
                    selectedCountry2 = newValue!;
                  });
                }
              }),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: address2Controller1,
          keyboardType: TextInputType.streetAddress,
          validator: (value) {
            return ValidationHelper.nullOrEmptyString(value);
          },
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            // errorText: ,
            labelText: "Street address*",
            hintText: "House umber and street name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 50 : 10.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: address2Controller2,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            // errorText: ,
            hintText: "Apartment, suite, unit, etc. (optional)",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 20 : 30.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: cityController2,
          keyboardType: TextInputType.name,
          validator: (value) {
            return ValidationHelper.nullOrEmptyString(value);
          },
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            // errorText: ,
            labelText: "Town / City *",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "State *",
            style: TextStyle(
                fontSize:
                    //  deviceWidth > 600 ? deviceWidth / 38 : 16.0
                    16.sp),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),

        //  SizedBox(
        //   height: deviceWidth > 600 ? deviceWidth / 7 : 75.0,
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 10.0, left: 5.0),
          height: deviceWidth > 600 ? deviceWidth / 11 : 75.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(
                  color: const Color.fromARGB(255, 103, 103, 103),
                  style: BorderStyle.solid)),
          // color: Colors.red,
          child: DropdownButton(
              itemHeight: kMinInteractiveDimension + 15,
              isExpanded: true,
              padding: const EdgeInsets.only(left: 10.0),
              value: selectedState2,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: stateOptions.map((String option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (mounted) {
                  setState(() {
                    selectedState2 = newValue!;
                  });
                }
              }),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        TextFormField(
          style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
          controller: pinNoController2,
          keyboardType: TextInputType.number,
          validator: (value) {
            return ValidationHelper.isPincodeValid(value);
          },
          decoration: InputDecoration(
            errorStyle:
                TextStyle(fontSize: Fontsizes.errorTextSize, color: Colors.red),
            labelStyle: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            // errorText: ,
            labelText: "PIN code *",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 30 : 20.0,
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 7 : 75.0,
          child: TextFormField(
            style: TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
            controller: phoneNoController2,
            keyboardType: TextInputType.phone,
            validator: (value) {
              return ValidationHelper.isPhoneNoValid(value);
            },
            decoration: InputDecoration(
                errorStyle: TextStyle(
                    fontSize: Fontsizes.errorTextSize, color: Colors.red),
                labelStyle:
                    TextStyle(fontSize: Fontsizes.textFormInputFieldSize),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                prefix: DropdownButton(
                    value: selectedCountryCodeOption,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: countryCodeOptions.map((String option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (mounted) {
                        setState(() {
                          selectedCountryCodeOption = newValue!;
                        });
                      }
                    }),
                labelText: "Mobile number*"),
            maxLines: 1,
          ),
        ),
        SizedBox(
          height: deviceWidth > 600 ? deviceWidth / 55 : 20.0,
        ),
      ],
    );
  }
}
