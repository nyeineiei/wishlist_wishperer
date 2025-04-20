import 'package:wishlist_wishperer/features/auth/domain/service/auth_service_interface.dart';
import 'dart:convert'; // for jsonEncode
import 'package:http/http.dart' as http;

class AuthServiceImpl implements AuthService {
  @override
  Future<void> registerUser(Map<String, dynamic> request) async {
    // You can use http or dio here
    final response = await http.post(
      Uri.parse('http://192.168.1.69:8000/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }
  }
}
