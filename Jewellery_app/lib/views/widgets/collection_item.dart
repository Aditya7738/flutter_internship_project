import 'package:Tiara_by_TJ/model/collections_model.dart' as CollectionsModel;
import 'package:Tiara_by_TJ/views/pages/details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';

class CollectionItem extends StatefulWidget {
  final CollectionsModel.CollectionsModel collectionsModel;
  final int? productIndex;
  const CollectionItem(
      {super.key, required this.collectionsModel, this.productIndex});

  @override
  State<CollectionItem> createState() => _CollectionItemState();
}

class _CollectionItemState extends State<CollectionItem> {
  late final CollectionsModel.CollectionsModel collectionsModel;

  List<ProductImage> listOfProductImage = <ProductImage>[];

  @override
  void initState() {
    super.initState();
    collectionsModel = widget.collectionsModel;
  }

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    double deviceWidth = MediaQuery.of(context).size.width;

    print("product item ${(deviceWidth / 3) - 75}");
    print(collectionsModel.toJson());
    String deliveryDate = DateHelper.getCurrentDateInWords();
    return GestureDetector(
      onTap: () {
        print("CATEGORY PRODUCT PRESSED");
        print("widget.productIndex != null ${widget.productIndex != null}");
        print("widget.productIndex ${widget.productIndex}");

     
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) =>
        //         DetailsView(productIndex: widget.productIndex!))
        //         );
        // } else {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) =>
        //           ProductDetailsPage(collectionsModel: collectionsModel)));
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 0.5),
          shape: BoxShape.rectangle,
        ),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              collectionsModel.images.isEmpty ||
                      collectionsModel.images[0].src == null
                  ? ClipRRect(
                      child: Image.asset(
                        "assets/images/image_placeholder.jpg",
                        width: (deviceWidth / 2) + 16.0,
                        height: (deviceWidth / 2) + 10.0,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: collectionsModel.images.isEmpty
                          ? Constants.defaultImageUrl
                          : collectionsModel.images[0].src ??
                              Constants.defaultImageUrl,
                      width: (deviceWidth / 2) + 16.0,
                      height: deviceWidth > 600
                          ? (deviceWidth / 2) - 111
                          : (deviceWidth / 2) - 10,
                      placeholder: (context, url) {
                        return SizedBox(
                          width: (deviceWidth / 2) + 16.0,
                          height: deviceWidth > 600
                              ? (deviceWidth / 2) - 111
                              : (deviceWidth / 2) - 10,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12.0, left: 5.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      width: deviceWidth > 600
                          ? (deviceWidth / 3) - 75
                          : (deviceWidth / 2) - 66,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                collectionsModel.name ?? "Jewellery",
                                style: TextStyle(
                                  fontSize: constraints.maxWidth / 10,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              collectionsModel.salePrice == ""
                                  ? Text(
                                      collectionsModel.regularPrice != ""
                                          ? "₹ ${collectionsModel.regularPrice ?? 20000}"
                                          : "₹ 0.0",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth / 10,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          collectionsModel.salePrice == ""
                                              ? "₹ 10,000"
                                              : "₹ ${collectionsModel.salePrice ?? 10000}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: constraints.maxWidth / 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          collectionsModel.regularPrice != ""
                                              ? "₹ ${collectionsModel.regularPrice ?? 20000}"
                                              : "₹ 0.0",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: constraints.maxWidth / 10,
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 10.0,
                              ),
                              collectionsModel.averageRating != null
                                  ? Container(
                                      width: deviceWidth > 600
                                          ? constraints.maxWidth / 2.1
                                          : constraints.maxWidth / 1.5,
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
                                            collectionsModel.averageRating ??
                                                "3.5",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  constraints.maxWidth / 10,
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
                          );
                        },
                        //   child:
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<CartProvider>(
                          builder: (BuildContext context, CartProvider value,
                              Widget? child) {
                            return GestureDetector(
                              onTap: () {
                                CartProductModel cartProductModel =
                                    CartProductModel(
                                        cartProductid: collectionsModel.id,
                                        price: collectionsModel.regularPrice !=
                                                ""
                                            ? "${collectionsModel.regularPrice ?? 20000}"
                                            : "0.0",
                                        productName: collectionsModel.name,
                                        quantity: "1",
                                        size: 5,
                                        deliveryDate: deliveryDate,
                                        imageUrl: collectionsModel
                                                .images.isEmpty
                                            ? Constants.defaultImageUrl
                                            : collectionsModel.images[0].src ??
                                                Constants.defaultImageUrl,
                                        sku: collectionsModel.sku,
                                        imageId:
                                            collectionsModel.images.isNotEmpty
                                                ? collectionsModel.images[0].id
                                                : 0);

                                if (value.cartProductIds
                                    .contains(collectionsModel.id)) {
                                  value.removeFromCartId(collectionsModel.id!);

                                  value.removeFromCart(
                                      cartProductModel, collectionsModel.id!);
                                } else {
                                  value.addToCartId(collectionsModel.id!);
                                  value.addToCart(cartProductModel
                                      // CartProductModel(
                                      //   cartProductid: collectionsModel.id,
                                      //   price: collectionsModel.regularPrice != ""
                                      //       ? collectionsModel.regularPrice ?? "20000"
                                      //       : "0.0",
                                      //   productName:
                                      //       collectionsModel.name ?? "Jewellery",
                                      //   quantity: "1",
                                      //   size: 5,
                                      //   deliveryDate:
                                      //       deliveryDate,
                                      //   imageUrl: collectionsModel.images.isEmpty
                                      //       ? Constants.defaultImageUrl
                                      //       : collectionsModel.images[0].src ??
                                      //           Constants.defaultImageUrl,
                                      //   sku: collectionsModel.sku,
                                      //   imageId: collectionsModel.images.isNotEmpty
                                      //       ? collectionsModel.images[0].id
                                      //       : 0)
                                      );
                                }
                              },
                              child: value.cartProductIds
                                      .contains(collectionsModel.id)
                                  ? Icon(
                                      Icons.shopping_cart,
                                      size: deviceWidth > 600
                                          ? (deviceWidth / 3) - 260
                                          : (deviceWidth / 3) - 116,
                                    )
                                  : Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: deviceWidth > 600
                                          ? (deviceWidth / 3) - 260
                                          : (deviceWidth / 3) - 116,
                                    ),
                            );
                          },
                          //  child:
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        IconButton(
                            icon: Icon(
                              wishListProvider.favProductIds
                                      .contains(collectionsModel.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: deviceWidth > 600
                                  ? (deviceWidth / 3) - 260
                                  : (deviceWidth / 3) - 116,
                            ),
                            onPressed: () {
                              print("PRESSED");
                              if (wishListProvider.favProductIds
                                  .contains(collectionsModel.id)) {
                                wishListProvider
                                    .removeFromWishlist(collectionsModel.id!);
                                print("Product is removed from wishlist");
                              } else {
                                wishListProvider
                                    .addToWishlist(collectionsModel.id!);
                                print("Product is added to wishlist");
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
