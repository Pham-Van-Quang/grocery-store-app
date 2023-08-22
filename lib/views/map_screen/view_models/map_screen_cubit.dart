// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_store_app/views/map_screen/view_models/map_screen_state.dart';

class MapCubit extends Cubit<MapState> {
  late GoogleMapController mapController;
  MapCubit()
      : super(
          MapState(
            markers: <Marker>{},
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.030310524264387, 105.83593373169522),
              zoom: 10.0,
            ),
            selectedLocation:
                const LatLng(21.030310524264387, 105.83593373169522),
            currentAddress: '',
            currentMapPosition:
                const LatLng(21.030310524264387, 105.83593373169522),
          ),
        );

  void onAddMarkerButtonPressed() async {
    final newSelectedLocation = state.currentMapPosition;

    final marker = Marker(
      markerId: MarkerId(newSelectedLocation.toString()),
      position: newSelectedLocation,
      infoWindow: const InfoWindow(title: '', snippet: ''),
      icon: BitmapDescriptor.defaultMarker,
    );

    emit(state.copyWith(
      markers: {marker},
      selectedLocation: newSelectedLocation,
    ));

    getSelectedLocationAddress(newSelectedLocation);
  }

  void getSelectedLocationAddress(LatLng location) async {
    final placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (placemarks.isNotEmpty) {
      final currentPlace = placemarks.first;

      final houseNumber = currentPlace.subThoroughfare ?? '';
      final street = currentPlace.thoroughfare ?? '';
      final ward = currentPlace.subLocality ?? '';
      final district = currentPlace.locality ?? '';
      final city = currentPlace.administrativeArea ?? '';
      final country = currentPlace.country ?? '';

      final currentAddress =
          '$houseNumber, $street, $ward, $district, $city, $country';

      emit(state.copyWith(currentAddress: currentAddress));
    }
  }

  void onCameraMove(CameraPosition position) {
    emit(state.copyWith(currentMapPosition: position.target));
  }

  void onMapCreated(GoogleMapController controller) {
    getCurrentLocation(controller);
  }

  Future<void> getCurrentLocation(GoogleMapController controller) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    CameraPosition newPosition = const CameraPosition(
      target: LatLng(21.030310524264387, 105.83593373169522),
      zoom: 11.0,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }
}
