class Product {
  final String url;
  final double price;
  final bool isHidden;
  final double contributedAmount;
  final List<String> participantIds;

  Product({
    required this.url,
    required this.price,
    this.isHidden = false,
    this.contributedAmount = 0.0,
    this.participantIds = const [],
  });

  Product copyWith({
    String? url,
    double? price,
    bool? isHidden,
    double? contributedAmount,
    List<String>? participantIds,
  }) {
    return Product(
      url: url ?? this.url,
      price: price ?? this.price,
      isHidden: isHidden ?? this.isHidden,
      contributedAmount: contributedAmount ?? this.contributedAmount,
      participantIds: participantIds ?? this.participantIds,
    );
  }
}
