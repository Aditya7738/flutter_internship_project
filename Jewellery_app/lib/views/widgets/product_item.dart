import 'package:Tiara_by_TJ/providers/layoutdesign_provider.dart';
import 'package:Tiara_by_TJ/views/pages/details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';

class ProductItem extends StatefulWidget {
  final ProductsModel productsModel;
  final int? productIndex;
  final bool forCollections;
  final bool? fromHomeScreen;
  const ProductItem(
      {super.key,
      required this.productsModel,
      this.productIndex,
      required this.forCollections,
      this.fromHomeScreen});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late final ProductsModel productsModel;

  List<ProductImage> listOfProductImage = <ProductImage>[];

  @override
  void initState() {
    super.initState();
    productsModel = widget.productsModel;
  }

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final layoutDesignProvider = Provider.of<LayoutDesignProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;

    print("product item ${(deviceWidth / 3) - 75}");
    print(productsModel.toJson());
    String deliveryDate = DateHelper.getCurrentDateInWords();
    return GestureDetector(
      onTap: () {
        print("CATEGORY PRODUCT PRESSED");
        print("widget.productIndex != null ${widget.productIndex != null}");
        print("widget.productIndex ${widget.productIndex}");

        // if (widget.productIndex != null) {
        //   print("in widget.productIndex != null");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsView(
                  productIndex: widget.productIndex!,
                  forCollections: widget.forCollections,
                  fromHomeScreen: widget.fromHomeScreen,
                )));
        // } else {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) =>
        //           ProductDetailsPage(productsModel: productsModel)));
        // }
      },
      child: Container(
        //width: (deviceWidth / 2),
        decoration: BoxDecoration(
        
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 0.5),
          shape: BoxShape.rectangle,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productsModel.images.isEmpty ||
                        productsModel.images[0].src == null
                    ? CachedNetworkImage(
                        imageUrl: layoutDesignProvider.placeHolder,
                        width: (deviceWidth / 2) + 16.0,
                        height: deviceWidth > 600
                            ? (deviceWidth / 2) - 125
                            : (deviceWidth / 2) - 10,
                        placeholder: (context, url) {
                          return SizedBox(
                            width: (deviceWidth / 2) + 16.0,
                            height: deviceWidth > 600
                                ? (deviceWidth / 2) - 125
                                : (deviceWidth / 2) - 10,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                              ),
                            ),
                          );
                        },
                      )
                    : CachedNetworkImage(
                        imageUrl: productsModel.images.isEmpty
                            ? layoutDesignProvider.placeHolder
                            : productsModel.images[0].src ??
                                layoutDesignProvider.placeHolder,
                        width: (deviceWidth / 2) + 16.0,
                        height: deviceWidth > 600
                            ? (deviceWidth / 2) - 125
                            : (deviceWidth / 2) - 10,
                        placeholder: (context, url) {
                          return SizedBox(
                            width: (deviceWidth / 2) + 16.0,
                            height: deviceWidth > 600
                                ? (deviceWidth / 2) - 125
                                : (deviceWidth / 2) - 10,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(int.parse(
                                    "0xff${layoutDesignProvider.primary.substring(1)}")),
                              ),
                            ),
                          );
                        },
                      ),
                Container(
                  padding: const EdgeInsets.only(
                      right: 12.0, left: 12.0, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: deviceWidth > 600
                              //     ? deviceWidth / 3
                              //     : (deviceWidth / 2) - 72,
                              width: deviceWidth > 600
                                  ? (constraints.maxWidth / 1.25)
                                  : (constraints.maxWidth / 1.5),

                              child: Text(
                                productsModel.name ?? "Jewellery",
                                style: TextStyle(
                                  fontSize: deviceWidth > 600 ? 25 : 17,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            productsModel.salePrice == ""
                                ? Text(
                                    productsModel.regularPrice != ""
                                        ? "₹ ${productsModel.regularPrice ?? 20000}"
                                        : "₹ 0.0",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: deviceWidth > 600 ? 24 : 16,
                                    ),
                                  )
                                : RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: productsModel.salePrice ==
                                                      ""
                                                  ? "₹ 10,000 \n"
                                                  : "₹ ${productsModel.salePrice ?? 10000}  ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                              text: productsModel
                                                          .regularPrice !=
                                                      ""
                                                  ? "₹ ${productsModel.regularPrice ?? 20000}"
                                                  : "₹ 0.0",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.normal,
                                              ))
                                        ],
                                        style: TextStyle(
                                            fontSize:
                                                deviceWidth > 600 ? 25 : 16,
                                            color: Colors.black))),
                            SizedBox(
                              height: 10.0,
                            ),
                            productsModel.averageRating != null
                                ? Container(
                                    width: deviceWidth > 600
                                        ? constraints.maxWidth / 2.1
                                        : constraints.maxWidth - 97,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 2, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          18), // Border radius
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          productsModel.averageRating ?? "3.5",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                deviceWidth > 600 ? 25.0 : 15.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    width: deviceWidth / 2 - 60,
                                  ),
                          ],
                        ),
                      ),

                      Container(
                        //height: 91,
                        height: deviceWidth > 600
                            ? constraints.maxHeight / 4.65
                            : constraints.maxHeight / 3.35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<CartProvider>(
                              builder: (BuildContext context,
                                  CartProvider value, Widget? child) {
                                return Container(
                                  // width: constraints.maxWidth - 168,
                                  // height: constraints.maxWidth - 146,
                                  child: GestureDetector(
                                      onTap: () {
                                        CartProductModel cartProductModel =
                                            CartProductModel(
                                                cartProductid: productsModel.id,
                                                price: productsModel
                                                            .regularPrice !=
                                                        ""
                                                    ? "${productsModel.regularPrice ?? 20000}"
                                                    : "0.0",
                                                productName: productsModel.name,
                                                quantity: "1",
                                                size: 5,
                                                deliveryDate: deliveryDate,
                                                imageUrl: productsModel
                                                        .images.isEmpty
                                                    ? layoutDesignProvider.placeHolder
                                                    : productsModel
                                                            .images[0].src ??
                                                        Constants
                                                            .defaultImageUrl,
                                                sku: productsModel.sku,
                                                imageId: productsModel
                                                        .images.isNotEmpty
                                                    ? productsModel.images[0].id
                                                    : 0);

                                        if (value.cartProductIds
                                            .contains(productsModel.id)) {
                                          value.removeFromCartId(
                                              productsModel.id!);

                                          value.removeFromCart(cartProductModel,
                                              productsModel.id!);
                                        } else {
                                          value.addToCartId(productsModel.id!);
                                          value.addToCart(cartProductModel);
                                        }
                                      },
                                      child: value.cartProductIds
                                              .contains(productsModel.id)
                                          ? Icon(
                                              Icons.shopping_cart,
                                              size: deviceWidth > 600
                                                  ? 34.0
                                                  : 24.0,
                                              //     constraints.maxWidth - 190)
                                            )
                                          : Icon(
                                              Icons.add_shopping_cart_rounded,
                                              size: deviceWidth > 600
                                                  ? 34.0
                                                  : 24.0,
                                              //     constraints.maxWidth - 190),
                                            )),
                                );
                              },
                            ),
                            Container(
                              // height: constraints.maxWidth - 168,
                              // height: constraints.maxWidth - 206,
                              child: GestureDetector(
                                onTap: () {
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
                                },
                                child: Icon(
                                  wishListProvider.favProductIds
                                          .contains(productsModel.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: deviceWidth > 600 ? 34.0 : 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      // Container(
                      // //  alignment: Alignment.topCenter,
                      //   color: Colors.yellow,
                      //   child: Column(

                      //     children: [
                      //       Consumer<CartProvider>(
                      //         builder: (BuildContext context,
                      //             CartProvider value, Widget? child) {
                      //           return Container(
                      //             color: Colors.red,
                      //             width: constraints.maxWidth - 168,
                      //             height: constraints.maxWidth - 146,
                      //             child: GestureDetector(
                      //                 onTap: () {
                      //                   CartProductModel cartProductModel =
                      //                       CartProductModel(
                      //                           cartProductid: productsModel.id,
                      //                           price: productsModel
                      //                                       .regularPrice !=
                      //                                   ""
                      //                               ? "${productsModel.regularPrice ?? 20000}"
                      //                               : "0.0",
                      //                           productName: productsModel.name,
                      //                           quantity: "1",
                      //                           size: 5,
                      //                           deliveryDate: deliveryDate,
                      //                           imageUrl: productsModel
                      //                                   .images.isEmpty
                      //                               ? Constants.defaultImageUrl
                      //                               : productsModel
                      //                                       .images[0].src ??
                      //                                   Constants
                      //                                       .defaultImageUrl,
                      //                           sku: productsModel.sku,
                      //                           imageId: productsModel
                      //                                   .images.isNotEmpty
                      //                               ? productsModel.images[0].id
                      //                               : 0);

                      //                   if (value.cartProductIds
                      //                       .contains(productsModel.id)) {
                      //                     value.removeFromCartId(
                      //                         productsModel.id!);

                      //                     value.removeFromCart(cartProductModel,
                      //                         productsModel.id!);
                      //                   } else {
                      //                     value.addToCartId(productsModel.id!);
                      //                     value.addToCart(cartProductModel);
                      //                   }
                      //                 },
                      //                 child: value.cartProductIds
                      //                         .contains(productsModel.id)
                      //                     ? Icon(
                      //                         Icons.shopping_cart,
                      //                         // size:
                      //                         //     // deviceWidth > 600
                      //                         //     //     ? (deviceWidth / 3) - 260
                      //                         //     //     : (deviceWidth / 3) - 100,
                      //                         //     constraints.maxWidth - 190)
                      //                       )
                      //                     : Icon(
                      //                         Icons.add_shopping_cart_rounded,
                      //                         // size:
                      //                         //     // deviceWidth > 600
                      //                         //     //     ? (deviceWidth / 3) - 260
                      //                         //     //     : (deviceWidth / 3) - 100,
                      //                         //     constraints.maxWidth - 190),
                      //                       )),
                      //           );
                      //         },
                      //         //  child:
                      //       ),
                      //       Container(
                      //         padding: EdgeInsets.only(bottom: 5.0),
                      //         height: constraints.maxWidth - 168,
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             print("PRESSED");
                      //             if (wishListProvider.favProductIds
                      //                 .contains(productsModel.id)) {
                      //               wishListProvider
                      //                   .removeFromWishlist(productsModel.id!);
                      //               print("Product is removed from wishlist");
                      //             } else {
                      //               wishListProvider
                      //                   .addToWishlist(productsModel.id!);
                      //               print("Product is added to wishlist");
                      //             }
                      //           },
                      //           child: Icon(
                      //             wishListProvider.favProductIds
                      //                     .contains(productsModel.id)
                      //                 ? Icons.favorite
                      //                 : Icons.favorite_border_outlined,
                      //             color: Colors.red,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
