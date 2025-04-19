import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/friend/presentation/view_model/friend_list_view_model.dart';
import 'friend_wishlist_screen.dart';

class FriendListScreen extends ConsumerWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = ref.watch(friendListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(friend.name),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FriendWishlistScreen(
                      friendId: friend.id,
                      friendName: friend.name!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
