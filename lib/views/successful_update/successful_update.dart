import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/router/app_routers.dart';

class SuccessfulUpdate extends StatefulWidget {
  const SuccessfulUpdate({super.key});

  @override
  State<SuccessfulUpdate> createState() => _SuccessfulUpdateState();
}

class _SuccessfulUpdateState extends State<SuccessfulUpdate> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(
        context, AppRouterName.homepage
      );
     }
    );
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SvgPicture.asset('assets/icons/image-6.svg'),
          SizedBox(height: 154.h),
          Text('Cập nhật thông tin thành công!',
          style: Theme.of(context).textTheme.displaySmall)
        ],
      ),
    );
  }
}