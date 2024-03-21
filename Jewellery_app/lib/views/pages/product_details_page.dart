import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/reviews_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/customize_options_provider.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/pages/reviews_page.dart';

import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/pages/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/model/choice_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';

import 'package:Tiara_by_TJ/views/widgets/button_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/choice_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/label_widget.dart';
import 'package:Tiara_by_TJ/views/widgets/whole_carousel_slider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailsPage extends StatefulWidget {
  final ProductsModel productsModel;

  const ProductDetailsPage({super.key, required this.productsModel});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductsModel productsModel;

  bool backordersAllowed = false;

  bool isReviewLoading = false;

  List<ChoiceModel> listOfChoiceModel = <ChoiceModel>[];
  Map<String, String> modifiedPurities = <String, String>{};

  @override
  void initState() {
    super.initState();
    productsModel = widget.productsModel;
    backordersAllowed = productsModel.backordersAllowed ?? false;

    getReviews();

    final customizationOptionsProvider =
        Provider.of<CustomizeOptionsProvider>(context, listen: false);
    //List<ChoiceModel> listOfChoiceModel = <ChoiceModel>[];

    // List<MetaDatum> metaList = <MetaDatum>[];

    List<String?> keys = <String?>[];

    if (productsModel.metaData != null) {
      print("METADATA IS NOT NULL");
      for (var i = 0; i < productsModel.metaData!.length; i++) {
        keys.add(productsModel.metaData![i].key);
      }

      print("METADATA KEYS ${keys}");

      bool iskeysContainsGoldkt = keys.contains("gold_kt");
      print("METADATA iskeysContainsGoldkt ${iskeysContainsGoldkt}");

      bool iskeysContainsSilverPurity = keys.contains("silver_purity");
      print("iskeysContainsSilverPurity KEYS ${iskeysContainsSilverPurity}");

      bool iskeysContainsPlatiniumPurity = keys.contains("platinium_purity");
      print(
          "METADATA iskeysContainsPlatiniumPurity ${iskeysContainsPlatiniumPurity}");

      List<String> purities =
          customizationOptionsProvider.customizeOptionsdata["purities"];

      print(
          "customizationOptionsProvider.customizeOptionsdata['enable_kt'] ${customizationOptionsProvider.customizeOptionsdata["enable_kt"] == "1"}");
      if (customizationOptionsProvider.customizeOptionsdata["enable_kt"] ==
          "1") {
        if (iskeysContainsPlatiniumPurity &&
            iskeysContainsGoldkt &&
            iskeysContainsSilverPurity) {
          <ChoiceModel>[];
        } else if (iskeysContainsPlatiniumPurity &&
            iskeysContainsGoldkt == false &&
            iskeysContainsSilverPurity == false) {
          for (var i = 0; i < productsModel.metaData!.length; i++) {
            if (productsModel.metaData![i].key == "platinium_purity") {
              if (productsModel.metaData![i].value == "") {
                <ChoiceModel>[];
              } else {
                for (var i = 0; i < purities.length; i++) {
                  switch (purities[i]) {
                    case "375":
                      modifiedPurities["850"] = "850";
                      break;
                    case "583":
                      modifiedPurities["900"] = "900";
                      break;
                    case "750":
                      modifiedPurities["950"] = "950";
                      break;

                    default:
                      print("New purity added");
                  }
                }

                List<String> options = <String>[];

                options.addAll(modifiedPurities.values);

                listOfChoiceModel.add(ChoiceModel(
                  label: "Select Metal",
                  options: options,
                  selectedOption: getPlatiniumSelectedOption(
                          productsModel.metaData![i].value.toString()) ??
                      "Select",
                ));
              }
            }
          }
        } else if (iskeysContainsPlatiniumPurity == false &&
            iskeysContainsGoldkt &&
            iskeysContainsSilverPurity == false) {
          for (var i = 0; i < productsModel.metaData!.length; i++) {
            if (productsModel.metaData![i].key == "gold_kt") {
              if (productsModel.metaData![i].value == "") {
                <ChoiceModel>[];
              } else {
                for (var i = 0; i < purities.length; i++) {
                  switch (purities[i]) {
                    case "375":
                      modifiedPurities["375"] = "9KT";
                      break;
                    case "583":
                      modifiedPurities["583"] = "14KT";
                      break;
                    case "750":
                      modifiedPurities["750"] = "18KT";
                      break;
                    case "916":
                      modifiedPurities["916"] = "22KT";
                      break;
                    case "995":
                      modifiedPurities["995"] = "24KT";
                      break;
                    case "999":
                      modifiedPurities["999"] = "24KT";
                      break;
                    case "999.99":
                      modifiedPurities["999.99"] = "24KT";
                      break;
                    default:
                      print("New purity");
                  }
                }

                List<String> options = <String>[];

                options.addAll(modifiedPurities.values);

                print("options $options");

                final goldSelectedOption = getGoldSelectedOption(
                        productsModel.metaData![i].value.toString()) ??
                    "Select";

                print("goldSelectedOption $goldSelectedOption");

                listOfChoiceModel.add(ChoiceModel(
                  label: "Select Metal",
                  options: options,
                  selectedOption: getGoldSelectedOption(
                          productsModel.metaData![i].value.toString()) ??
                      "Select",
                ));
              }
            }
          }
        } else if (iskeysContainsPlatiniumPurity == false &&
            iskeysContainsGoldkt == false &&
            iskeysContainsSilverPurity) {
          for (var i = 0; i < productsModel.metaData!.length; i++) {
            if (productsModel.metaData![i].key == "silver_purity") {
              if (productsModel.metaData![i].value == "") {
                <ChoiceModel>[];
              } else {
                for (var i = 0; i < purities.length; i++) {
                  switch (purities[i]) {
                    case "650":
                      modifiedPurities["650"] = "650";
                      break;
                    case "750":
                      modifiedPurities["750"] = "750";
                      break;
                    case "850":
                      modifiedPurities["850"] = "850";
                      break;
                    case "925":
                      modifiedPurities["925"] = "Sterling";
                      break;
                    case "995":
                      modifiedPurities["995"] = "Fine";
                      break;
                    case "999":
                      modifiedPurities["999"] = "Fine";
                      break;

                    default:
                      print("New purity");
                  }
                }

                List<String> options = <String>[];

                options.addAll(modifiedPurities.values);

                listOfChoiceModel.add(ChoiceModel(
                  label: "Select Metal",
                  options: options,
                  selectedOption: getSilverSelectedOption(
                          productsModel.metaData![i].value.toString()) ??
                      "Select",
                ));
              }
            }
          }
        } else if (iskeysContainsPlatiniumPurity &&
            iskeysContainsGoldkt &&
            iskeysContainsSilverPurity == false) {
          <ChoiceModel>[];
        } else if (iskeysContainsPlatiniumPurity == false &&
            iskeysContainsGoldkt &&
            iskeysContainsSilverPurity) {
          <ChoiceModel>[];
        } else if (iskeysContainsPlatiniumPurity &&
            iskeysContainsGoldkt == false &&
            iskeysContainsSilverPurity) {
          <ChoiceModel>[];
        }

        // listOfChoiceModel.add(ChoiceModel(
        //   label: "Select Metal",
        //   options: ,
        //   selectedOption: "18KT",
        // ));
      } else {
        <ChoiceModel>[];
      }
    }

    print("METADATA IS NULL");

    customizationOptionsProvider.customizeOptionsdata["enable_color"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Select Color",
            options:
                customizationOptionsProvider.customizeOptionsdata["colors"],
            selectedOption:
                customizationOptionsProvider.customizeOptionsdata["colors"][0],
          ))
        : <ChoiceModel>[];

    customizationOptionsProvider.customizeOptionsdata["enable_color"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Select Size",
            options: [
              "2.02 - Make to Order",
              "2.04 - Make to Order",
              "2.06 - Make to Order"
            ],
            selectedOption: "2.02 - Make to Order",
          ))
        : <ChoiceModel>[];

    customizationOptionsProvider.customizeOptionsdata["enable_diamond"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Type of Diamond",
            options: customizationOptionsProvider
                .customizeOptionsdata["diamond_purities"],
            selectedOption: customizationOptionsProvider
                .customizeOptionsdata["diamond_purities"][0],
          ))
        : <ChoiceModel>[];

    customizationOptionsProvider.customizeOptionsdata["enable_color"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Select Quality",
            options: ["VVS-EF"],
            selectedOption: "VVS-EF",
          ))
        : <ChoiceModel>[];
  }

  Future<void> getReviews() async {
    bool isThereInternet = await ApiService.checkInternetConnection(context);
    if (isThereInternet) {
      if (mounted) {
        setState(() {
          isReviewLoading = true;
        });
      }
      ApiService.reviewsList.clear();
      await ApiService.getReviews(productsModel.id.toString());
      if (mounted) {
        setState(() {
          isReviewLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    final customizationOptionsProvider =
        Provider.of<CustomizeOptionsProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    print("deviceWidth / 20 ${deviceWidth / 31}");
    return Scaffold(
      appBar: AppBar(title: Text("Details"), actions: <Widget>[
        Container(
          width: (deviceWidth / 16) + 4,
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            badgeContent:
                Consumer<WishlistProvider>(builder: (context, value, child) {
              print("LENGTH OF FAV: ${value.favProductIds}");
              return Text(
                value.favProductIds.length.toString(),
                style: TextStyle(
                    color: Colors.white, fontSize: (deviceWidth / 31) - 1),
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
          width: 24,
        ),
        Container(
          width: (deviceWidth / 16) + 4,
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) => Text(
                      value.cart.length.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (deviceWidth / 31) - 1),
                    )),
            child: IconButton(
              onPressed: () {
                print("CART CLICKED");
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: const Icon(Icons.shopping_cart),
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
      ]),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Column(children: [
          WholeCarouselSlider(listOfProductImage: productsModel.images),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 5.0, bottom: 110.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          productsModel.salePrice == ""
                              ? Text(
                                  productsModel.regularPrice != ""
                                      ? "₹ ${productsModel.regularPrice ?? 20000}"
                                      : "₹ 0.0",
                                  // productsModel.regularPrice ??
                                  //     "20,000",
                                  style: TextStyle(
                                      fontSize: (deviceWidth / 36) + 4,
                                      fontWeight: FontWeight.bold))
                              : Row(
                                  children: [
                                    Text(
                                        productsModel.salePrice == ""
                                            ? "₹ 10,000"
                                            : "₹ ${productsModel.salePrice ?? 10000}",
                                        style: TextStyle(
                                            fontSize: (deviceWidth / 36) + 4,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      productsModel.regularPrice != ""
                                          ? "₹ ${productsModel.regularPrice ?? 20000}"
                                          : "₹ 0.0",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                          Consumer<WishlistProvider>(
                              builder: (context, value, child) {
                            print("LENGTH OF FAV: ${value.favProductIds}");
                            print("deviceWidth / 23 ${deviceWidth / 16}");
                            return IconButton(
                                icon: Icon(
                                  value.favProductIds.contains(productsModel.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: deviceWidth > 600
                                      ? deviceWidth / 23
                                      : deviceWidth / 16,
                                ),
                                onPressed: () {
                                  print("PRESSED");
                                  if (value.favProductIds
                                      .contains(productsModel.id)) {
                                    value.removeFromWishlist(productsModel.id!);
                                    print("Product is removed from wishlist");
                                  } else {
                                    value.addToWishlist(productsModel.id!);
                                    print("Product is added to wishlist");
                                  }
                                });
                          })
                        ]),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        color: const Color(0xfff1f7eb),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: backordersAllowed
                            ? LabelWidget(
                                label: "Available on backorder",
                                color: Color(0xff85BA60),
                                fontSize: (deviceWidth / 36) + 4,
                              )
                            : LabelWidget(
                                label: "Unavailable on backorder",
                                color: Color(0xff85BA60),
                                fontSize: (deviceWidth / 36) + 4,
                              )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    customizationOptionsProvider
                                .customizeOptionsdata["enable_everything"] ==
                            "1"
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: customizationOptionsProvider
                                                .customizeOptionsdata[
                                            "enable_color"] !=
                                        "0" &&
                                    customizationOptionsProvider
                                                .customizeOptionsdata[
                                            "enable_diamond"] !=
                                        "0" &&
                                    customizationOptionsProvider
                                                .customizeOptionsdata[
                                            "enable_kt"] !=
                                        "0"
                                ? MediaQuery.of(context).size.width > 600
                                    ? 300
                                    : MediaQuery.of(context).size.height / 4.2
                                : 0.0,
                            child: Scrollbar(
                              child: GridView.builder(
                                  itemCount: listOfChoiceModel.length,
                                   physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1.9,
                                          crossAxisCount: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? 3
                                              : 2,
                                          crossAxisSpacing: 1.0,
                                          mainAxisSpacing: 15.0),
                                  itemBuilder: ((context, index) {
                                    return ChoiceWidget(
                                      choiceModel: listOfChoiceModel[index],
                                      fromCart: false,
                                    );
                                  })),
                            ),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    LabelWidget(
                      label: Constants.description_label,
                      fontSize: (deviceWidth / 36) + 5,
                    ),
                    HtmlWidget(productsModel.description ??
                        Constants.product_description, textStyle: TextStyle(fontWeight: FontWeight.normal),),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "SKU:",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          productsModel.sku ?? "12007AN",
                          style: TextStyle(
                              fontSize: (deviceWidth / 36) + 3,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        Text(
                          "Category:",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          productsModel.categories != null
                              ? productsModel.categories![0].name ?? "Jewellery"
                              : "Jewellery",
                          style: TextStyle(
                              fontSize: (deviceWidth / 36) + 3,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Tags:",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    productsModel.tags == null
                        ? Text(
                            "Jewellery",
                            style: TextStyle(
                                fontSize: (deviceWidth / 36) + 3,
                                fontWeight: FontWeight.normal),
                          )
                        : SizedBox(
                            height: deviceWidth > 600 ? 30.0 : 20.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: productsModel.tags?.length,
                              
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    productsModel.tags?[index].name ??
                                        "Category ",
                                    style: TextStyle(
                                        fontSize: (deviceWidth / 36) + 3,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Customer Reviews",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print(
                            "customerData.isNotEmpty ${customerProvider.customerData.isNotEmpty}");
                        if (customerProvider.customerData.length != 0) {
                          bool? isReviewUploaded = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WriteReviewPage(
                                      productsModel: productsModel)));

                          if (isReviewUploaded != null && isReviewUploaded) {
                            if (mounted) {
                              setState(() {
                                getReviews();
                              });
                            }
                          }
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(isComeFromCart: false),
                              ));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "WRITE A REVIEW",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    isReviewLoading
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 3.0,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        : ApiService.reviewsList.isNotEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 3.0,
                                width: MediaQuery.of(context).size.width,
                                child: Scrollbar(
                                  child: ListView.separated(
                                      itemCount:
                                          ApiService.reviewsList.length < 3
                                              ? ApiService.reviewsList.length
                                              : 3,
                                      itemBuilder: (context, index) {
                                        ReviewsModel reviewsModel =
                                            ApiService.reviewsList[index];

                                        return Container(
                                          color: Colors.yellow,
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.grey,
                                                      size: deviceWidth > 600
                                                          ? 45.0
                                                          : 27.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              reviewsModel
                                                                      .reviewer ??
                                                                  "Reviewer",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text(
                                                            reviewsModel.verified !=
                                                                    null
                                                                ? reviewsModel
                                                                            .verified! ==
                                                                        true
                                                                    ? "(Verified Purchase)"
                                                                    : ""
                                                                : "",
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: List.generate(
                                                            5, (index) {
                                                          return Icon(
                                                            index <
                                                                    (reviewsModel
                                                                            .rating ??
                                                                        0)
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: Colors.amber,
                                                            size: deviceWidth >
                                                                    600
                                                                ? 33.0
                                                                : 22.0,
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              HtmlWidget(
                                                // reviewsModel.review ??
                                                "<p>Reviewwwwwwwwwwwwwwwwwwwwwwwwwwwwwww</p>",
                                                textStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                              thickness: 1.0,
                                              color: Colors.grey)),
                                ),
                              )
                            : Text(
                                "Be the first to review this product",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                    ApiService.reviewsList.length > 3
                        ? InkWell(
                            child: Text(
                              "Read all ${ApiService.reviewsList.length} Reviews",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: deviceWidth > 600 ? 26.0 : 16.0,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewsPage(
                                      productsModel: productsModel,
                                    ),
                                  ));
                            },
                          )
                        : SizedBox()
                  ])),
        ])),
      ),
      bottomSheet: BottomSheet(
        constraints: BoxConstraints.expand(width: deviceWidth, height: 100),
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                productsModel.salePrice != ""
                    ? Row(
                        children: [
                          Text(
                              productsModel.salePrice == ""
                                  ? "₹ 10,000"
                                  : "₹ ${productsModel.salePrice ?? 10000}",
                              style: Theme.of(context).textTheme.headline1),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                              productsModel.regularPrice != ""
                                  ? "₹ ${productsModel.regularPrice ?? 20000}"
                                  : "₹ 0.0",
                              // productsModel.regularPrice ??
                              //     "20,000",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        ],
                        //child:
                      )
                    : Text(
                        productsModel.regularPrice != ""
                            ? "₹ ${productsModel.regularPrice ?? 20000}"
                            : "₹ 0.0",
                        // productsModel.regularPrice ??
                        //     "20,000",
                        style: Theme.of(context).textTheme.headline1),

                // Text(
                //   productsModel.regularPrice != ""
                //       ? "₹ ${productsModel.regularPrice}" ?? "₹ 20000"
                //       : "₹ 0.0",
                //   style:
                //       const TextStyle(decoration: TextDecoration.lineThrough),
                // ),

                ////////////////

                SizedBox(
                    width: MediaQuery.of(context).size.width > 600
                        ? MediaQuery.of(context).size.width / 3.7
                        : MediaQuery.of(context).size.width / 2,
                    child: GestureDetector(
                      onTap: () async {
                        print("CART PRESSED");
                        cartProvider.addToCartId(productsModel.id!);
                        print("CART IDS : ${cartProvider.cartProductIds}");

                        cartProvider.addToCart(CartProductModel(
                            cartProductid: productsModel.id,
                            price: productsModel.regularPrice != ""
                                ? productsModel.regularPrice ?? "20000"
                                : "0.0",
                            productName: productsModel.name ?? "Jewellery",
                            quantity: "1",
                            size: 5,
                            deliveryDate: DateHelper.getCurrentDateInWords(),
                            imageUrl: productsModel.images.isEmpty
                                ? Constants.defaultImageUrl
                                : productsModel.images[0].src ??
                                    Constants.defaultImageUrl,
                            sku: productsModel.sku ?? "ABC",
                            imageId: productsModel.images.isNotEmpty
                                ? productsModel.images[0].id
                                : 0));

                        print("Product is added to cart");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartPage()));
                      },
                      child: Container(
                        height: 100 - 50,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Constants.cart_btn_text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width > 600
                                        ? 23
                                        : 17.0,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Image.asset(
                              "assets/images/grocery_store.png",
                              // width: 17.0,
                              // height: 17.0,
                              height: (deviceWidth / 19),
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )

                    // ButtonWidget(
                    //     imagePath: "assets/images/grocery_store.png",
                    //     btnString: Constants.cart_btn_text,
                    //     onTap: () async {
                    //       print("CART PRESSED");
                    //       cartProvider.addToCartId(productsModel.id!);
                    //       print("CART IDS : ${cartProvider.cartProductIds}");

                    //       // if (customerProvider.customerData.isNotEmpty ||
                    //       //     customerProvider.customerData.length != 0) {
                    //       //   print(
                    //       //       "customerData.isNotEmpty ${customerProvider.customerData.isNotEmpty}");

                    //       //   List<CartProductModel> cart = <CartProductModel>[];
                    //       //   cart.add(CartProductModel(
                    //       //       cartProductid: productsModel.id,
                    //       //       price: productsModel.regularPrice != ""
                    //       //           ? productsModel.regularPrice ?? "20000"
                    //       //           : "0.0",
                    //       //       productName: productsModel.name ?? "Jewellery",
                    //       //       quantity: "1",
                    //       //       size: 5,
                    //       //       deliveryDate: DateHelper.getCurrentDateInWords(),
                    //       //       imageUrl: productsModel.images.isEmpty
                    //       //           ? Constants.defaultImageUrl
                    //       //           : productsModel.images[0].src ??
                    //       //               Constants.defaultImageUrl,
                    //       //       sku: productsModel.sku ?? "ABC",
                    //       //       imageId: productsModel.images.isNotEmpty
                    //       //           ? productsModel.images[0].id
                    //       //           : 0));

                    //       //   customerProvider.customerData[0]["cartList"] = cart;
                    //       // }

                    //       cartProvider.addToCart(CartProductModel(
                    //           cartProductid: productsModel.id,
                    //           price: productsModel.regularPrice != ""
                    //               ? productsModel.regularPrice ?? "20000"
                    //               : "0.0",
                    //           productName: productsModel.name ?? "Jewellery",
                    //           quantity: "1",
                    //           size: 5,
                    //           deliveryDate: DateHelper.getCurrentDateInWords(),
                    //           imageUrl: productsModel.images.isEmpty
                    //               ? Constants.defaultImageUrl
                    //               : productsModel.images[0].src ??
                    //                   Constants.defaultImageUrl,
                    //           sku: productsModel.sku ?? "ABC",
                    //           imageId: productsModel.images.isNotEmpty
                    //               ? productsModel.images[0].id
                    //               : 0));

                    //       print("Product is added to cart");
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => CartPage()));
                    //     }),
                    )
              ],
            ),
          );
        },
      ),
    );
  }

//   List<Widget> showFilterOptionsList(
//       {required CustomizeOptionsProvider customizationOptionsProvider}) {
//     List<Widget> widgets = <Widget>[];

//     if (customizationOptionsProvider
//             .customizeOptionsdata["enable_everything"] ==
//         "1") {
// // GridView.builder(
// //     itemCount: listOfChoiceModel.length,
// //     gridDelegate:
// //         SliverGridDelegateWithFixedCrossAxisCount(
// //             childAspectRatio: 1.9,
// //             crossAxisCount: MediaQuery.of(context)
// //                         .size
// //                         .width >
// //                     600
// //                 ? 3
// //                 : 2,
// //             crossAxisSpacing: 1.0,
// //             mainAxisSpacing: 15.0),
// //     itemBuilder: ((context, index) {
// //       return ChoiceWidget(
// //         choiceModel: listOfChoiceModel[index],
// //         fromCart: false,
// //       );
// //     }))
// //                         : SizedBox(),
//       widgets.addAll(listOfChoiceModel.map((choiceModel) {
//         return ChoiceWidget(
//           choiceModel: choiceModel,
//           fromCart: false,
//         );
//       }).toList());
//     } else {
//       widgets.add(SizedBox());
//     }
//     return widgets;
//   }

  String? getGoldSelectedOption(String purityValue) {
    String? selectedoption = "";
    print(" modifiedPurities[583] ${modifiedPurities["583"]}");
    switch (purityValue) {
      case "375":
        selectedoption = modifiedPurities["375"];
        break;
      case "583":
        selectedoption = modifiedPurities["583"];
        break;
      case "750":
        selectedoption = modifiedPurities["750"];
        break;
      case "916":
        selectedoption = modifiedPurities["916"];
        break;
      case "995":
        selectedoption = modifiedPurities["995"];
        break;
      case "999":
        selectedoption = modifiedPurities["999"];
        break;
      case "999.99":
        selectedoption = modifiedPurities["999.99"];
        break;
      default:
        print("New purity");
    }
    return selectedoption;
  }

  String? getPlatiniumSelectedOption(String purityValue) {
    String? selectedoption = "";
    switch (purityValue) {
      case "850":
        selectedoption = modifiedPurities["850"];
        break;
      case "900":
        selectedoption = modifiedPurities["900"];
        break;
      case "950":
        selectedoption = modifiedPurities["950"];
        break;

      default:
        print("New purity");
    }
    return selectedoption;
  }

  String? getSilverSelectedOption(String purityValue) {
    String? selectedoption = "";
    switch (purityValue) {
      case "650":
        selectedoption = modifiedPurities["650"];
        break;
      case "750":
        selectedoption = modifiedPurities["750"];
        break;
      case "850":
        selectedoption = modifiedPurities["850"];
        break;
      case "925":
        selectedoption = modifiedPurities["925"];
        break;
      case "995":
        selectedoption = modifiedPurities["995"];
        break;
      case "999":
        selectedoption = modifiedPurities["999"];
        break;

      default:
        print("New purity");
    }
    return selectedoption;
  }
}
