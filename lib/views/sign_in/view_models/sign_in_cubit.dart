import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/views/sign_in/view_models/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  SignInCubit()
      : super(SignInState(
            emailFocused: false,
            passwordFocused: false,
            showedPassword: false));

  void emailFocused() {
    emit(state.copyWith(emailFocused: !state.emailFocused));
  }

  void passwordFocused() {
    emit(state.copyWith(passwordFocused: !state.passwordFocused));
  }

  void showedPassword() {
    emit(state.copyWith(showedPassword: !state.showedPassword));
  }
}
