import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/button_add.dart';
import 'package:grocery_store_app/router/app_routers.dart';
import 'package:grocery_store_app/views/home_page/model_view/homepage_cubit.dart';
import 'package:grocery_store_app/views/home_page/model_view/homepage_state.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.currentAddress});

  final String currentAddress;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _homepageCubit = context.read<HomepageCubit>();
  List bannerList = [
    "assets/images/banner-1.jpg",
    "assets/images/banner-2.jpg"
  ];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _homepageCubit.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 56.h, left: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HomepageHeader(),
                    SizedBox(height: 28.h),
                    _SearchProduct(homepageCubit: _homepageCubit),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 191,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                              bannerList[random.nextInt(bannerList.length)],
                              fit: BoxFit.fill),
                        ),
                        SizedBox(height: 24.h),
                        Text('Phổ biến',
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: 10.h),
                        listOfProduct(state)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Stack listOfProduct(HomepageState state) {
    return Stack(children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.isSearching
                              ? state.initialProductList.length
                              : state.filteredProductList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            childAspectRatio: 160 / 211,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRouterName.productinfor,
                                  arguments:
                                      state.filteredProductList.isNotEmpty
                                          ? state.filteredProductList[index]
                                          : state.initialProductList[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 20)
                                  ]),
                              child: Stack(children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  top: 0,
                                  left: 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          height: 132.h,
                                          width: 127.w,
                                          child: Image.network(state
                                                  .productList[index]
                                                  .imageUrl ??
                                              "")),
                                      SizedBox(height: 5.h),
                                      Text(
                                          state.productList[index].name ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      SizedBox(height: 6.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: NumberFormat("#,##0")
                                                    .format(state
                                                        .productList[index]
                                                        .price),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            TextSpan(
                                                text:
                                                    "/ ${state.productList[index].unit}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                          ])),
                                          ButtonAdd(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        if (state.dataState == HomeDataState.isLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                      ]);
  }
}

class _SearchProduct extends StatelessWidget {
  const _SearchProduct({
    required HomepageCubit homepageCubit,
  }) : _homepageCubit = homepageCubit;

  final HomepageCubit _homepageCubit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _homepageCubit.search,
      onEditingComplete: () {
        _homepageCubit
            .filterProducts(_homepageCubit.search.text);
      },
      onChanged: (valueInput) {
        if (valueInput.isNotEmpty) {
          _homepageCubit.filterProducts(valueInput);
        }
      },
      onTap: () => _homepageCubit.isSearchFocused(),
      onSubmitted: (value) => _homepageCubit.isSearchFocused(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: 13.h, horizontal: 17.w),
          filled: true,
          prefixIcon: SizedBox(
            width: 24.w,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/search.svg',
              ),
            ),
          ),
          hintText: 'Tìm kiếm...',
          hintStyle: TextStyle(
              fontSize: 15.sp,
              color: const Color(0xff565656),
              fontWeight: FontWeight.normal),
          fillColor: const Color(0xffEDEDED),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none)),
    );
  }
}

class _HomepageHeader extends StatelessWidget {
  const _HomepageHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: 25.h,
            child: Center(
                child: SvgPicture.asset(
                    'assets/icons/person-3.svg'))),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 14.w),
          child: Text(
              FirebaseAuth.instance.currentUser?.displayName ??
                  "",
              style: Theme.of(context).textTheme.titleMedium),
        )),
        SizedBox(
            height: 25.h,
            child: Center(
                child: SvgPicture.asset(
                    'assets/icons/notification.svg')))
      ],
    );
  }
}