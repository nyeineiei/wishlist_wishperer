import "package:wishlist_wishperer/features/product/domain/model/product.dart";

// This model holds all the state related to the product screen — following single responsibility.
class ProductState {
  final List<Product> products;
  final bool isPublished;

  ProductState({
    required this.products,
    this.isPublished = false
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isPublished
  }) {
    return ProductState(
      products: products ?? this.products,
      isPublished: isPublished ?? this.isPublished
    );
  }
}
