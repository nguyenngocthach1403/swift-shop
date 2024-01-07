class Product {
  final String path;
  final String title;
  final String price;
  final String type;
  final String promotionalPrice;
  final String? quantitySold;
  final double? rate;
  Product(this.path, this.title, this.price, this.promotionalPrice, this.type,
      {required this.quantitySold, required this.rate});
  static List<Product> product = List.filled(
      0, Product("", "", "", "", "", quantitySold: "", rate: 2.3),
      growable: true);
}
