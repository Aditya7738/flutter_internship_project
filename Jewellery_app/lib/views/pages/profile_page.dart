import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/providers/profile_provider.dart';
import 'package:jwelery_app/views/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController birthdateController = TextEditingController();
  TextEditingController anniversarydateController = TextEditingController();
  TextEditingController spousebirthdateController = TextEditingController();

  List<String> options = ["+91", "+92"];

  String selectedOption = "+91";

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<String> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945),
        lastDate: DateTime(2025));

    if (picked != null && picked != selectedDate) {
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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //    selectedOption = options[0];
  // }

  @override
  Widget build(BuildContext context) {
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
                      validator: (value) {
                        return ValidationHelper.isPhoneNoValid(value);
                      },
                      decoration: InputDecoration(
                          suffix: GestureDetector(
                              onTap: () {
                                value.setPhoneNoVerified(true);
                              },
                              child: value.phoneNoVerified
                                  ? Container(
                                      width: 100.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffCC868A),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: const Center(
                                        child: Text(
                                          "VERIFY",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                      ))
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      child: Image.asset(
                                        "assets/images/yes.png",
                                        width: 30.0,
                                        height: 25.0,
                                      ),
                                    )),
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

                  SizedBox(
                    height: 75.0,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return ValidationHelper.isEmailValid(value);
                      },
                      decoration: InputDecoration(
                        //labelText: "Enter your email",
                        labelText: "Enter your email*",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        suffix: GestureDetector(
                            onTap: () {
                              value.setEmailVerified(true);
                            },
                            child: value.phoneNoVerified
                                ? Container(
                                    width: 100.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffCC868A),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: const Center(
                                      child: Text(
                                        "VERIFY",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 0.0),
                                    child: Image.asset(
                                      "assets/images/yes.png",
                                      width: 30.0,
                                      height: 25.0,
                                    ),
                                  )),
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
                    controller: birthdateController,
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      birthdateController.text = await _selectedDate(context);
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

                      anniversarydateController.text =
                          await _selectedDate(context);
                    },
                    controller: anniversarydateController,
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

                      spousebirthdateController.text =
                          await _selectedDate(context);
                    },
                    controller: spousebirthdateController,
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
                  Center(
                      child: RichText(
                          text: TextSpan(
                              text:
                                  '*By clicking on Save chage, you accept our ',
                              style: const TextStyle(color: Colors.black),
                              children: <TextSpan>[
                        TextSpan(
                          text: 'T&C',
                          style: const TextStyle(
                            color: Color(0xffCC868A),
                            
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the click event for the specific word.
                              print('You clicked on T&C');
                              // Add your custom action here.
                            },
                        ),
                        const TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            color: Colors.black,
                           
                          ),
                          
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: Color(0xffCC868A),
                            
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the click event for the specific word.
                              print('You clicked on Privacy Policy');
                              // Add your custom action here.
                            },
                        ),
                      ]))),

                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Container(
                        width: 180.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: const Color(0xffCC868A),
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: const Center(
                          child: Text(
                            "SAVE CHAGES",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
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
