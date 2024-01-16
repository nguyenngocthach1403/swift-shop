class CartDetail {
  final String cartdetailId;
  final String cartId;
  final int price;
  final String productId;
  final int quantity;
  CartDetail(this.cartdetailId,
      {required this.cartId,
      required this.price,
      required this.productId,
      required this.quantity});

  static List<CartDetail> allItemOfCart = List.filled(
      0, CartDetail("", cartId: '', price: 0, productId: '', quantity: 0),
      growable: true);
}
