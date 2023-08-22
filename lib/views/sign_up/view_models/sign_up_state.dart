// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignUpState {
  final bool showedPassword;
  final bool emailFocused;
  final bool passwordFocused;
  SignUpState({
    required this.showedPassword,
    required this.emailFocused,
    required this.passwordFocused,
  });

  SignUpState copyWith({
    bool? showedPassword,
    bool? emailFocused,
    bool? passwordFocused,
  }) {
    return SignUpState(
      showedPassword: showedPassword ?? this.showedPassword,
      emailFocused: emailFocused ?? this.emailFocused,
      passwordFocused: passwordFocused ?? this.passwordFocused,
    );
  }
}
