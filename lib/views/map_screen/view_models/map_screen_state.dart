// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final Set<Marker> markers;
  final CameraPosition initialCameraPosition;
  final LatLng selectedLocation;
  final String currentAddress;
  final LatLng currentMapPosition;

  MapState({
    required this.markers,
    required this.initialCameraPosition,
    required this.selectedLocation,
    required this.currentAddress,
    required this.currentMapPosition,
  });

  MapState copyWith(
      {Set<Marker>? markers,
      CameraPosition? initialCameraPosition,
      LatLng? selectedLocation,
      String? currentAddress,
      LatLng? currentMapPosition}) {
    return MapState(
      markers: markers ?? this.markers,
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      currentAddress: currentAddress ?? this.currentAddress,
      currentMapPosition: currentMapPosition ?? this.currentMapPosition,
    );
  }
}
