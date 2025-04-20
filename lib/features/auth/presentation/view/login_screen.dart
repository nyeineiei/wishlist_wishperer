import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wishlist_wishperer/features/auth/presentation/view/register_screen.dart';
import 'package:wishlist_wishperer/features/auth/presentation/view_model/login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wishlist_wishperer/features/main/presentation/view/main_tab_screen.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = useState(false);
    final viewModel = ref.watch(loginViewModelProvider);
    final notifier = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 👆 Social login buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _SocialIconButton(asset: 'assets/icons/google.png'),
                _SocialIconButton(asset: 'assets/icons/apple.png'),
                _SocialIconButton(asset: 'assets/icons/x.png'),
              ],
            ),
            const SizedBox(height: 24),

            // 👇 Divider with "OR"
            Row(
              children: const [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('OR'),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 24),

            // Email TextField
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: notifier.updateEmail,
            ),

            const SizedBox(height: 16),

            // Password TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                ),
              ),
              obscureText: !isPasswordVisible.value,
              onChanged: notifier.updatePassword,
            ),

            const SizedBox(height: 16),

            // Remember me checkbox
            Row(
              children: [
                Checkbox(
                  value: viewModel.rememberMe,
                  onChanged: (_) => notifier.toggleRememberMe(),
                ),
                const Text('Remember me'),
              ],
            ),

            const SizedBox(height: 24),

            // Sign In Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainTabScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to registration screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(), 
                  ),
                );
              },
              child: const Text("Don't have an account? Create one"),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final String asset;

  const _SocialIconButton({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(asset),
    );
  }
}
