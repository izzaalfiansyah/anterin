import 'package:anterin/constant.dart';
import 'package:anterin/utils/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapRoute {
  final LatLng from;
  final LatLng to;

  MapRoute({required this.from, required this.to});
}

class Maps extends StatefulWidget {
  const Maps({
    super.key,
    this.center,
    this.zoom = 17,
    this.onPositionChanged,
    this.onGetCurrentPosition,
    this.controller,
    this.size = 250,
    this.showMarker = false,
    this.route,
  });

  final LatLng? center;
  final double zoom;
  final void Function(MapCamera camera, bool hasGesture)? onPositionChanged;
  final void Function(Position position)? onGetCurrentPosition;
  final MapController? controller;
  final double size;
  final bool showMarker;
  final MapRoute? route;

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Position currentPosition = Position(
    latitude: -8.15997175201657,
    longitude: 113.72268022967968,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  List<LatLng> routesPoints = [];
  MapController controller = MapController();

  @override
  void initState() {
    if (widget.controller != null) {
      controller = widget.controller!;
    }

    getCurrentPosition();
    getMapRoute();

    super.initState();
  }

  getCurrentPosition() async {
    try {
      final position = await getMyPosition();
      setState(() {
        currentPosition = position;

        controller.move(
            LatLng(currentPosition.latitude, currentPosition.longitude),
            widget.zoom);

        if (widget.onGetCurrentPosition != null) {
          widget.onGetCurrentPosition!(position);
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getMapRoute() async {
    try {
      if (widget.route != null) {
        final from = widget.route!.from;
        final to = widget.route!.to;

        final res = await Dio().get(
            'http://router.project-osrm.org/route/v1/driving/${from.longitude},${from.latitude};${to.longitude},${to.latitude}?geometries=geojson');

        List<LatLng> points =
            res.data['routes'][0]['geometry']['coordinates'].map((point) {
          return LatLng(point[1], point[0]);
        });

        setState(() {
          routesPoints = points;
        });

        controller.move(to, widget.zoom);
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.size,
          child: FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: widget.center ??
                  LatLng(currentPosition.latitude, currentPosition.longitude),
              initialZoom: widget.zoom,
              onPositionChanged: widget.onPositionChanged,
            ),
            children: [
              TileLayer(
                // Display map tiles from any source
                urlTemplate:
                    'https://mt0.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                // And many more recommended properties!
              ),
              routesPoints.isNotEmpty
                  ? PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routesPoints,
                          color: cPrimary,
                          strokeWidth: 7,
                        )
                      ],
                    )
                  : SizedBox(),
              widget.route != null
                  ? Stack(
                      children: [
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: widget.route!.from,
                              child: defaultMarker(),
                            ),
                            Marker(
                              point: widget.route!.to,
                              child: defaultMarker(),
                            ),
                          ],
                        )
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
        widget.showMarker
            ? SizedBox(
                height: widget.size,
                child: Center(
                  child: defaultMarker(),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Icon defaultMarker() {
    return Icon(
      Icons.location_pin,
      color: cPrimary,
      size: 40,
    );
  }
}
