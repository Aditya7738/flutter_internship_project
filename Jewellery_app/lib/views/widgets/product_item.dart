import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/constants/strings.dart';
import 'package:Tiara_by_TJ/helpers/date_helper.dart';
import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/model/products_model.dart';
import 'package:Tiara_by_TJ/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:Tiara_by_TJ/providers/wishlist_provider.dart';
import 'package:Tiara_by_TJ/views/pages/product_details_page.dart';

class ProductItem extends StatefulWidget {
  final ProductsModel productsModel;
  const ProductItem({super.key, required this.productsModel});

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
    final cartProvider = Provider.of<CartProvider>(context);

    print(productsModel.toJson());
    return GestureDetector(
      onTap: () {
        print("CATEGORY PRODUCT PRESSED");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ProductDetailsPage(productsModel: productsModel)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              productsModel.images.isEmpty ||
                      productsModel.images[0].src == null
                  ? ClipRRect(
                    child: Image.asset("assets/images/image_placeholder.jpg",
                        width: (MediaQuery.of(context).size.width / 2) + 16.0,
                        height: (MediaQuery.of(context).size.width / 2) + 10.0
                        ),
                  )
                  : Image.network(
                      productsModel.images.isEmpty
                          ? Strings.defaultImageUrl
                          : productsModel.images[0].src ??
                              Strings.defaultImageUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width / 2) + 16.0,
                          height:
                              (MediaQuery.of(context).size.width / 2) + 10.0,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                      width: (MediaQuery.of(context).size.width / 2) + 16.0,
                      height: (MediaQuery.of(context).size.width / 2) + 10.0,
                      fit: BoxFit.fill,
                    ),
              Positioned(
                right: 5.0,
                top: 5.0,
                child: IconButton(
                    icon: Icon(
                      wishListProvider.favProductIds.contains(productsModel.id)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                      size: 30.0,
                    ),
                    onPressed: () {
                      print("PRESSED");
                      if (wishListProvider.favProductIds
                          .contains(productsModel.id)) {
                        wishListProvider.removeFromWishlist(productsModel.id!);
                        print("Product is removed from wishlist");
                      } else {
                        wishListProvider.addToWishlist(productsModel.id!);
                        print("Product is added to wishlist");
                      }
                    }),
              ),
              Positioned(
                  bottom: 10.0,
                  left: 5.0,
                  child: Center(
                      child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 2, // Border width
                      ),
                      borderRadius: BorderRadius.circular(18), // Border radius
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          productsModel.averageRating ?? "3.5",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                  )))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 50,
                    child: Text(
                      productsModel.name ?? "Jewellery",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  productsModel.salePrice == ""
                      ? Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/rupee.png",
                              width: 19.0,
                              height: 17.0,
                            ),
                            Text(
                              productsModel.regularPrice != ""
                                  ? productsModel.regularPrice ?? "20000"
                                  : "0.0",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Image.asset(
                              "assets/images/rupee.png",
                              width: 19.0,
                              height: 17.0,
                            ),
                            Text(
                                productsModel.salePrice == ""
                                    ? "10,000"
                                    : productsModel.salePrice ?? "10,000",
                                style: Theme.of(context).textTheme.headline3),
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
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (cartProvider.cartProductIds
                          .contains(productsModel.id)) {
                        cartProvider.removeFromCartId(productsModel.id!);

                        cartProvider.removeFromCart(CartProductModel(
                            cartProductid: productsModel.id,
                            price: productsModel.regularPrice != ""
                                ? productsModel.regularPrice ?? "20000"
                                : "0.0",
                            productName: productsModel.name,
                            quantity: "1",
                            size: 5,
                            deliveryDate: DateHelper.getCurrentDateInWords(),
                            imageUrl: productsModel.images.isEmpty
                                ? Strings.defaultImageUrl
                                : productsModel.images[0].src ??
                                    Strings.defaultImageUrl,
                            sku: productsModel.sku,
                            imageId: productsModel.images.isNotEmpty
                                ? productsModel.images[0].id
                                : 0));
                      } else {
                        cartProvider.addToCartId(productsModel.id!);
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
                            sku: productsModel.sku,
                            imageId: productsModel.images.isNotEmpty
                                ? productsModel.images[0].id
                                : 0));
                      }
                    },
                    child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: cartProvider.cartProductIds
                                .contains(productsModel.id)
                            ? const Icon(Icons.shopping_cart)
                            : const Icon(Icons.add_shopping_cart_rounded)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
