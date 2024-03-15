import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/api/api_service.dart';
import 'package:Tiara_by_TJ/constants/constants.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/cart_page.dart';

import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool isWishListLoading = false;
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
      bool isThereInternet = await ApiService.checkInternetConnection(context);
      if (isThereInternet) {
        if (mounted) {
          setState(() {
            isWishListLoading = true;
          });
        }
        ApiService.listOfFavProductsModel.clear();

        final wishlistProducts = await ApiService.fetchFavProducts(wishlist);
        wishlistProvider.setWishlistProducts(wishlistProducts);
        if (mounted) {
          setState(() {
            isWishListLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    //final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Consumer<WishlistProvider>(builder: (context, value, child) {
        print("LEnGTH ${value.wishlistProducts.length}");

        if (value.favProductIds.isEmpty) {
//EmptyListWidget(imagePath: "assets/images/empty_wish_list.jpg", message: "You have no products in your wishlist.", forCancelledOrder: false)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/empty_wish_list.jpg",
                    width: 240.0,
                    height: 240.0,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text("Your Wishlist is Empty",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline1),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                      "Looks like you don't have added any jewelleries to your wishlist yet",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DashboardPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
                        child: Text("Continue Shopping",
                            style: Theme.of(context).textTheme.button
                            // TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 17.0,
                            //     fontWeight: FontWeight.bold),
                            )),
                  )
                ],
              ),
            ),
          );
        } else {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: isWishListLoading
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
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                              elevation: 5.0,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                width: deviceWidth > 600
                                    ? (deviceWidth / 3) - 60
                                    : 130.0,
                                height: deviceWidth > 600
                                    ? (deviceWidth / 3) - 90
                                    : 130.0,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          wishListItem.images.isEmpty
                                              ? Constants.defaultImageUrl
                                              : wishListItem.images[0].src ??
                                                  Constants.defaultImageUrl,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              height: 130.0,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Container(
                                       
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
                                                  width: 10.0,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: deviceWidth > 600
                                                          ? (deviceWidth / 1.46) - 10
                                                          : (MediaQuery.of(context).size.width / 2) + 16.0,
                                                      child: Text(
                                                        wishListItem.name ??
                                                            "Jewellery",
                                                        // overflow:
                                                        //     TextOverflow.ellipsis,
                                                        // softWrap: true,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize:
                                                                (deviceWidth /
                                                                        33) +
                                                                    3,
                                                            fontWeight: FontWeight
                                                                .normal),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
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
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(3.0),
                                                          child: Icon(
                                                            size:
                                                                deviceWidth > 600
                                                                    ? 28.0
                                                                    : 15.0,
                                                            Icons.close_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20.0,
                                                ),
                                                Text(
                                                  wishListItem.regularPrice != ""
                                                      ? "₹ ${wishListItem.regularPrice ?? 20000}"
                                                      : "₹ 20000",
                                                  // softWrap: true,
                                                  // overflow:
                                                  //     TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize:
                                                          (deviceWidth / 33) + 3),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height:
                                                  deviceWidth > 600 ? 50.0 : 38.0,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartProvider.addToCartId(
                                                          wishListItem.id!);
                                                      print(
                                                          "CART IDS : ${cartProvider.cartProductIds}");
                                        
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
                                                            ? Constants
                                                                .defaultImageUrl
                                                            : wishListItem
                                                                    .images[0]
                                                                    .src ??
                                                                Constants
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
                                        
                                                      value
                                                          .removeFromLocalWishlist(
                                                              wishListItem.id!);
                                        
                                                      value.removeFromWishlist(
                                                          wishListItem.id!);
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      5.0))),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 15.0,
                                                                vertical: 5.0),
                                                        child: Text(
                                                          "Move to Cart",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize:
                                                                  deviceWidth >
                                                                          600
                                                                      ? 25.0
                                                                      : 14.0),
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
                                                      width: deviceWidth > 600
                                                          ? 45.0
                                                          : 33.0,
                                                      height: deviceWidth > 600
                                                          ? 45.0
                                                          : 33.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          shape:
                                                              BoxShape.rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5.0)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(3.0),
                                                        child: Icon(Icons.share),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                              )),
                        );
                      },
                    ));
        }

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
        //                         ? Constants.defaultImageUrl
        //                         : wishListItem.images[0].src ??
        //                             Constants.defaultImageUrl,
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
        //                                           ? Constants
        //                                               .defaultImageUrl
        //                                           : wishListItem
        //                                                   .images[0]
        //                                                   .src ??
        //                                               Constants
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
