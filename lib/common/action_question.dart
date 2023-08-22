import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionQuestion extends StatelessWidget {
  const ActionQuestion(
      {super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: onPressed,
            child: Text(text, style: Theme.of(context).textTheme.titleLarge),
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
  }
}
