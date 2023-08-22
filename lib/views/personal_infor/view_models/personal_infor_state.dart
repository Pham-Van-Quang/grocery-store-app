// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class PersonalInforState {
  final XFile? currentPicture;
  final String? uploadedFileURL;
  final bool emailFocused;
  final bool phoneNumberFocused;
  final bool userNameFocused;
  PersonalInforState({
    this.currentPicture,
    this.uploadedFileURL,
    required this.emailFocused,
    required this.phoneNumberFocused,
    required this.userNameFocused,
  });

  PersonalInforState copyWith(
      {XFile? currentPicture,
      String? uploadedFileURL,
      bool? emailFocused,
      bool? phoneNumberFocused,
      bool? userNameFocused}) {
    return PersonalInforState(
      currentPicture: currentPicture ?? this.currentPicture,
      uploadedFileURL: uploadedFileURL ?? this.uploadedFileURL,
      emailFocused: emailFocused ?? this.emailFocused,
      phoneNumberFocused: phoneNumberFocused ?? this.phoneNumberFocused,
      userNameFocused: userNameFocused ?? this.userNameFocused,
    );
  }
}
