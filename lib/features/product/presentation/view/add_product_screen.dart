import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wishlist_wishperer/features/product/presentation/view_model/product_view_model.dart';

class AddProductScreen extends HookConsumerWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlController = useTextEditingController();
    final priceController = useTextEditingController();
    final isFormValid = useState(false);

    void validateForm() {
      final url = urlController.text.trim();
      final price = double.tryParse(priceController.text.trim());
      isFormValid.value = url.isNotEmpty && price != null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'Product URL'),
              onChanged: (_) => validateForm(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (_) => validateForm(),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: isFormValid.value
                  ? () {
                      final url = urlController.text.trim();
                      final price = double.parse(priceController.text.trim());
                      ref.read(productProvider.notifier).addProduct(url, price);
                      Navigator.pop(context); // go back to home
                    }
                  : null,
              icon: const Icon(Icons.check),
              label: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
