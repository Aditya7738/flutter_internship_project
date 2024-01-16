class CartProductModel {
  final int? cartProductid;
  final String? price;
  final String? productName;
  String? quantity = "1";
  final int? size;
  final String? deliveryDate;
  final String? imageUrl;

  CartProductModel(
      {required this.cartProductid,
      required this.price,
      required this.productName,
      required this.quantity,
      required this.size,
      required this.deliveryDate,
      required this.imageUrl,
      });

  CartProductModel.fromMap(Map<dynamic, dynamic> res)
      : cartProductid = res['cartProductid'],
        price = res['price'],
        productName = res['productName'],
        quantity = res['quantity'],
        size = res['size'],
        deliveryDate = res['deliveryDate'],
        imageUrl = res['imageUrl'];

  Map<String, Object?> toMap() {
    return {
      'cartProductid': cartProductid,
      'price': price,
      'productName': productName,
      'quantity': quantity,
      'size': size,
      'deliveryDate': deliveryDate,
      'imageUrl': imageUrl
    };
  }
}
