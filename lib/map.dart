import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
        body: EmergencyMap(),
      );
  }
}


class EmergencyMap extends StatelessWidget {

  final CameraPosition vegasPosition = CameraPosition(target: LatLng(36.0953103, -115.1992098), zoom: 10);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          initialCameraPosition: vegasPosition,
          onTap: (latLng) { launch(); },
    );
  }

  void launch() {
    MapsLauncher.launchCoordinates(36.0953103, -115.1992098);
  }
}