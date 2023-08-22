// ignore_for_file: avoid_unnecessary_containers, unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';
import 'package:grocery_store_app/network/repositories/home_responsitory_impl.dart';
import 'package:grocery_store_app/views/account/account.dart';
import 'package:grocery_store_app/views/cart/cart.dart';
import 'package:grocery_store_app/views/home_page/homepage.dart';
import 'package:grocery_store_app/views/home_page/model_view/homepage_cubit.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.currentAddress,
    ProductData? productData,
  });
  final String currentAddress;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  ProductData? cartProduct;

  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final pages = <Widget>[
    BlocProvider(
      create: (context) => HomepageCubit(HomeResponsitoryImpl()),
      child: const HomePage(
        currentAddress: '',
      ),
    ),
    const Cart(
      currentAddress: '',
    ),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [pages[selectedIndex]],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 68.h,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)
          ]),
          padding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomAppBarItem(context,
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: selectedIndex == 0 ? kPrimaryColor : null,
                  ),
                  label: "Trang chủ",
                  page: 0),
              _bottomAppBarItem(context,
                  icon: SvgPicture.asset(
                    'assets/icons/cart.svg',
                    color: selectedIndex == 1 ? kPrimaryColor : null,
                  ),
                  label: "Giỏ hàng",
                  page: 1),
              _bottomAppBarItem(context,
                  icon: SvgPicture.asset(
                    'assets/icons/account.svg',
                    color: selectedIndex == 2 ? kPrimaryColor : null,
                  ),
                  label: "Tài khoản",
                  page: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {
        onTabSelected(page);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Text(label,
              style: TextStyle(
                  color: selectedIndex == page ? kPrimaryColor : kThirdColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
