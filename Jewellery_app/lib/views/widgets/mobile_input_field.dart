// import 'package:flutter/material.dart';
// import 'package:Tiara_by_TJ/helpers/validation_helper.dart';

// class MobileInputField extends StatefulWidget {
//   const MobileInputField({super.key});

//   @override
//   State<MobileInputField> createState() => _MobileInputFieldState();
// }

// class _MobileInputFieldState extends State<MobileInputField> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//                     height: 75.0,
//                     child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       validator: (value) {
//                         return ValidationHelper.isPhoneNoValid(value);
//                       },
//                       decoration: InputDecoration(
//                           suffix: GestureDetector(
//                               onTap: () {
//                                 //value.setPhoneNoVerified(true);
//                               },
//                                child: 
//                               // value.phoneNoVerified
//                               //     ? Container(
//                               //         width: 100.0,
//                               //         height: 40.0,
//                               //         decoration: BoxDecoration(
//                               //             color: Color(0xffCC868A),
//                               //             borderRadius:
//                               //                 BorderRadius.circular(10.0)),
//                               //         padding: const EdgeInsets.symmetric(
//                               //             vertical: 10.0, horizontal: 20.0),
//                               //         child: Center(
//                               //           child: const Text(
//                               //             "VERIFY",
//                               //             style: TextStyle(
//                               //                 color: Colors.white,
//                               //                 fontSize: 15.0),
//                               //           ),
//                               //         ))
//                                  //  :
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(bottom: 0.0),
//                                       child: Image.asset(
//                                         "assets/images/yes.png",
//                                         width: 30.0,
//                                         height: 25.0,
//                                       ),
//                                     )),
//                           border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20.0))),
//                           prefix: DropdownButton(
//                               value: selectedOption,
//                               icon:
//                                   const Icon(Icons.keyboard_arrow_down_rounded),
//                               items: options.map((String option) {
//                                 return DropdownMenuItem(
//                                   value: option,
//                                   child: Text(option),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   selectedOption = newValue!;
//                                 });
//                               }),
//                           labelText: "Mobile number*"),
//                       maxLines: 1,
//                     ),
//                   );
//   }
// }