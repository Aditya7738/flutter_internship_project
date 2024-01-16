class WishlistProductModel {
  
  final String productName;
  final String productPrice;
  final String imageUrl;

  WishlistProductModel(
      {required this.productName,
      required this.productPrice,
      required this.imageUrl});

  WishlistProductModel.fromMap(Map<dynamic, dynamic> res)
      : productName = res['productName'],
        productPrice = res['productPrice'],
        imageUrl = res['imageUrl'];

  Map<String, Object?> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'imageUrl': imageUrl
    };
  }
}
