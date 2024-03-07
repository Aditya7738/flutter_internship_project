import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/helpers/validation_helper.dart';
import 'package:Tiara_by_TJ/model/coupons_model.dart';
import 'package:flutter/material.dart';

class CouponListPage extends StatefulWidget {
  final List<int> cartProductIds;
  final double cartTotal;
  CouponListPage(
      {super.key, required this.cartProductIds, required this.cartTotal});

  @override
  State<CouponListPage> createState() => _CouponListPageState();
}

class _CouponListPageState extends State<CouponListPage> {
  bool isCouponListLoading = false;
  List<String> discounts = <String>[];
  List<Map<String, String>> listOfApplicableCoupons = <Map<String, String>>[];

  List<int> listOfApplicableCouponsIdsByMinAmt = <int>[];
  List<int> listOfNotApplicableCouponsByPrdtIds = <int>[];
  List<CouponsModel> listOfApplyCoupons = <CouponsModel>[];
  List<CouponsModel> listOfNonApplicableCoupons = <CouponsModel>[];

  bool showApplyButton = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCouponsList();
  }

  separateApplicableNonApplicable() async {
    for (var applicableCoupon in listOfApplicableCoupons) {
      if (applicableCoupon.containsValue("Not Applicable")) {
        for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
          for (var key in applicableCoupon.keys) {
            if ("${ApiService.listOfCoupons[i].id!}" == key) {
              listOfNonApplicableCoupons.add(ApiService.listOfCoupons[i]);
            }
          }
        }
      } else {
        for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
          for (var key in applicableCoupon.keys) {
            if ("${ApiService.listOfCoupons[i].id!}" == key) {
              listOfApplyCoupons.add(ApiService.listOfCoupons[i]);
            }
          }
        }
      }
    }

    print("listOfApplyCoupons");
    listOfApplyCoupons.forEach((element) {
      print(element);
    });

    print("listOfNonApplicableCoupons");
    listOfNonApplicableCoupons.forEach((element) {
      print(element);
    });

    print("listOfApplyCoupons length ${listOfApplyCoupons.length}");
    print(
        "listOfNonApplicableCoupons length ${listOfNonApplicableCoupons.length}");
  }

  checkCouponsApplicability() async {
    for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
      if (ApiService.listOfCoupons[i].minimumAmount != null) {
        if (double.parse(ApiService.listOfCoupons[i].minimumAmount!) >
            widget.cartTotal) {
          // listOfApplicableCoupons.insert(i, "Not applicable");
          listOfApplicableCoupons.insert(
              i, {"${ApiService.listOfCoupons[i].id!}": "Not Applicable"});
        } else {
          listOfApplicableCoupons
              .insert(i, {"${ApiService.listOfCoupons[i].id!}": "Apply"});
          // listOfApplicableCoupons.add("Applicable");
          listOfApplicableCouponsIdsByMinAmt
              .add(ApiService.listOfCoupons[i].id!); //TODO: store model not id
        }
      }
    }

    print("listOfApplicableCouponsIdsByMinAmt");
    listOfApplicableCouponsIdsByMinAmt.forEach((element) {
      print("${element}");
    });

    List<CouponsModel> listOfApplicableCouponsIdsWithFixedProduct =
        <CouponsModel>[];

    print(
        "listOfApplicableCouponsIdsByMinAmt.length ${listOfApplicableCouponsIdsByMinAmt.length}");
    for (var j = 0; j < ApiService.listOfCoupons.length; j++) {
      for (var i = 0; i < listOfApplicableCouponsIdsByMinAmt.length; i++) {
        if (listOfApplicableCouponsIdsByMinAmt[i] ==
            ApiService.listOfCoupons[j].id!) {
          if (ApiService.listOfCoupons[j].discountType == "fixed_product") {
            listOfApplicableCouponsIdsWithFixedProduct
                .add(ApiService.listOfCoupons[j]);
          }
        }
      }
    }

    print("listOfApplicableCouponsIdsWithFixedProduct");
    listOfApplicableCouponsIdsWithFixedProduct.forEach((element) {
      print("${element}");
    });

    print(
        "listOfApplicableCouponsIdsWithFixedProduct.length ${listOfApplicableCouponsIdsWithFixedProduct.length}");

    print("widget.cartProductIds");
    widget.cartProductIds.forEach((element) {
      print("${element}");
    });

    print("Applicable cartProductIds");

//////////////////////////
    for (var i = 0;
        i < listOfApplicableCouponsIdsWithFixedProduct.length;
        i++) {
      if (isCouponsProductIdsContainCartIds(widget.cartProductIds,
              listOfApplicableCouponsIdsWithFixedProduct[i].productIds) ==
          false) {
        listOfNotApplicableCouponsByPrdtIds
            .add(listOfApplicableCouponsIdsWithFixedProduct[i].id!);
      }
    }
////////////////////////

    print("listOfNotApplicableCouponsByPrdtIds");
    listOfNotApplicableCouponsByPrdtIds.forEach((element) {
      print(element);
    });

    print(
        "listOfNotApplicableCouponsByPrdtIds.length ${listOfNotApplicableCouponsByPrdtIds.length}");
  }

  modifyCouponApplicabilityList() async {
    for (var applicableCoupon in listOfApplicableCoupons) {
      for (var j = 0; j < listOfNotApplicableCouponsByPrdtIds.length; j++) {
        if (applicableCoupon
            .containsKey("${listOfNotApplicableCouponsByPrdtIds[j]}")) {
          applicableCoupon["${listOfNotApplicableCouponsByPrdtIds[j]}"] =
              "Not Applicable";
        }
      }
    }
  }

  bool isCouponsProductIdsContainCartIds(
      List<int> cartProductIds, List<dynamic> couponProductIds) {
    for (var cartProductId in cartProductIds) {
      if (couponProductIds.contains(cartProductId)) {
        return true;
      }
    }
    return false;
  }

  getDiscountType() async {
    for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
      if (ApiService.listOfCoupons[i].amount != null) {
        if (ApiService.listOfCoupons[i].discountType == "fixed_product") {
          discounts.add(
              "₹ ${(double.parse(ApiService.listOfCoupons[i].amount!)).toInt()}");
        } else {
          discounts.add(
              "${(double.parse(ApiService.listOfCoupons[i].amount!)).toInt()}% OFF");
        }
      }
    }

    print("discounts.length ${discounts.length}");
  }

  getCouponsList() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isCouponListLoading = true;
        });
      }
      ApiService.listOfCoupons.clear();
      await ApiService.getCoupons();

      await getDiscountType();
      await checkCouponsApplicability();
      await modifyCouponApplicabilityList();
      await separateApplicableNonApplicable();

      if (mounted) {
        setState(() {
          isCouponListLoading = false;
        });
      }
    }
  }

  TextEditingController _couponController = TextEditingController();

  bool isCouponVerified(String value) {
    for (var applicableCoupon in listOfApplyCoupons) {
      if (value == applicableCoupon.code) {
        return true;
      }
    }

    return false;
  }

  Map<String, dynamic> findDiscountFromCode(String inputCode) {
    Map<String, dynamic> discountData = <String, dynamic>{};
    for (var applicableCoupon in listOfApplyCoupons) {
      if (inputCode == applicableCoupon.code) {
        String discount = "";
        if (applicableCoupon.discountType == "fixed_product") {
          discount = "₹ ${(double.parse(applicableCoupon.amount!)).toInt()}";
        } else {
          discount = "${(double.parse(applicableCoupon.amount!)).toInt()}% OFF";
        }

        discountData = {
          "discountString": discount,
          "discountAmount": (double.parse(applicableCoupon.amount!)).toInt(),
        };

        return discountData;
      }
    }
    return discountData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Coupon"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 255, 227, 230),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _couponController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      if (value == "") {
                        if (mounted) {
                          setState(() {
                            showApplyButton = false;
                          });
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            showApplyButton = true;
                          });
                        }
                      }
                    },
                    validator: (value) {
                      if (value != null) {
                        if (!isCouponVerified(value)) {
                          return "Invalid coupon code. Try other available coupons.";
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: showApplyButton
                          ? GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Map<String, dynamic> discountData =
                                      findDiscountFromCode(
                                          _couponController.text);
                                  Navigator.pop(context, {
                                    "discountString":
                                        discountData["discountString"],
                                    "discountAmount":
                                        discountData["discountAmount"],
                                    "couponcode": _couponController.text
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15.0),
                                width: 45.0,
                                height: 20.0,
                                alignment: Alignment.center,
                                child: Text(
                                  "APPLY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : SizedBox(),
                      // errorText: ,
                      labelText: "Enter coupon code",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ),
              ),
              isCouponListLoading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 247,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Great deal for you!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          ...getListOfApplyCoupons(),
                          // Scrollbar(
                          //   child: Container(
                          //     color: Colors.red,
                          //     padding: EdgeInsets.all(16.0),
                          //     width: MediaQuery.of(context).size.width,
                          //     height: MediaQuery.of(context).size.height - 195,
                          //     child: ListView.builder(
                          //       itemCount: listOfApplyCoupons.length,
                          //       itemBuilder: (context, index) {
                          //         CouponsModel couponsModel =
                          //             listOfApplyCoupons[index];
                          //         return Stack(
                          //           children: [
                          //             Container(
                          //               margin: EdgeInsets.only(bottom: 16.0),
                          //               decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius:
                          //                       BorderRadius.circular(20.0)),
                          //               width: MediaQuery.of(context).size.width,
                          //               height: 150,
                          //               child: Row(
                          //                 children: [
                          //                   Container(
                          //                     padding: EdgeInsets.only(
                          //                         left: 16.0,
                          //                         right: 2.0,
                          //                         top: 16.0,
                          //                         bottom: 16.0),
                          //                     alignment: Alignment.center,
                          //                     height: 150,
                          //                     width: 84,
                          //                     // width: 100,
                          //                     decoration: BoxDecoration(
                          //                         color:
                          //                             //  listOfApplicableCoupons[
                          //                             //                 index][
                          //                             //             "${couponsModel.id}"]! ==
                          //                             //         "Not Applicable"
                          //                             //     ? Colors.grey
                          //                             //     :
                          //                             Theme.of(context)
                          //                                 .primaryColor,
                          //                         borderRadius: BorderRadius.only(
                          //                             topLeft:
                          //                                 Radius.circular(20.0),
                          //                             bottomLeft:
                          //                                 Radius.circular(20.0))),
                          //                     child: RotatedBox(
                          //                       quarterTurns: -1,
                          //                       child: Text(
                          //                         "${discounts[index]} OFF",
                          //                         style: TextStyle(
                          //                             color: Colors.white,
                          //                             fontWeight: FontWeight.bold,
                          //                             fontSize: 23.0),
                          //                         textAlign: TextAlign.center,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.all(16.0),
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment.start,
                          //                           children: [
                          //                             SizedBox(
                          //                               width:
                          //                                   MediaQuery.of(context)
                          //                                           .size
                          //                                           .width -
                          //                                       148,
                          //                               child: Row(
                          //                                 mainAxisAlignment:
                          //                                     MainAxisAlignment
                          //                                         .spaceBetween,
                          //                                 children: [
                          //                                   Text(
                          //                                     couponsModel.code ??
                          //                                         "",
                          //                                     style: TextStyle(
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .bold,
                          //                                         fontSize: 18.0),
                          //                                   ),
                          //                                   GestureDetector(
                          //                                     onTap: () {
                          //                                       if (listOfApplicableCoupons[
                          //                                                   index]
                          //                                               [
                          //                                               "${couponsModel.id}"]! !=
                          //                                           "Not Applicable") {}
                          //                                     },
                          //                                     child: Text(
                          //                                         listOfApplicableCoupons[
                          //                                                 index][
                          //                                             "${couponsModel.id}"]!,
                          //                                         style: TextStyle(
                          //                                             color: listOfApplicableCoupons[index]["${couponsModel.id}"]! ==
                          //                                                     "Not Applicable"
                          //                                                 ? Colors
                          //                                                     .grey
                          //                                                 : Theme.of(context)
                          //                                                     .primaryColor,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .bold,
                          //                                             fontSize:
                          //                                                 17.0)),
                          //                                   )
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               height: 5.0,
                          //                             ),
                          //                             Text(
                          //                               "Valid till ${couponsModel.dateExpires}",
                          //                               style: TextStyle(
                          //                                   fontSize: 15.0),
                          //                             )
                          //                           ],
                          //                         ),
                          //                         SizedBox(
                          //                           child: Text(
                          //                             couponsModel.description ??
                          //                                 "Description;",
                          //                             style: TextStyle(
                          //                                 fontSize: 15.0),
                          //                             maxLines: 2,
                          //                           ),
                          //                           width: MediaQuery.of(context)
                          //                                   .size
                          //                                   .width -
                          //                               148,
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )
                          //                 ],
                          //               ),
                          //               // Rectangle color
                          //             ),
                          //             Positioned(
                          //               top: 55,
                          //               left: -15.0,
                          //               child: Container(
                          //                 width: 30,
                          //                 height: 30,
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   color: Color.fromARGB(255, 255, 227,
                          //                       230), // First circle color
                          //                 ),
                          //               ),
                          //             ),
                          //             Positioned(
                          //               top: 55,
                          //               right: -15.0,
                          //               child: Container(
                          //                 width: 30,
                          //                 height: 30,
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   color: Color.fromARGB(255, 255, 227,
                          //                       230), // First circle color
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                          ///////////////////////////////////////////////////////////
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Other Offers at Tiara by TJ!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          ...getListOfNonApplicableCoupons()
                          // Scrollbar(
                          //   child: Container(
                          //     color: Colors.red,
                          //     padding: EdgeInsets.all(16.0),
                          //     width: MediaQuery.of(context).size.width,
                          //     height: MediaQuery.of(context).size.height - 195,
                          //     child: ListView.builder(
                          //       itemCount: listOfNonApplicableCoupons.length,
                          //       itemBuilder: (context, index) {
                          //         CouponsModel couponsModel =
                          //             listOfNonApplicableCoupons[index];
                          //         return Stack(
                          //           children: [
                          //             Container(
                          //               margin: EdgeInsets.only(bottom: 16.0),
                          //               decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius:
                          //                       BorderRadius.circular(20.0)),
                          //               width: MediaQuery.of(context).size.width,
                          //               height: 150,
                          //               child: Row(
                          //                 children: [
                          //                   Container(
                          //                     padding: EdgeInsets.only(
                          //                         left: 16.0,
                          //                         right: 2.0,
                          //                         top: 16.0,
                          //                         bottom: 16.0),
                          //                     alignment: Alignment.center,
                          //                     height: 150,
                          //                     width: 84,
                          //                     // width: 100,
                          //                     decoration: BoxDecoration(
                          //                         color:
                          //                             // listOfApplicableCoupons[
                          //                             //                 index][
                          //                             //             "${couponsModel.id}"]! ==
                          //                             //         "Not Applicable"
                          //                             //     ?
                          //                             Colors.grey,
                          //                         // : Theme.of(context)
                          //                         //     .primaryColor,
                          //                         borderRadius: BorderRadius.only(
                          //                             topLeft:
                          //                                 Radius.circular(20.0),
                          //                             bottomLeft:
                          //                                 Radius.circular(20.0))),
                          //                     child: RotatedBox(
                          //                       quarterTurns: -1,
                          //                       child: Text(
                          //                         "${discounts[index]} OFF",
                          //                         style: TextStyle(
                          //                             color: Colors.white,
                          //                             fontWeight: FontWeight.bold,
                          //                             fontSize: 23.0),
                          //                         textAlign: TextAlign.center,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.all(16.0),
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment.start,
                          //                           children: [
                          //                             SizedBox(
                          //                               width:
                          //                                   MediaQuery.of(context)
                          //                                           .size
                          //                                           .width -
                          //                                       148,
                          //                               child: Row(
                          //                                 mainAxisAlignment:
                          //                                     MainAxisAlignment
                          //                                         .spaceBetween,
                          //                                 children: [
                          //                                   Text(
                          //                                     couponsModel.code ??
                          //                                         "",
                          //                                     style: TextStyle(
                          //                                         fontWeight:
                          //                                             FontWeight
                          //                                                 .bold,
                          //                                         fontSize: 18.0),
                          //                                   ),
                          //                                   GestureDetector(
                          //                                     onTap: () {
                          //                                       if (listOfApplicableCoupons[
                          //                                                   index]
                          //                                               [
                          //                                               "${couponsModel.id}"]! !=
                          //                                           "Not Applicable") {}
                          //                                     },
                          //                                     child: Text(
                          //                                         listOfApplicableCoupons[index]
                          //                                                     [
                          //                                                     "${couponsModel.id}"] !=
                          //                                                 null
                          //                                             ? listOfApplicableCoupons[
                          //                                                     index]
                          //                                                 [
                          //                                                 "${couponsModel.id}"]!
                          //                                             : "",
                          //                                         style: TextStyle(
                          //                                             color:
                          //                                                 //listOfApplicableCoupons[index]["${couponsModel.id}"]! ==
                          //                                                 //             "Not Applicable"
                          //                                                 //         ?
                          //                                                 Colors.grey
                          //                                             // : Theme.of(context)
                          //                                             //     .primaryColor
                          //                                             ,
                          //                                             fontWeight: FontWeight.bold,
                          //                                             fontSize: 17.0)),
                          //                                   )
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                             SizedBox(
                          //                               height: 5.0,
                          //                             ),
                          //                             Text(
                          //                               "Valid till ${couponsModel.dateExpires}",
                          //                               style: TextStyle(
                          //                                   fontSize: 15.0),
                          //                             )
                          //                           ],
                          //                         ),
                          //                         SizedBox(
                          //                           child: Text(
                          //                             couponsModel.description ??
                          //                                 "Description;",
                          //                             style: TextStyle(
                          //                                 fontSize: 15.0),
                          //                             maxLines: 2,
                          //                           ),
                          //                           width: MediaQuery.of(context)
                          //                                   .size
                          //                                   .width -
                          //                               148,
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )
                          //                 ],
                          //               ),
                          //               // Rectangle color
                          //             ),
                          //             Positioned(
                          //               top: 55,
                          //               left: -15.0,
                          //               child: Container(
                          //                 width: 30,
                          //                 height: 30,
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   color: Color.fromARGB(255, 255, 227,
                          //                       230), // First circle color
                          //                 ),
                          //               ),
                          //             ),
                          //             Positioned(
                          //               top: 55,
                          //               right: -15.0,
                          //               child: Container(
                          //                 width: 30,
                          //                 height: 30,
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   color: Color.fromARGB(255, 255, 227,
                          //                       230), // First circle color
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getListOfApplyCoupons() {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < listOfApplyCoupons.length; i++) {
      CouponsModel couponsModel = listOfApplyCoupons[i];
      String discount = "";
      if (couponsModel.discountType == "fixed_product") {
        discount = "₹ ${(double.parse(couponsModel.amount!)).toInt()}";
      } else {
        discount = "${(double.parse(couponsModel.amount!)).toInt()}% OFF";
      }

      widgets.add(Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 2.0, top: 16.0, bottom: 16.0),
                  alignment: Alignment.center,
                  height: 150,
                  width: 84,
                  // width: 100,
                  decoration: BoxDecoration(
                      color:
                          //  listOfApplicableCoupons[
                          //                 index][
                          //             "${couponsModel.id}"]! ==
                          //         "Not Applicable"
                          //     ? Colors.grey
                          //     :
                          Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0))),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      discount,
                      // "${couponsModel.amount} OFF",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 148,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  couponsModel.code ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, {
                                      "discountString": discount,
                                      "discountAmount":
                                          (double.parse(couponsModel.amount!))
                                              .toInt(),
                                      "couponcode": couponsModel.code
                                    });
                                  },
                                  child: Text("Apply",
                                      style: TextStyle(
                                          color:
                                              // listOfApplicableCoupons[i]
                                              //             ["${couponsModel.id}"]! ==
                                              //         "Not Applicable"
                                              //     ? Colors.grey
                                              //     :
                                              Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19.0)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Valid till ${couponsModel.dateExpires}",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      ),
                      SizedBox(
                        child: Text(
                          couponsModel.description ?? "Description;",
                          style: TextStyle(fontSize: 15.0),
                          maxLines: 2,
                        ),
                        width: MediaQuery.of(context).size.width - 148,
                      )
                    ],
                  ),
                )
              ],
            ),
            // Rectangle color
          ),
          Positioned(
            top: 55,
            left: -15.0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 227, 230), // First circle color
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: -15.0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 227, 230), // First circle color
              ),
            ),
          ),
        ],
      ));
    }
    return widgets;
  }

  List<Widget> getListOfNonApplicableCoupons() {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < listOfNonApplicableCoupons.length; i++) {
      CouponsModel couponsModel = listOfNonApplicableCoupons[i];
      widgets.add(Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 2.0, top: 16.0, bottom: 16.0),
                  alignment: Alignment.center,
                  height: 150,
                  width: 84,
                  // width: 100,
                  decoration: BoxDecoration(
                      color:
                          // listOfApplicableCoupons[
                          //                 index][
                          //             "${couponsModel.id}"]! ==
                          //         "Not Applicable"
                          //     ?
                          Colors.grey,
                      // : Theme.of(context)
                      //     .primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0))),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      couponsModel.discountType == "fixed_product"
                          ? "₹ ${(double.parse(couponsModel.amount!)).toInt()} OFF"
                          : "${(double.parse(couponsModel.amount!)).toInt()}% OFF",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 148,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  couponsModel.code ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Text("Not Applicable",
                                    style: TextStyle(
                                        color:
                                            //listOfApplicableCoupons[index]["${couponsModel.id}"]! ==
                                            //             "Not Applicable"
                                            //         ?
                                            Colors.grey
                                        // : Theme.of(context)
                                        //     .primaryColor
                                        ,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Valid till ${couponsModel.dateExpires}",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      ),
                      SizedBox(
                        child: Text(
                          couponsModel.description ?? "Description;",
                          style: TextStyle(fontSize: 15.0),
                          maxLines: 2,
                        ),
                        width: MediaQuery.of(context).size.width - 148,
                      )
                    ],
                  ),
                )
              ],
            ),
            // Rectangle color
          ),
          Positioned(
            top: 55,
            left: -15.0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 227, 230), // First circle color
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: -15.0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 227, 230), // First circle color
              ),
            ),
          ),
        ],
      ));
    }
    return widgets;
  }
}
