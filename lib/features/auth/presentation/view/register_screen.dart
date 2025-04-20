import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wishlist_wishperer/features/auth/presentation/view_model/register_view_model.dart';
import 'login_screen.dart';
import 'package:wishlist_wishperer/common/widgets/password_field.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final state = ref.watch(registerViewModelProvider);
    final viewModel = ref.read(registerViewModelProvider.notifier);

    Future<void> _showDialog(String title, String message, {bool popBackToLogin = false}) async {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                if (popBackToLogin) {
                  Navigator.of(context).pop(); // go back to LoginScreen
                }
              },
            )
          ],
        ),
      );
    }

    ref.listen(registerViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        _showDialog("Success", "Registration completed.", popBackToLogin: true);
      } else if (next is AsyncError) {
        _showDialog("Error", "Registration failed: ${next.error}");
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // 👇 Reusing the password field from LoginScreen
            PasswordField(controller: passwordController),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state is AsyncLoading
                  ? null
                  : () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      viewModel.register(email, password);
                    },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}