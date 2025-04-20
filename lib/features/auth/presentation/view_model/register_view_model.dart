import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wishlist_wishperer/features/auth/data/auth_service_provider.dart';
import 'package:wishlist_wishperer/features/auth/domain/service/auth_service_interface.dart';

final registerViewModelProvider = StateNotifierProvider<RegisterViewModel, AsyncValue<void>>(
  (ref) {
    final authService = ref.read(authServiceProvider); // assuming you’ve set up a provider for AuthService
    return RegisterViewModel(authService);
  },
);

class RegisterViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthService authService;

  RegisterViewModel(this.authService) : super(const AsyncData(null));

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();

    try {
      await authService.registerUser({
        'email': email,
        'password': password,
      });
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
