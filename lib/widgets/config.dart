import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final LatLng initialPosition;

  GoogleMapWidget({Key? key, required this.initialPosition}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 10.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      markers: _createMarkers(),
    );
  }

  // Tạo marker cho bản đồ
  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId('marker_1'),
        position: widget.initialPosition,
        infoWindow: InfoWindow(
          title: 'Vị trí của bạn',
          snippet: 'Thông tin về vị trí',
        ),
      ),
    };
  }
}
