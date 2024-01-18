import 'package:flutter/material.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jwelery_app/helpers/validation_helper.dart';
import 'package:jwelery_app/model/choice_model.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/profile_provider.dart';
import 'package:jwelery_app/providers/wishlist_provider.dart';
import 'package:jwelery_app/views/pages/cart_page.dart';
import 'package:jwelery_app/views/pages/wishlist_page.dart';
import 'package:jwelery_app/views/widgets/choice_widget.dart';
import 'package:jwelery_app/views/widgets/suffix_icon.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

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
          title: Image.network(
            Strings.app_logo,
            width: 150,
            height: 80,
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            const CircleAvatar(
              radius: 12.0,

              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/b/bc/Flag_of_India.png"),
                radius: 12,
              ), //CircleAvatar,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 40.0,
              width: 32.0,
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
                badgeContent: Consumer<WishlistProvider>(
                    builder: (context, value, child) {
                  print("LENGTH OF FAV: ${value.favProductIds}");
                  return Text(
                    value.favProductIds.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WishListPage()));
                  },
                  icon: const Icon(Icons.favorite_sharp, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              height: 40.0,
              width: 32.0,
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
                badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                          value.cart.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                child: IconButton(
                  onPressed: () {
                    print("CART CLICKED");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(child: Consumer<ProfileProvider>(
          builder: (context, value, child) {
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
                      decoration: InputDecoration(
                        // errorText: ,
                        labelText: "First Name*",
                        border: const OutlineInputBorder(),
                      ),
                  
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return ValidationHelper.nullOrEmptyString(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Last Name*",
                      border: const OutlineInputBorder(),
                    ),
                 
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 75.0,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        return ValidationHelper.isPhoneNoValid(value);
                      },
                      decoration: InputDecoration(
                          suffix: Container(
                              width: 100.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Color(0xffCC868A),
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Center(
                                child: const Text(
                                  "VERIFY",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              )),
                          border: const OutlineInputBorder(),
                      
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
                    height: 20.0,
                  ),

                  Container(
                    height: 75.0,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return ValidationHelper.isEmailValid(value);
                      },
                      decoration: InputDecoration(
                        //labelText: "Enter your email",
                        labelText: "Enter your email*",
                        border: const OutlineInputBorder(),
                        suffix: Container(
                            width: 100.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: Color(0xffCC868A),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Center(
                              child: const Text(
                                "VERIFY",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            )),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: (){}, child: Text("VERIFY")),

                  SizedBox(
                    height: 20.0,
                  ),

                  TextFormField(
                    validator: (value) {
                        return ValidationHelper.isPincodeValid(value);
                      },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Pin code*",
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 20.0,
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
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  TextFormField(
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      anniversarydateController.text =
                          await _selectedDate(context);
                    },
                    controller: anniversarydateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: SuffixIcon(icon: Icons.calendar_month),
                      labelText: "Anniversary (Optional)",
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  
                  TextFormField(
                   onTap: () async {
                      print("CALENDAR PRESSED");

                      spousebirthdateController.text =
                          await _selectedDate(context);
                    },
                    controller: spousebirthdateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      suffixIcon: SuffixIcon(icon: Icons.calendar_month),
                      labelText: "Spouse Birthday (Optional)",
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 1,
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Container(
                        width: 180.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xffCC868A),
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Center(
                          child: const Text(
                            "SAVE CHAGES",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
