import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class LoginState {
  final String email;
  final String password;
  final bool rememberMe;

  LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
