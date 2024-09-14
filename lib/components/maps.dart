import 'package:anterin/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatelessWidget {
  const Maps({
    super.key,
    required this.center,
    this.zoom = 17,
    this.onPositionChanged,
    this.controller,
    this.size = 250,
    this.showMarker = false,
  });

  final LatLng center;
  final double zoom;
  final void Function(MapCamera camera, bool hasGesture)? onPositionChanged;
  final MapController? controller;
  final double size;
  final bool showMarker;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size,
          child: FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: center,
              initialZoom: zoom,
              onPositionChanged: onPositionChanged,
            ),
            children: [
              TileLayer(
                // Display map tiles from any source
                urlTemplate:
                    'https://mt0.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                // And many more recommended properties!
              ),
            ],
          ),
        ),
        showMarker
            ? SizedBox(
                height: size - 20,
                child: Center(
                  child: Icon(
                    Icons.location_pin,
                    color: cPrimary,
                    size: 40,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
