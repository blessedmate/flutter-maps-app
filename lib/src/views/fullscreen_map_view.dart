import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class FullScreenMapView extends StatefulWidget {
  const FullScreenMapView({Key? key}) : super(key: key);

  @override
  State<FullScreenMapView> createState() => _FullScreenMapViewState();
}

class _FullScreenMapViewState extends State<FullScreenMapView> {
  final center = const LatLng(37.810575, -122.477174);

  String selectedStlye =
      'mapbox://styles/blessedmate/ckwxu1jq317zf15pn4jqqsyor';
  final darkStyle = 'mapbox://styles/blessedmate/ckwxtwfff17tf14tjuov1pptj';
  final streetStyle = 'mapbox://styles/blessedmate/ckwxu1jq317zf15pn4jqqsyor';

  static const String ACCESS_TOKEN =
      'pk.eyJ1IjoiYmxlc3NlZG1hdGUiLCJhIjoiY2t3c25pOHZ1MTg3NjJxanY0amQyd2Y4bCJ9.rLzCygkPfTJFi6ywpwj45w';

  MapboxMapController? mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        styleString: selectedStlye,
        accessToken: ACCESS_TOKEN,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: center, zoom: 16.0),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Symbols
          FloatingActionButton(
            child: const Icon(Icons.location_on),
            onPressed: () {
              mapController!.addSymbol(
                SymbolOptions(
                  geometry: center,
                  iconImage: 'networkImage',
                  textField: 'Mountain',
                  textOffset: const Offset(0, 2),
                ),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 5),

          // Zoom in
          FloatingActionButton(
            child: const Icon(Icons.zoom_in),
            onPressed: () {
              mapController!.animateCamera(CameraUpdate.zoomIn());
            },
          ),
          const SizedBox(height: 5),

          // Zoom out
          FloatingActionButton(
            child: const Icon(Icons.zoom_out),
            onPressed: () {
              mapController!.animateCamera(CameraUpdate.zoomOut());
            },
          ),
          const SizedBox(height: 5),

          // Change style
          FloatingActionButton(
            child: const Icon(Icons.change_circle),
            onPressed: () {
              if (selectedStlye == darkStyle) {
                selectedStlye = streetStyle;
              } else {
                selectedStlye = darkStyle;
              }
              setState(() {
                _onStyleLoaded();
              });
            },
          ),
        ],
      ),
    );
  }
}
