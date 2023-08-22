// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignInState {
  final bool showedPassword;
  final bool emailFocused;
  final bool passwordFocused;
  SignInState({
    required this.showedPassword,
    required this.emailFocused,
    required this.passwordFocused,
  });

  SignInState copyWith({
    bool? showedPassword,
    bool? emailFocused,
    bool? passwordFocused,
  }) {
    return SignInState(
      showedPassword: showedPassword ?? this.showedPassword,
      emailFocused: emailFocused ?? this.emailFocused,
      passwordFocused: passwordFocused ?? this.passwordFocused,
    );
  }
}
