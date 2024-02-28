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
  List<String> listOfApplicability = <String>[];

  List<int> listOfApplicableCouponsIdsByMinAmt = <int>[];
  List<int> listOfNotApplicableCouponsByPrdtIds = <int>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCouponsList();

    checkCouponsApplicability();
  }

  checkCouponsApplicability() {
    for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
      if (ApiService.listOfCoupons[i].minimumAmount != null) {
        if (double.parse(ApiService.listOfCoupons[i].minimumAmount!) >
            widget.cartTotal) {
          listOfApplicability.add("Not applicable");
        } else {
          listOfApplicability.add("Applicable");
          listOfApplicableCouponsIdsByMinAmt
              .add(ApiService.listOfCoupons[i].id!); //TODO: store model not id
        }
      }
    }

    print("listOfApplicableCouponsIdsByMinAmt");
    listOfApplicableCouponsIdsByMinAmt.forEach((element) {
      print("${element}");
    });

    List<int> listOfApplicableCouponsIdsWithFixedProduct = <int>[];

    print(
        "listOfApplicableCouponsIdsByMinAmt.length ${listOfApplicableCouponsIdsByMinAmt.length}");
    for (var j = 0; j < ApiService.listOfCoupons.length; j++) {
      for (var i = 0; i < listOfApplicableCouponsIdsByMinAmt.length; i++) {
        print(
            "listOfApplicableCouponsIdsByMinAmt[i] == ApiService.listOfCoupons[j].id! ${listOfApplicableCouponsIdsByMinAmt[i] == ApiService.listOfCoupons[j].id!}");
        if (listOfApplicableCouponsIdsByMinAmt[i] ==
            ApiService.listOfCoupons[j].id!) {
          print(
              "ApiService.listOfCoupons[j].discountType == fixed_product ${ApiService.listOfCoupons[j].discountType == "fixed_product"}");
          if (ApiService.listOfCoupons[j].discountType == "fixed_product") {
            listOfApplicableCouponsIdsWithFixedProduct
                .add(ApiService.listOfCoupons[j].id!);

            // for (var k = 0; k < ApiService.listOfCoupons[j].productIds.length; k++) {
            //   for (var l = 0; l < widget.cartProductIds.length; l++) {

            //      if (ApiService.listOfCoupons[j].productIds[k] == widget.cartProductIds[l]) {

            //     listOfApplicableCouponsByPrdtIds.add(listOfApplicableCouponsIdsByMinAmt[i]);
            //   }
            //   }

            // }
          }
        }
      }
    }

    // for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
    //   for (var j = 0; j < listOfApplicableCouponsIdsWithFixedProduct.length;j++) {
    //     //print("listOfApplicableCouponsIdsByMinAmt[i] == ApiService.listOfCoupons[j].id! ${listOfApplicableCouponsIdsByMinAmt[i] == ApiService.listOfCoupons[j].id!}");
    //     if (listOfApplicableCouponsIdsWithFixedProduct[j] ==
    //         ApiService.listOfCoupons[i].id!) {
    // for (var k = 0; k < ApiService.listOfCoupons[j].productIds.length;k++) {
    //   for (var l = 0; l < widget.cartProductIds.length; l++) {
    //     if (ApiService.listOfCoupons[j].productIds[k]) {
    //      // listOfApplicableCouponsByPrdtIds.add(value)
    //     }
    //   }

    // }

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

int trueCounter = 0;
    print("Applicable cartProductIds");
    // for (var coupon in ApiService.listOfCoupons) {
    //   if (listOfApplicableCouponsIdsWithFixedProduct.contains(coupon.id!)) {
    //     for (var cartProductId in widget.cartProductIds) {
    //       if (coupon.productIds.contains(cartProductId) == false) {
    //         listOfNotApplicableCouponsByPrdtIds.add(coupon.id!);
    //       } else {
    //         print("cartProductId ${cartProductId}");
    //       }
    //     }
    //   }
    // }
//////////////////////////
    // for (var i = 0; i < listOfApplicableCouponsIdsWithFixedProduct.length; i++) {
    //   listOfApplicableCouponsIdsWithFixedProduct[i].productid and iterate over it
    // }
////////////////////////
    //     }
    //   }
    // }

    // print(
    //     "listOfNotApplicableCouponsByPrdtIds.length ${listOfNotApplicableCouponsByPrdtIds.length}");

    print(
        "listOfNotApplicableCouponsByPrdtIds.length ${listOfNotApplicableCouponsByPrdtIds.length}");
  }

  getDiscountType() {
    for (var i = 0; i < ApiService.listOfCoupons.length; i++) {
      if (ApiService.listOfCoupons[i].amount != null) {
        if (ApiService.listOfCoupons[i].discountType == "fixed_product") {
          discounts.add("₹ ${(double.parse(ApiService.listOfCoupons[i].amount!)).toInt()}");
        } else {
          discounts.add("${(double.parse(ApiService.listOfCoupons[i].amount!)).toInt()} %");
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

      getDiscountType();

      if (mounted) {
        setState(() {
          isCouponListLoading = false;
        });
      }
    }
  }

  TextEditingController _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Coupon"),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 227, 230),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _couponController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  return ValidationHelper.nullOrEmptyString(value);
                },
                decoration: const InputDecoration(
                  // errorText: ,
                  labelText: "Enter coupon code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Other Offers at Tiara by TJ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  isCouponListLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 247,
                          child: ListView.builder(
                            itemCount: ApiService.listOfCoupons.length,
                            itemBuilder: (context, index) {
                              CouponsModel couponsModel =
                                  ApiService.listOfCoupons[index];
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 16.0,
                                              right: 2.0,
                                              top: 16.0,
                                              bottom: 16.0),
                                          alignment: Alignment.center,
                                          height: 150,
                                          // width: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  bottomLeft:
                                                      Radius.circular(20.0))),
                                          child: RotatedBox(
                                            quarterTurns: -1,
                                            child: Text(
                                              "${discounts[index]} OFF",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            148,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          couponsModel.code ??
                                                              "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.0),
                                                        ),
                                                        Text(
                                                            listOfApplicability[
                                                                index],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.0))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    "Valid till ${couponsModel.dateExpires}",
                                                    style: TextStyle(
                                                        fontSize: 15.0),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  couponsModel.description ??
                                                      "Description;",
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                  maxLines: 2,
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    148,
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
                                        color: Color.fromARGB(255, 255, 227,
                                            230), // First circle color
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
                                        color: Color.fromARGB(255, 255, 227,
                                            230), // First circle color
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
