import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/product/domain/model/product.dart';
import 'package:wishlist_wishperer/features/product/domain/state/product_state.dart';

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
