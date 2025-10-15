import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_app/pages/sigin/provider/sign_in_state.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(const SignInState());

  void onUserEmailChange(String value) {
    state = state.coyWith(email: value);
  }

  void onUserPasswordChange(String value) {
    state = state.coyWith(password: value);
  }
}

// final signInNotifierProvider=StateNotifierProvider((ref)=> SignInNotifier()
// );

final signInNotifierProvider=StateNotifierProvider<SignInNotifier,SignInState>((ref)=> SignInNotifier()
);