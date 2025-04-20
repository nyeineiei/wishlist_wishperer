import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/auth/domain/service/auth_service_interface.dart';
import 'package:wishlist_wishperer/features/auth/domain/service/auth_service_impl.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthServiceImpl(); // concrete implementation
});