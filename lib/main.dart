import 'package:flutter/material.dart';
import 'package:flutter_mapbox/src/views/fullscreen_map_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: FullScreenMapView(),
      ),
    );
  }
}
