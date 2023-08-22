import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:location/location.dart';

class TrackingOrder extends StatefulWidget {
  const TrackingOrder({super.key});

  @override
  State<TrackingOrder> createState() => _TrackingOrderState();
}

class _TrackingOrderState extends State<TrackingOrder> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(0, 0);
  static const LatLng destination = LatLng(21.0382015, 105.7827311);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 13.5,
        target: LatLng(
          newLoc.latitude!,
          newLoc.longitude!,
        ),
      )));
    });
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/pin.png")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/pin.png")
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/pin.png")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _TrackingOrderHeader(),
          _TrackShipper(
              currentLocation: currentLocation,
              polylineCoordinates: polylineCoordinates,
              currentLocationIcon: currentLocationIcon,
              sourceIcon: sourceIcon,
              sourceLocation: sourceLocation,
              destinationIcon: destinationIcon,
              destination: destination,
              controller: _controller),
        ],
      ),
    );
  }
}

class _TrackingOrderHeader extends StatelessWidget {
  const _TrackingOrderHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 54.h, 20.w, 26.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackArrow(onTap: () {
            Navigator.pop(context);
          }),
          Text('Theo dõi', style: Theme.of(context).textTheme.displayMedium),
          SizedBox(
            width: 22.w,
            height: 18.h,
          ),
        ],
      ),
    );
  }
}

class _TrackShipper extends StatelessWidget {
  const _TrackShipper({
    required this.currentLocation,
    required this.polylineCoordinates,
    required this.currentLocationIcon,
    required this.sourceIcon,
    required this.sourceLocation,
    required this.destinationIcon,
    required this.destination,
    required Completer<GoogleMapController> controller,
  }) : _controller = controller;

  final LocationData? currentLocation;
  final List<LatLng> polylineCoordinates;
  final BitmapDescriptor currentLocationIcon;
  final BitmapDescriptor sourceIcon;
  final LatLng sourceLocation;
  final BitmapDescriptor destinationIcon;
  final LatLng destination;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target:
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 14.5),
        polylines: {
          Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: kPrimaryColor,
              width: 6)
        },
        markers: {
          Marker(
            markerId: const MarkerId("currentLocation"),
            icon: currentLocationIcon,
            position:
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          ),
          Marker(
            markerId: const MarkerId("source"),
            icon: sourceIcon,
            position: sourceLocation,
          ),
          Marker(
            markerId: const MarkerId("destination"),
            icon: destinationIcon,
            position: destination,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}
