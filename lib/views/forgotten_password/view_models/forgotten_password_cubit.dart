import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/views/forgotten_password/view_models/forgotten_password_state.dart';

class ForgottenPasswordCubit extends Cubit<ForgottenPasswordState> {
  TextEditingController email = TextEditingController();
  final FirebaseAuth _firebaseAuth;
  ForgottenPasswordCubit(this._firebaseAuth)
      : super(ForgottenPasswordState(
            isEmailFocused: false, isResettingPassword: false));

  Future<void> resetPassword(String email) async {
    try {
      emit(state.copyWith(isResettingPassword: true));
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      emit(state.copyWith(isResettingPassword: false));
    } on FirebaseAuthException catch (e) {
      print(e);
      emit(state.copyWith(isResettingPassword: false));
    }
  }

  void isEmailFocused() {
    emit(state.copyWith(isEmailFocused: !state.isEmailFocused));
  }
}
