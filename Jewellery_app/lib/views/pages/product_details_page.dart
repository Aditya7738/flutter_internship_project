import 'package:Tiara_by_TJ/views/pages/wishlist_page.dart';
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

  @override
  void initState() {
    super.initState();
    productsModel = widget.productsModel;
    backordersAllowed = productsModel.backordersAllowed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);

    List<ChoiceModel> listOfChoiceModel = <ChoiceModel>[];
    listOfChoiceModel.add(ChoiceModel(
      label: "Select Metal",
      options: ["22 KT", "18 KT"],
      selectedOption: "18KT",
    ));
    listOfChoiceModel.add(ChoiceModel(
      label: "Select Color",
      options: ["rose", "yellow", "two-tone", "white"],
      selectedOption: "rose",
    ));
    listOfChoiceModel.add(ChoiceModel(
      label: "Select Size",
      options: [
        "2.02 - Make to Order",
        "2.04 - Make to Order",
        "2.06 - Make to Order"
      ],
      selectedOption: "2.02 - Make to Order",
    ));
    listOfChoiceModel.add(ChoiceModel(
      label: "Type of Diamond",
      options: ["Natural"],
      selectedOption: "Natural",
    ));
    listOfChoiceModel.add(ChoiceModel(
      label: "Select Quality",
      options: ["VVS-EF"],
      selectedOption: "VVS-EF",
    ));

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
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Scrollbar(
                        child: GridView.builder(
                            itemCount: listOfChoiceModel.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.9,
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width > 600
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
                    ),
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
                      width: 30.0,
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: SizedBox(
      //   width: 160.0,
      //   child: ButtonWidget(
      //       imagePath: "assets/images/grocery_store.png",
      //       btnString: Strings.cart_btn_text,
      //       onTap: () async {
      //         print("CART PRESSED");
      //         cartProvider.addToCartId(productsModel.id!);
      //         print("CART IDS : ${cartProvider.cartProductIds}");

      //         cartProvider.addToCart(CartProductModel(
      //             cartProductid: productsModel.id,
      //             price: productsModel.regularPrice != ""
      //                 ? productsModel.regularPrice ?? "20000"
      //                 : "0.0",
      //             productName: productsModel.name ?? "Jewellery",
      //             quantity: "1",
      //             size: 5,
      //             deliveryDate: DateHelper.getCurrentDateInWords(),
      //             imageUrl: productsModel.images.isEmpty
      //                 ? Strings.defaultImageUrl
      //                 : productsModel.images[0].src ?? Strings.defaultImageUrl,
      //             sku: productsModel.sku ?? "ABC",
      //             imageId: productsModel.images.isNotEmpty
      //                 ? productsModel.images[0].id
      //                 : 0));

      //         print("Product is added to cart");
      //         Navigator.of(context)
      //             .push(MaterialPageRoute(builder: (context) => CartPage()));
      //       }),
      // ),
    );
  }
}
