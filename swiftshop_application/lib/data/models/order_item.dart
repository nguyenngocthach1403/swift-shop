class OrderDetail {
  String id;
  String orderId;
  int price;
  String productId;
  int quantity;
  OrderDetail(
      {required this.id,
      required this.orderId,
      required this.price,
      required this.productId,
      required this.quantity});
}
