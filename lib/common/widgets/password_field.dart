// 👇 Shared password field widget (you can move to a separate file if needed)
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordField extends HookWidget {
  final TextEditingController controller;
  final String label;

  const PasswordField({
    required this.controller,
    this.label = 'Password',
  });

  @override
  Widget build(BuildContext context) {
    final isObscured = useState(true);

    return TextField(
      controller: controller,
      obscureText: isObscured.value,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            isObscured.value ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => isObscured.value = !isObscured.value,
        ),
      ),
    );
  }
}
