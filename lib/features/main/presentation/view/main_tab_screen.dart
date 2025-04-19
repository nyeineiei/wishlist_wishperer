import 'package:flutter/material.dart';
import 'package:wishlist_wishperer/features/product/presentation/view/home_screen.dart';
import 'package:wishlist_wishperer/features/friend/presentation/view/friend_list_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  final _pages = const [
    HomeScreen(),
    FriendListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) => setState(() => _currentIndex = newIndex),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'My Space',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Friends',
          ),
        ],
      ),
    );
  }
}
