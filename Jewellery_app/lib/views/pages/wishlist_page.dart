import 'package:Tiara_by_TJ/constants/fontsizes.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
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
                  Text(
                    "Your Wishlist is Empty",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: deviceWidth > 600
                            ? Fontsizes.tabletHeadingSize
                            : Fontsizes.headingSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Looks like you don't have added any jewelleries to your wishlist yet",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: deviceWidth > 600
                          ? Fontsizes.tabletTextFormInputFieldSize
                          : Fontsizes.textFormInputFieldSize,
                    ),
                  ),
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
                        child: Text(
                          "Continue Shopping",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: deviceWidth > 600
                                  ? Fontsizes.tabletButtonTextSize
                                  : Fontsizes.buttonTextSize),
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
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                        color: Colors.white,
                      ),
                    )
                  : ListView.builder(
                      itemCount: value.wishlistProducts.length,
                      itemBuilder: (context, index) {
                        final wishListItem = value.wishlistProducts[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Card(
                              elevation: 5.0,
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                // width: deviceWidth > 600
                                //     ? (deviceWidth / 3) - 60
                                //     : deviceWidth/2,
                                height: deviceWidth > 600
                                    ? (deviceWidth / 3) - 90
                                    : (deviceWidth / 2) - 60,
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
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color:  Theme.of(context).primaryColor,
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
                                                          ? (deviceWidth /
                                                                  1.46) -
                                                              10
                                                          : (deviceWidth / 2) -
                                                              10.0,
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
                                                            fontWeight:
                                                                FontWeight
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
                                                                wishListItem
                                                                    .id!);

                                                        value
                                                            .removeFromWishlist(
                                                                wishListItem
                                                                    .id!);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.black,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  3.0),
                                                          child: Icon(
                                                            size: deviceWidth >
                                                                    600
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
                                                  wishListItem.regularPrice !=
                                                          ""
                                                      ? "₹ ${wishListItem.regularPrice ?? 20000}"
                                                      : "₹ 20000",
                                                  // softWrap: true,
                                                  // overflow:
                                                  //     TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize:
                                                          (deviceWidth / 33) +
                                                              3),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: deviceWidth > 600
                                                  ? 50.0
                                                  : 38.0,
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
                                                                .images
                                                                .isNotEmpty
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
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    15.0,
                                                                vertical: 5.0),
                                                        child: Text(
                                                          "Move to Cart",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                    onTap: () async {
                                                      // await Share.shareUri(
                                                      //     Uri.parse(wishListItem
                                                      //                 .permalink !=
                                                      //             null
                                                      //         ? wishListItem
                                                      //             .permalink!
                                                      //         : "https://tiarabytj.com/"));
                                                      await Share.share(
                                                          "My Favourite 'Tiara by TJ' Design \n\n${wishListItem.name ?? "Jewellery"} \n\n ${wishListItem.permalink ?? "https://tiarabytj.com/"}");
                                                    },
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
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(3.0),
                                                        child: Icon(
                                                          Icons.share,
                                                          size:
                                                              deviceWidth > 600
                                                                  ? 25.0
                                                                  : 20.0,
                                                        ),
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
      }),
    );
  }
}
