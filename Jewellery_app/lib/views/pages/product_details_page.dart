import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/model/reviews_model.dart';
import 'package:Tiara_by_TJ/providers/customer_provider.dart';
import 'package:Tiara_by_TJ/providers/customize_options_provider.dart';
import 'package:Tiara_by_TJ/views/pages/login_page.dart';
import 'package:Tiara_by_TJ/views/pages/reviews_page.dart';

import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
import 'package:Tiara_by_TJ/views/pages/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
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

  @override
  void initState() {
    super.initState();
    productsModel = widget.productsModel;
    backordersAllowed = productsModel.backordersAllowed ?? false;

    getReviews();
  }

  Future<void> getReviews() async {
    setState(() {
      isReviewLoading = true;
    });
    ApiService.reviewsList.clear();
    await ApiService.getReviews(productsModel.id.toString());
    setState(() {
      isReviewLoading = false;
    });
  }

  // bool isReviewUploaded = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishListProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);

    final customizationOptionsProvider =
        Provider.of<CustomizeOptionsProvider>(context, listen: false);

    List<ChoiceModel> listOfChoiceModel = <ChoiceModel>[];

    customizationOptionsProvider.customizeOptionsdata["enable_kt"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Select Metal",
            options: ["22 KT", "18 KT"],
            selectedOption: "18KT",
          ))
        : <ChoiceModel>[];

    customizationOptionsProvider.customizeOptionsdata["enable_color"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Select Color",
            options: ["rose", "yellow", "two-tone", "white"],
            selectedOption: "rose",
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
            options: ["Natural"],
            selectedOption: "Natural",
          ))
        : <ChoiceModel>[];

    customizationOptionsProvider.customizeOptionsdata["enable_color"] == "1"
        ? listOfChoiceModel.add(ChoiceModel(
            label: "Select Quality",
            options: ["VVS-EF"],
            selectedOption: "VVS-EF",
          ))
        : <ChoiceModel>[];

    return Scaffold(
      appBar: AppBar(title: Text("Details"), actions: <Widget>[
        SizedBox(
          height: 40.0,
          width: 32.0,
          child: badges.Badge(
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            badgeContent:
                Consumer<WishlistProvider>(builder: (context, value, child) {
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartPage()));
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
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Column(children: [
          WholeCarouselSlider(listOfProductImage: productsModel.images),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 86.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          productsModel.salePrice == ""
                              ? Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/rupee.png",
                                      width: 19.0,
                                      height: 17.0,
                                    ),
                                    Text(
                                        productsModel.regularPrice != ""
                                            ? productsModel.regularPrice ??
                                                "20000"
                                            : "0.0",
                                        // productsModel.regularPrice ??
                                        //     "20,000",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3)
                                  ],
                                )
                              : Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/rupee.png",
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                    Text(
                                        productsModel.salePrice == ""
                                            ? "10,000"
                                            : productsModel.salePrice ??
                                                "10,000",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      productsModel.regularPrice != ""
                                          ? productsModel.regularPrice ??
                                              "20000"
                                          : "0.0",
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                          IconButton(
                              icon: Icon(
                                wishListProvider.favProductIds
                                        .contains(productsModel.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                                size: 30.0,
                              ),
                              onPressed: () {
                                print("PRESSED");
                                if (wishListProvider.favProductIds
                                    .contains(productsModel.id)) {
                                  wishListProvider
                                      .removeFromWishlist(productsModel.id!);
                                  print("Product is removed from wishlist");
                                } else {
                                  wishListProvider
                                      .addToWishlist(productsModel.id!);
                                  print("Product is added to wishlist");
                                }
                              }),
                        ]),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        color: const Color(0xfff1f7eb),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: backordersAllowed
                            ? const LabelWidget(
                                label: "Available on backorder",
                                color: Color(0xff85BA60),
                              )
                            : const LabelWidget(
                                label: "Unavailable on backorder",
                                color: Color(0xff85BA60),
                              )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    customizationOptionsProvider
                                .customizeOptionsdata["enable_everything"] ==
                            "1" 
                        ? SizedBox(
                            height: customizationOptionsProvider.customizeOptionsdata["enable_color"] != "0" && customizationOptionsProvider.customizeOptionsdata["enable_diamond"] != "0" && customizationOptionsProvider.customizeOptionsdata["enable_kt"] != "0" ? MediaQuery.of(context).size.height / 2.5 : 0.0,
                            child: Scrollbar(
                              child: GridView.builder(
                                  itemCount: listOfChoiceModel.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1.9,
                                          crossAxisCount: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? 5
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
                    const LabelWidget(
                      label: Strings.description_label,
                    ),
                    HtmlWidget(productsModel.description ??
                        Strings.product_description),
                    const SizedBox(
                      height: 10.0,
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
                        Text(productsModel.sku ?? "12007AN"),
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
                        Text(productsModel.categories != null
                            ? productsModel.categories![0].name ?? "Jewellery"
                            : "Jewellery")
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Tags:",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    productsModel.tags == null
                        ? const Text("Jewellery")
                        : SizedBox(
                            height: 20.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: productsModel.tags?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(productsModel.tags?[index].name ??
                                      "Category"),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                    const SizedBox(
                      height: 10.0,
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
                          bool isReviewUploaded = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WriteReviewPage(
                                      productsModel: productsModel)));

                          if (isReviewUploaded) {
                            setState(() {
                              getReviews();
                            });
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
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17.0,
                          ),
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

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                      children: List.generate(5,
                                                          (index) {
                                                        return Icon(
                                                          index <
                                                                  (reviewsModel
                                                                          .rating ??
                                                                      0)
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_border,
                                                          color: Colors.amber,
                                                        );
                                                      }),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            HtmlWidget(reviewsModel.review ??
                                                "<p>Review</p>"),
                                            SizedBox(
                                              height: 10.0,
                                            )
                                          ],
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                    ApiService.reviewsList.length > 3
                        ? InkWell(
                            child: Text(
                              "Read all ${ApiService.reviewsList.length} Reviews",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
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
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                productsModel.salePrice == ""
                    ? Row(
                        children: [
                          Image.asset(
                            "assets/images/rupee.png",
                            width: 25.0,
                            height: 37.0,
                          ),
                          Text(
                              productsModel.regularPrice != ""
                                  ? productsModel.regularPrice ?? "20000"
                                  : "0.0",
                              // productsModel.regularPrice ??
                              //     "20,000",
                              style: Theme.of(context).textTheme.headline1)
                        ],
                      )
                    : Row(
                        children: [
                          Image.asset(
                            "assets/images/rupee.png",
                            width: 25.0,
                            height: 37.0,
                          ),
                          Text(
                              productsModel.salePrice == ""
                                  ? "10,000"
                                  : productsModel.salePrice ?? "10,000",
                              style: Theme.of(context).textTheme.headline1),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            productsModel.regularPrice != ""
                                ? productsModel.regularPrice ?? "20000"
                                : "0.0",
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),

                ////////////////

                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ButtonWidget(
                      imagePath: "assets/images/grocery_store.png",
                      btnString: Strings.cart_btn_text,
                      onTap: () async {
                        print("CART PRESSED");
                        cartProvider.addToCartId(productsModel.id!);
                        print("CART IDS : ${cartProvider.cartProductIds}");

                        if (customerProvider.customerData.isNotEmpty ||
                            customerProvider.customerData.length != 0) {
                          print(
                              "customerData.isNotEmpty ${customerProvider.customerData.isNotEmpty}");

                          List<CartProductModel> cart = <CartProductModel>[];
                          cart.add(CartProductModel(
                              cartProductid: productsModel.id,
                              price: productsModel.regularPrice != ""
                                  ? productsModel.regularPrice ?? "20000"
                                  : "0.0",
                              productName: productsModel.name ?? "Jewellery",
                              quantity: "1",
                              size: 5,
                              deliveryDate: DateHelper.getCurrentDateInWords(),
                              imageUrl: productsModel.images.isEmpty
                                  ? Strings.defaultImageUrl
                                  : productsModel.images[0].src ??
                                      Strings.defaultImageUrl,
                              sku: productsModel.sku ?? "ABC",
                              imageId: productsModel.images.isNotEmpty
                                  ? productsModel.images[0].id
                                  : 0));

                          customerProvider.customerData[0]["cartList"] = cart;
                        }

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
                                ? Strings.defaultImageUrl
                                : productsModel.images[0].src ??
                                    Strings.defaultImageUrl,
                            sku: productsModel.sku ?? "ABC",
                            imageId: productsModel.images.isNotEmpty
                                ? productsModel.images[0].id
                                : 0));

                        print("Product is added to cart");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartPage()));
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
