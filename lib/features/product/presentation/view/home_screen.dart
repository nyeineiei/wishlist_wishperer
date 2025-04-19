import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/auth/presentation/view/login_screen.dart';
import 'package:wishlist_wishperer/features/product/presentation/view/add_product_screen.dart';
import 'package:wishlist_wishperer/features/product/presentation/view_model/product_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    final products = state.products;
    final isPublished = state.isPublished;   

    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: products.isEmpty
        ? _buildEmptyState(context)
        :Column(
          children: [
            _buildPublishToggle(context, ref, isPublished),
            Expanded(child: _buildProductList(products, ref)),
          ],
        ),
      floatingActionButton: products.isEmpty
        ? null
        :FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 96,
              color: colorScheme.outlineVariant,
            ),
            const SizedBox(height: 24),
            Text(
              'No Products',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Looks like you haven’t added any products yet.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddProductScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products, WidgetRef ref) {
    final notifier = ref.read(productProvider.notifier);

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = products[index];

        return Dismissible(
          key: ValueKey(product.url + product.price.toString()),
          direction: DismissDirection.horizontal, // allow both directions
          confirmDismiss: (direction) async {
            notifier.toggleHide(index);
            return false; // prevent it from being dismissed (we just toggle state)
          },
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.green.shade200,
            child: const Row(
              children: [
                Icon(Icons.visibility, color: Colors.white),
                SizedBox(width: 8),
                Text('Unhide', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.red.shade300,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Hide', style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.visibility_off, color: Colors.white),
              ],
            ),
          ),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: product.isHidden
                ? Colors.grey.shade300
                : Theme.of(context).cardColor,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(product.url),
              subtitle: Text('€${product.price.toStringAsFixed(2)}'),
              leading: Icon(
                Icons.link,
                color: product.isHidden ? Colors.grey : null,
              ),
              trailing: product.isHidden
                  ? const Icon(Icons.visibility_off, color: Colors.grey)
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPublishToggle(
    BuildContext context, WidgetRef ref, bool isPublished) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Make Wishlist Public'),
        subtitle: Text(
          isPublished
              ? 'Your friends can now see your wishlist.'
              : 'Your wishlist is private.',
        ),
        value: isPublished,
        onChanged: (value) async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(value ? 'Publish Wishlist?' : 'Unpublish Wishlist?'),
              content: Text(
                value
                    ? 'This will make your wishlist visible to friends.'
                    : 'Your friends will no longer see your wishlist.',
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ),
          );

          if (confirmed == true) {
            final notifier = ref.read(productProvider.notifier);
            value ? notifier.publishWishlist() : notifier.unpublishWishlist();
          }
        },
      ),
    );
  }
}
