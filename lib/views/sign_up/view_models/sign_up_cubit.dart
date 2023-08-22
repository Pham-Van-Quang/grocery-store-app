import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/views/sign_up/view_models/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController reenterPassword = TextEditingController();
  SignUpCubit()
      : super(SignUpState(
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
