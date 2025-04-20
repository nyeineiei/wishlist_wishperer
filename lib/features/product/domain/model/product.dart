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

// Enabled if contributedAmount < price
// Disabled if already fully paid (contributedAmount >= price)
// this is business logic tied to data. So, add as a computed property:
extension ProductExtensions on Product {
  bool get isFullyPaid => contributedAmount >= price;

  String get contributionStatus {
    final missing = price - contributedAmount;
    return isFullyPaid ? 'Paid' : 'missing €${missing.toStringAsFixed(0)}';
  }

  int get participantCount => participantIds.length;
}