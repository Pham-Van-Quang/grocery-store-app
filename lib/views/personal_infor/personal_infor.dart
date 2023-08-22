// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/authentication.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/common/personal_infor_field.dart';
import 'package:grocery_store_app/views/personal_infor/view_models/personal_infor_cubit.dart';
import 'package:grocery_store_app/views/personal_infor/view_models/personal_infor_state.dart';

class PersonalInfor extends StatefulWidget {
  const PersonalInfor({super.key});

  @override
  State<PersonalInfor> createState() => _PersonalInforState();
}

class _PersonalInforState extends State<PersonalInfor> {
  final storage = FirebaseStorage.instance;
  late final _personalInforCubit = context.read<PersonalInforCubit>();

  @override
  void initState() {
    _personalInforCubit;
    _personalInforCubit.getProfilePicture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInforCubit, PersonalInforState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
            child: Column(
              children: [
                const _PersonalInforHeader(),
                SizedBox(height: 54.h),
                _chooseAvatar(state, context),
                SizedBox(height: 66.h),
                PersonalinforField(
                  controller: _personalInforCubit.userName,
                  onTap: () => state.userNameFocused,
                  onChanged: (value) => state.userNameFocused,
                  hintText: 'Họ và tên',
                  child_1: SvgPicture.asset('assets/icons/person-2.svg'),
                ),
                PersonalinforField(
                  controller: _personalInforCubit.phoneNumber,
                  onTap: () => state.phoneNumberFocused,
                  onChanged: (value) => state.phoneNumberFocused,
                  hintText: 'Số điện thoại',
                  child_1: SvgPicture.asset('assets/icons/phone.svg'),
                ),
                PersonalinforField(
                  controller: _personalInforCubit.email,
                  onTap: () => state.emailFocused,
                  onChanged: (value) => state.emailFocused,
                  hintText: 'Email',
                  child_1: SvgPicture.asset('assets/icons/envelop.svg'),
                ),
                SizedBox(height: 244.h),
                _confirm(state)
              ],
            ),
          ),
        );
      },
    );
  }

  CustomButton _confirm(PersonalInforState state) {
    return CustomButton(
                onPressed: () async {
                  final storageRef = FirebaseStorage.instance.ref();
                  final profileImagesRef = storageRef
                      .child("images/${Auth().currentUser?.email ?? ""}.jpg");
                  final uploadTask = await profileImagesRef
                      .putFile(File(state.currentPicture?.path ?? ""));
                  print('File Uploaded');
                  profileImagesRef.getDownloadURL().then((fileURL) {
                    state.uploadedFileURL;
                  });
                },
                text: 'Cập nhật',
              );
  }

  Stack _chooseAvatar(PersonalInforState state, BuildContext context) {
    return Stack(
                children: [
                  Container(
                    height: 98.w,
                    width: 98.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.08)),
                        ]),
                    padding: EdgeInsets.all(3.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: state.currentPicture != null
                          ? Image.file(
                              File(state.currentPicture?.path ?? ""),
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              state.uploadedFileURL ?? "",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.h),
                                    child: CupertinoActionSheet(
                                      actions: <CupertinoActionSheetAction>[
                                        CupertinoActionSheetAction(
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _personalInforCubit.pickImage();
                                          },
                                          child: Text('Chọn ảnh từ thư viện',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _personalInforCubit.pickImage(
                                                isFromCamera: true);
                                          },
                                          child: Text(
                                            'Chụp ảnh',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                      ],
                                      cancelButton: CupertinoButton(
                                          color: const Color(0xffF52825),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Hủy",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'SVN-Avo',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16))),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 33.h,
                            width: 33.h,
                            decoration: const BoxDecoration(
                                color: kPrimaryColor, shape: BoxShape.circle),
                            child: SizedBox(
                                width: 17.w,
                                child: Center(
                                    child: SvgPicture.asset(
                                        'assets/icons/camera.svg'))),
                          )))
                ],
              );
  }
}

class _PersonalInforHeader extends StatelessWidget {
  const _PersonalInforHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackArrow(onTap: () {
          Navigator.pop(context);
        }),
        Text('Thông tin cá nhân',
            style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          width: 22.w,
          height: 18.h,
        )
      ],
    );
  }
}
