// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/views/cart/cart.dart';
import 'package:grocery_store_app/views/map_screen/view_models/map_screen_cubit.dart';
import 'package:grocery_store_app/views/map_screen/view_models/map_screen_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                _map(context, state),
                _chooseAvenue(state, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding _chooseAvenue(MapState state, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 14.w),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 20.h,
                child: Center(
                  child: SvgPicture.asset('assets/icons/location.svg'),
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              Text(
                state.currentAddress,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(
                    currentAddress: state.currentAddress,
                  ),
                ),
              );
            },
            text: 'Xác nhận',
          ),
        ],
      ),
    );
  }

  Expanded _map(BuildContext context, MapState state) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          GoogleMap(
              onMapCreated: (controller) {
                context.read<MapCubit>().onMapCreated(controller);
              },
              initialCameraPosition: state.initialCameraPosition,
              markers: state.markers,
              onCameraMove: (position) {
                context.read<MapCubit>().onCameraMove(position);
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  context.read<MapCubit>().onAddMarkerButtonPressed();
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.white,
                child: SvgPicture.asset('assets/icons/location.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
