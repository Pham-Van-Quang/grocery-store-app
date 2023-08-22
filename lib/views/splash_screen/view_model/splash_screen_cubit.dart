import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/views/splash_screen/view_model/splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState(isLoading: true));

  void isLoading() {
    emit(state.copyWith(isLoading: state.isLoading));
  }
}
