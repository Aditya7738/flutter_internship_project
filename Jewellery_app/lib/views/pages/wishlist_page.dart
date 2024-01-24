import 'package:flutter/material.dart';
import 'package:jwelery_app/api/api_service.dart';
import 'package:jwelery_app/constants/strings.dart';
import 'package:jwelery_app/helpers/date_helper.dart';
import 'package:jwelery_app/model/cart_product_model.dart';
import 'package:jwelery_app/providers/cart_provider.dart';
import 'package:jwelery_app/providers/wishlist_provider.dart';
import 'package:jwelery_app/views/pages/cart_page.dart';
import 'package:jwelery_app/views/widgets/cart_app_bar.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  //bool newListLoading = true;
  @override
  void initState() {
    super.initState();
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    getFavProducts(wishlistProvider.favProductIds);
  }

  Future<void> getFavProducts(List<int> wishlist) async {
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    // if (wishlistProvider.wishlistProducts.isNotEmpty) {
    //   for (int i = 0; i < wishlistProvider.wishlistProducts.length; i++) {
    //     if (!wishlistProvider.favProductIds
    //         .contains(wishlistProvider.wishlistProducts[i].id)) {
    //       newDataAdded = true;
    //       return;
    //     }
    //   }
    // }

    if (wishlistProvider.wishlistProducts.isEmpty ||
        wishlistProvider.wishlistProducts.length !=
            wishlistProvider.favProductIds.length) {
      ApiService.listOfFavProductsModel.clear();
      wishlistProvider.listLoading = true;

      final wishlistProducts = await ApiService.fetchFavProducts(wishlist);
      wishlistProvider.setWishlistProducts(wishlistProducts);
      wishlistProvider.listLoading = false;
    }

    // setState(() {
    //   newListLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    //final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);

    return Scaffold(
      appBar: const CartAppBar(title: "Wishlist", forCart: false),
      body: Consumer<WishlistProvider>(builder: (context, value, child) {
        print("LEnGTH ${value.wishlistProducts.length}");

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: value.listLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      color: Colors.white,
                    ),
                  )
                : ListView.builder(
                    itemCount: value.wishlistProducts.length,
                    itemBuilder: (context, index) {
                      final wishListItem = value.wishlistProducts[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Card(
                            elevation: 5.0,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    wishListItem.images.isEmpty
                                        ? Strings.defaultImageUrl
                                        : wishListItem.images[0].src ??
                                            Strings.defaultImageUrl,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 170.0,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height: 160.0,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 0.0,
                                        top: 10.0,
                                        bottom: 20.0),
                                    child: SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3)) -
                                              44,
                                      height: 130.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2) -
                                                            10,
                                                    child: Text(
                                                      wishListItem.name ??
                                                          "Jewellery",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      value
                                                          .removeFromLocalWishlist(
                                                              wishListItem.id!);

                                                      value.removeFromWishlist(
                                                          wishListItem.id!);

                                                      // setState(() async {
                                                      //   await getFavProducts(value.favProductIds);

                                                      // });
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(3.0),
                                                        child: Icon(
                                                          size: 15.0,
                                                          Icons.close_rounded,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/rupee.png",
                                                    width: 19.0,
                                                    height: 17.0,
                                                  ),
                                                  Text(
                                                    wishListItem.regularPrice !=
                                                            ""
                                                        ? wishListItem
                                                                .regularPrice ??
                                                            "20000"
                                                        : "20000",
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 17.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider.addToCart(
                                                      CartProductModel(
                                                    cartProductid:
                                                        wishListItem.id,
                                                    price: wishListItem
                                                                .regularPrice !=
                                                            ""
                                                        ? wishListItem
                                                                .regularPrice ??
                                                            "20000"
                                                        : "0.0",
                                                    productName:
                                                        wishListItem.name ??
                                                            "Jewellery",
                                                    quantity: "1",
                                                    size: 5,
                                                    deliveryDate: DateHelper
                                                        .getCurrentDateInWords(),
                                                    imageUrl: wishListItem
                                                            .images.isEmpty
                                                        ? Strings
                                                            .defaultImageUrl
                                                        : wishListItem.images[0]
                                                                .src ??
                                                            Strings
                                                                .defaultImageUrl,
                                                    sku: wishListItem.sku,
                                                    imageId: wishListItem
                                                            .images.isNotEmpty
                                                        ? wishListItem
                                                            .images[0].id
                                                        : 0,
                                                  ));
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CartPage()));

                                                  value.removeFromLocalWishlist(
                                                      wishListItem.id!);

                                                  value.removeFromWishlist(
                                                      wishListItem.id!);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0,
                                                            vertical: 5.0),
                                                    child: Text(
                                                      "Move to Cart",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child: Icon(Icons.share),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                      );
                    },
                  ));
        // : ListView.builder(
        //     itemCount: value.wishlistProducts.length,
        //     itemBuilder: (context, index) {
        //       final wishListItem = value.wishlistProducts[index];

        //       return Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 3.0),
        //         child: Card(
        //             elevation: 5.0,
        //             child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Image.network(
        //                     wishListItem.images.isEmpty
        //                         ? Strings.defaultImageUrl
        //                         : wishListItem.images[0].src ??
        //                             Strings.defaultImageUrl,
        //                     width:
        //                         MediaQuery.of(context).size.width / 3,
        //                     height: 170.0,
        //                     loadingBuilder:
        //                         (context, child, loadingProgress) {
        //                       if (loadingProgress == null) {
        //                         return child;
        //                       }
        //                       return SizedBox(
        //                         width:
        //                             MediaQuery.of(context).size.width /
        //                                 3,
        //                         height: 160.0,
        //                         child: const Center(
        //                           child: CircularProgressIndicator(
        //                             color: Colors.black,
        //                           ),
        //                         ),
        //                       );
        //                     },
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.only(
        //                         left: 10.0,
        //                         right: 0.0,
        //                         top: 10.0,
        //                         bottom: 20.0),
        //                     child: SizedBox(
        //                       width:
        //                           (MediaQuery.of(context).size.width -
        //                                   (MediaQuery.of(context)
        //                                           .size
        //                                           .width /
        //                                       3)) -
        //                               44,
        //                       height: 130.0,
        //                       child: Column(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment
        //                                         .spaceBetween,
        //                                 children: [
        //                                   Text(
        //                                     wishListItem.name ??
        //                                         "Jewellery",
        //                                     style: const TextStyle(
        //                                         fontSize: 16.0),
        //                                   ),
        //                                   GestureDetector(
        //                                     onTap: () {
        //                                       value.removeFromLocalWishlist(
        //                                           ProductsModel(
        //                                               id: wishListItem
        //                                                   .id,
        //                                               name: wishListItem
        //                                                   .name,
        //                                               regularPrice:
        //                                                   wishListItem
        //                                                       .regularPrice,
        //                                               images:
        //                                                   wishListItem
        //                                                       .images));

        //                                       value.removeFromWishlist(
        //                                           wishListItem.id!);
        //                                     },
        //                                     child: Container(
        //                                       decoration:
        //                                           const BoxDecoration(
        //                                         color: Colors.black,
        //                                         shape: BoxShape.circle,
        //                                       ),
        //                                       child: const Padding(
        //                                         padding:
        //                                             EdgeInsets.all(3.0),
        //                                         child: Icon(
        //                                           size: 15.0,
        //                                           Icons.close_rounded,
        //                                           color: Colors.white,
        //                                         ),
        //                                       ),
        //                                     ),
        //                                   )
        //                                 ],
        //                               ),
        //                               Row(
        //                                 children: [
        //                                   Image.asset(
        //                                     "assets/images/rupee.png",
        //                                     width: 19.0,
        //                                     height: 17.0,
        //                                   ),
        //                                   Text(
        //                                     wishListItem.regularPrice ??
        //                                         "20,000",
        //                                     softWrap: true,
        //                                     overflow:
        //                                         TextOverflow.ellipsis,
        //                                     style: const TextStyle(
        //                                       fontSize: 17.0,
        //                                     ),
        //                                   )
        //                                 ],
        //                               ),
        //                             ],
        //                           ),
        //                           Row(
        //                             children: [
        //                               GestureDetector(
        //                                 onTap: () {
        //                                   cartProvider.addToCart(CartProductModel(
        //                                       cartProductid:
        //                                           wishListItem.id,
        //                                       price: wishListItem
        //                                               .regularPrice ??
        //                                           "20000",
        //                                       productName:
        //                                           wishListItem.name ??
        //                                               "Jewellery",
        //                                       quantity: "1",
        //                                       size: 5,
        //                                       deliveryDate: DateHelper
        //                                           .getCurrentDateInWords(),
        //                                       imageUrl: wishListItem
        //                                               .images.isEmpty
        //                                           ? Strings
        //                                               .defaultImageUrl
        //                                           : wishListItem
        //                                                   .images[0]
        //                                                   .src ??
        //                                               Strings
        //                                                   .defaultImageUrl));
        //                                   Navigator.of(context).push(
        //                                       MaterialPageRoute(
        //                                           builder: (context) =>
        //                                               CartPage()));
        //                                 },
        //                                 child: Container(
        //                                   decoration:
        //                                       const BoxDecoration(
        //                                           color: Colors.green,
        //                                           borderRadius:
        //                                               BorderRadius.all(
        //                                                   Radius
        //                                                       .circular(
        //                                                           5.0))),
        //                                   child: const Padding(
        //                                     padding:
        //                                         EdgeInsets.symmetric(
        //                                             horizontal: 15.0,
        //                                             vertical: 5.0),
        //                                     child: Text(
        //                                       "Move to Cart",
        //                                       style: TextStyle(
        //                                           color: Colors.white),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               const SizedBox(
        //                                 width: 15.0,
        //                               ),
        //                               GestureDetector(
        //                                 onTap: () {},
        //                                 child: Container(
        //                                   decoration: BoxDecoration(
        //                                       border: Border.all(
        //                                           color: Colors.black),
        //                                       shape: BoxShape.rectangle,
        //                                       borderRadius:
        //                                           BorderRadius.circular(
        //                                               5.0)),
        //                                   child: const Padding(
        //                                     padding:
        //                                         EdgeInsets.all(3.0),
        //                                     child: Icon(Icons.share),
        //                                   ),
        //                                 ),
        //                               )
        //                             ],
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ])),
        //       );
        //     },
        //   ));
      }),
    );
  }
}
