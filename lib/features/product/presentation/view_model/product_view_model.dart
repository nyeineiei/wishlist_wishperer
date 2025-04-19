import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class ProductViewModel extends StateNotifier<ProductState> {
  ProductViewModel() : super(ProductState(products: []));

  void addProduct(String url, double price) {
    final newProduct = Product(url: url, price: price, isHidden: false);
    state = state.copyWith(
      products: [...state.products, newProduct],
    );
  }

  void clearAll() {
    state = state.copyWith(
      products: [],
    );
  }

  void publishWishlist() {
    state = state.copyWith(
      isPublished: true,
    );
  }

  void unpublishWishlist() {
    state = state.copyWith(
      isPublished: false,
    );
  }

  void toggleHide(int index) {
    final updatedProduct = state.products[index].copyWith(
      isHidden: !state.products[index].isHidden,
    );
    final updatedProducts = [...state.products];
    updatedProducts[index] = updatedProduct;

    state = state.copyWith(products: updatedProducts);
  }
}

final productProvider = StateNotifierProvider<ProductViewModel, ProductState>(
  (ref) => ProductViewModel(),
);
