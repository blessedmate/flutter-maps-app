import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMapView extends StatefulWidget {
  const FullScreenMapView({Key? key}) : super(key: key);

  @override
  State<FullScreenMapView> createState() => _FullScreenMapViewState();
}

class _FullScreenMapViewState extends State<FullScreenMapView> {
  static const String ACCESS_TOKEN =
      'pk.eyJ1IjoiYmxlc3NlZG1hdGUiLCJhIjoiY2t3c25pOHZ1MTg3NjJxanY0amQyd2Y4bCJ9.rLzCygkPfTJFi6ywpwj45w';

  MapboxMapController? mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MapboxMap(
      accessToken: ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
          target: LatLng(37.810575, -122.477174), zoom: 16.0),
    ));
  }
}
