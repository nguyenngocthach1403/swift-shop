class CartDetail {
  final String cartId;
  final String price;
  final int productId;
  final int quantity;
  CartDetail(
      {required this.cartId,
      required this.price,
      required this.productId,
      required this.quantity});

  static List<CartDetail> allItemOfCart = List.filled(
      0, CartDetail(cartId: '', price: '', productId: 0, quantity: 0),
      growable: true);
}
