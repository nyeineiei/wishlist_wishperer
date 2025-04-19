import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishlist_wishperer/features/auth/domain/state/login_state.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(),
);

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(LoginState());

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  void login() {
    print('Logging in with ${state.email} / ${state.password}');
  }
}