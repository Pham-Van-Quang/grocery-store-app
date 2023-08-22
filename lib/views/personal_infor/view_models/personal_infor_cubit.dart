// ignore_for_file: unused_local_variable

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/authentication.dart';
import 'package:grocery_store_app/views/personal_infor/view_models/personal_infor_state.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInforCubit extends Cubit<PersonalInforState> {
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  PersonalInforCubit()
      : super(PersonalInforState(
          emailFocused: false,
          phoneNumberFocused: false,
          userNameFocused: false,
        ));

  getProfilePicture() async {
    final storageRef = FirebaseStorage.instance.ref();
    final profileImagesRef =
        storageRef.child("images/${Auth().currentUser?.email ?? ""}.jpg");

    profileImagesRef.getDownloadURL().then((fileURL) {
      emit(state.copyWith(uploadedFileURL: fileURL));
      Auth().updateUserPhoto(fileURL);
    });
  }

  pickImage({bool isFromCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo;
    final storage = FirebaseStorage.instance;
    if (isFromCamera) {
      photo = await picker.pickImage(source: ImageSource.camera);
    } else {
      photo = await picker.pickImage(source: ImageSource.gallery);
    }
    if (photo != null) {
      emit(state.copyWith(currentPicture: photo));
    }
    print(photo?.path);
  }

  void emailFocused() {
    emit(state.copyWith(emailFocused: !state.emailFocused));
  }

  void phoneNumberFocused() {
    emit(state.copyWith(phoneNumberFocused: !state.phoneNumberFocused));
  }

  void userNameFocused() {
    emit(state.copyWith(userNameFocused: !state.userNameFocused));
  }
}
