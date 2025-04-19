import 'package:wishlist_wishperer/features/product/domain/model/product.dart';

class FriendWishlistState {
  final List<Product> products;

  FriendWishlistState({required this.products});

  FriendWishlistState copyWith({List<Product>? products}) {
    return FriendWishlistState(
      products: products ?? this.products,
    );
  }
}
