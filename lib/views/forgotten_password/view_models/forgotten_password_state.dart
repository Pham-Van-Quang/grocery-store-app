// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForgottenPasswordState {
  final bool isEmailFocused;
  final bool isResettingPassword;

  ForgottenPasswordState({
    required this.isEmailFocused,
    required this.isResettingPassword,
  });

  ForgottenPasswordState copyWith(
      {bool? isEmailFocused, bool? isResettingPassword}) {
    return ForgottenPasswordState(
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
      isResettingPassword: isResettingPassword ?? this.isResettingPassword,
    );
  }
}
