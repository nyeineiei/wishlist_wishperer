import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/friend/presentation/view_model/friend_wishlist_view_model.dart';
import 'package:wishlist_wishperer/features/product/domain/model/product.dart';

class FriendWishlistScreen extends ConsumerWidget {
  final String friendId;
  final String friendName;

  const FriendWishlistScreen({
    super.key, 
    required this.friendId, 
    required this.friendName
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendProducts = ref.watch(friendWishlistProvider(friendId));

    return Scaffold(
      appBar: AppBar(
        title: Text("$friendName's Wishlist"),
      ),
      body: friendProducts.isEmpty
          ? _buildEmptyState(context, friendName)
          : _buildProductList(friendProducts),
    );
  }

  Widget _buildEmptyState(BuildContext context, String name) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox, size: 96, color: colorScheme.outlineVariant),
            const SizedBox(height: 24),
            Text(
              'No Products',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "Looks like $name hasn’t added any products yet.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: ListTile(
            title: Text(product.url),
            subtitle: Text('€${product.price.toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}
