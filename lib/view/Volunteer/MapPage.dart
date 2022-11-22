import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VolunteerMap extends StatefulWidget {
  @override
  State<VolunteerMap> createState() => _VolunteerMap();
}

class _VolunteerMap extends State<VolunteerMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-1.30916,36.81251),
    zoom: 14.4746,
  );

  static final CameraPosition _kNPO = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.28652,36.83073),
      tilt: 90,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: Text('Nearest NPO!'),
          icon: Icon(Icons.pin_drop),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kNPO));
  }
}



//NGO should add an  event direcly on the map