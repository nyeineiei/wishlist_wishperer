import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/friend/domain/model/friend.dart';

final friendListProvider =
    StateNotifierProvider<FriendListViewModel, List<Friend>>((ref) {
  return FriendListViewModel();
});

class FriendListViewModel extends StateNotifier<List<Friend>> {
  FriendListViewModel() : super([]) {
    _loadMockFriends();
  }

  void _loadMockFriends() {
    state = [
      Friend(id: '1', name: 'Alice'),
      Friend(id: '2', name: 'Bob'),
      Friend(id: '3', name: 'Charlie'),
    ];
  }
  // Future: addFriend(), removeFriend(), fetchFromBackend(), etc.
}
