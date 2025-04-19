import 'package:flutter/material.dart';
import 'package:wishlist_wishperer/features/friend/presentation/view/friend_wishlist_screen.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockFriends = [
      {'id': '1', 'name': 'Alice'},
      {'id': '2', 'name': 'Bob'},
      {'id': '3', 'name': 'Charlie'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mockFriends.length,
        itemBuilder: (context, index) {
          final friend = mockFriends[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(friend['name']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
