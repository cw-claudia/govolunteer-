import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NGO_Map extends StatefulWidget {
  const NGO_Map({Key? key}) : super(key: key);

  @override
  State<NGO_Map> createState() => _NGO_MapState();
}

class _NGO_MapState extends State<NGO_Map> {

  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-1.30916, 36.81251),
    zoom: 14.4746,
  );

  static final CameraPosition _kNPO = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.28652, 36.83073),
      tilt: 90,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [ GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },),


          ]
          ),
        )
    );
  }

}
