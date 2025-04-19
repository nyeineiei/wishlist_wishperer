import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/product/domain/model/product.dart';

final friendWishlistProvider = StateNotifierProvider.family<FriendWishlistViewModel, List<Product>, String>((ref, friendId) {
  return FriendWishlistViewModel(friendId);
});

class FriendWishlistViewModel extends StateNotifier<List<Product>> {
  final String friendId;

  FriendWishlistViewModel(this.friendId) : super([]) {
    _loadMockWishlist();
  }

  void _loadMockWishlist() {
    // Mock different wishlists per friend
    if (friendId == '1') {
      state = [
        Product(url: 'https://gift.com/headphones', price: 99.99),
        Product(url: 'https://gift.com/book', price: 19.99),
      ];
    } else if (friendId == '2') {
      state = [
        Product(url: 'https://gift.com/watch', price: 149.99),
      ];
    } else {
      state = []; // no products
    }
  }
}
