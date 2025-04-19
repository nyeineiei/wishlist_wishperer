class Product {
  final String url;
  final double price;
  final bool isHidden;

  Product({
    required this.url,
    required this.price,
    this.isHidden = false,
  });

  Product copyWith({
    String? url,
    double? price,
    bool? isHidden,
  }) {
    return Product(
      url: url ?? this.url,
      price: price ?? this.price,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}
