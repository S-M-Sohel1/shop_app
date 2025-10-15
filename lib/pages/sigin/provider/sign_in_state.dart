class SignInState {
  final String email;
  final String password;

  const  SignInState({this.email = "", this.password = ""});

  SignInState coyWith({
    String? userName,
    String? email,
    String? password,
    String? rePassword,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
