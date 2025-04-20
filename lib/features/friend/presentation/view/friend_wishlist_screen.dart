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
      body: friendProducts.products.isEmpty
          ? _buildEmptyState(context, friendName)
          : _buildProductList(friendProducts.products, ref),
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

  Widget _buildProductList(List<Product> products, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  product.url,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${product.participantCount} Participant(s)'),
                    const SizedBox(height: 4),
                    Text(
                      'Price: €${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      product.contributionStatus,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: product.isFullyPaid ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('See Details'),
                    TextButton(
                      onPressed: product.isFullyPaid || product.participantIds.contains('me')
                          ? null
                          : () {
                              // TODO: Show participation form
                              ref.read(friendWishlistProvider(friendId).notifier).participateInProduct(index, 'me', 50);
                            },
                      child: const Text('Participate'),
                    ),
                    if (product.participantIds.contains('me'))
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'You’re already participating',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
