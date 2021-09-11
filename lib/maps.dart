import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  MapsWidget({Key key}) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.1783723, 106.7898117),
    zoom: 15,
  );

  static final CameraPosition _kLake =
      CameraPosition(target: LatLng(-6.1783723, 106.7898117), zoom: 15);

  @override
  Widget build(BuildContext context) {
    var markers = Set<Marker>();

    markers.add(Marker(
        markerId: MarkerId("markerId"),
        position: LatLng(-6.1783723, 106.7898117),
        infoWindow: InfoWindow(title: "Mall Taman Anggrek")));

    markers.add(Marker(
        markerId: MarkerId("markerId2"),
        position: LatLng(-6.1951801, 106.8182525),
        infoWindow: InfoWindow(title: "Grand Indonesia")));

    markers.add(Marker(
        markerId: MarkerId("markerId3"),
        position: LatLng(-6.1966985, 106.8202962),
        infoWindow: InfoWindow(title: "BCA Tower")));

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        initialCameraPosition: _kGooglePlex,
        mapToolbarEnabled: true,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
