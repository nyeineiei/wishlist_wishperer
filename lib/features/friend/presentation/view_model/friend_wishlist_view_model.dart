import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/friend/domain/state/friend_wishlist_state.dart';
import 'package:wishlist_wishperer/features/product/domain/model/product.dart';

final friendWishlistProvider = StateNotifierProvider.family<FriendWishlistViewModel, FriendWishlistState, String>((ref, friendId) {
  return FriendWishlistViewModel(friendId);
});

class FriendWishlistViewModel extends StateNotifier<FriendWishlistState> {
  final String friendId;

  FriendWishlistViewModel(this.friendId)
      : super(FriendWishlistState(products: [])) {
    _loadMockWishlist();
  }

  void _loadMockWishlist() {
    switch (friendId) {
      case '1':
        state = FriendWishlistState(products: [
          Product(url: 'Item 1', price: 200, contributedAmount: 200, participantIds: ['me', 'bob']),
          Product(url: 'Item 2', price: 65, contributedAmount: 65, participantIds: ['me']),
          Product(url: 'Item 3', price: 360, contributedAmount: 200, participantIds: ['me', 'jane']),
          Product(url: 'Item 4', price: 240, contributedAmount: 0, participantIds: []),
        ]);
        break;

      case '2':
        state = FriendWishlistState(products: [
          Product(url: 'Nintendo Switch', price: 450, contributedAmount: 300, participantIds: ['me', 'jack']),
          Product(url: 'Zelda Game', price: 80, contributedAmount: 80, participantIds: ['me']),
        ]);
        break;

      case '3':
        state = FriendWishlistState(products: [
          Product(url: 'Cooking Pan Set', price: 120, contributedAmount: 0, participantIds: []),
          Product(url: 'Knife Set', price: 60, contributedAmount: 40, participantIds: ['me']),
        ]);
        break;

      default:
        state = FriendWishlistState(products: []);
    }
  }

  void participateInProduct(int index, String userId, double amount) {
    final product = state.products[index];
    final updated = product.copyWith(
      contributedAmount: product.contributedAmount + amount,
      participantIds: [...product.participantIds, userId],
    );

    final updatedList = [...state.products];
    updatedList[index] = updated;

    state = state.copyWith(products: updatedList);
  }
}
