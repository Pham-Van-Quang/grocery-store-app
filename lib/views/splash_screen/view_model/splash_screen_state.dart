// ignore_for_file: public_member_api_docs, sort_constructors_first
class SplashScreenState {
  final bool isLoading;
  SplashScreenState({
    required this.isLoading,
  });

  SplashScreenState copyWith({
    bool? isLoading,
  }) {
    return SplashScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
