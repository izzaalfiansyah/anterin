import 'package:anterin/constants/app.dart';
import 'package:anterin/utils/http.dart';
import 'package:anterin/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

final mapsDefaultCenter = LatLng(-8.15997175201657, 113.72268022967968);

class MapRoute {
  final LatLng from;
  final LatLng to;

  MapRoute({required this.from, required this.to});
}

class MapRouteResponse {
  final num distance;
  final num duration;
  final List<LatLng> coordinates;

  MapRouteResponse({
    required this.distance,
    required this.duration,
    required this.coordinates,
  });

  factory MapRouteResponse.fromJSON(Map<String, dynamic> map) {
    return MapRouteResponse(
      distance: map['distance'],
      duration: map['duration'],
      coordinates: map['coordinates'].map<LatLng>((coordinate) {
        return LatLng(coordinate['lat'], coordinate['lng']);
      }).toList(),
    );
  }
}

class Maps extends StatefulWidget {
  const Maps({
    super.key,
    this.center,
    this.zoom = 17,
    this.onPositionChanged,
    this.onGetCurrentPosition,
    this.onRouteFound,
    this.controller,
    this.size = 250,
    this.showMarker = false,
    this.route,
    this.getCurrentPosition = false,
  });

  final LatLng? center;
  final double zoom;
  final void Function(PointerUpEvent event, LatLng point)? onPositionChanged;
  final void Function(Position position)? onGetCurrentPosition;
  final void Function(MapRouteResponse route)? onRouteFound;
  final MapController? controller;
  final double size;
  final bool showMarker;
  final MapRoute? route;
  final bool getCurrentPosition;

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  bool isLoading = false;

  Position currentPosition = Position(
    latitude: mapsDefaultCenter.latitude,
    longitude: mapsDefaultCenter.longitude,
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
    setState(() {
      isLoading = true;
    });

    if (widget.controller != null) {
      controller = widget.controller!;
    }

    (() async {
      if (widget.getCurrentPosition) {
        await getCurrentPosition();
      }

      await getMapRoute();

      setState(() {
        isLoading = false;
      });
    })();

    super.initState();
  }

  Future getCurrentPosition() async {
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

  Future getMapRoute() async {
    try {
      if (widget.route != null) {
        final from = widget.route!.from;
        final to = widget.route!.to;

        final http = await httpInstance();
        final res = await http.post('/map/route', data: {
          'from_lat': from.latitude,
          'from_lng': from.longitude,
          'to_lat': to.latitude,
          'to_lng': to.longitude,
        });

        final route = MapRouteResponse.fromJSON(res.data);

        setState(() {
          routesPoints = route.coordinates;
        });

        if (widget.onRouteFound != null) {
          widget.onRouteFound!(route);
        }

        controller.move(to, widget.zoom);
      }
    } catch (e) {
      // print(e);
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
              // onPositionChanged: widget.onPositionChanged,
              onPointerUp: widget.onPositionChanged,
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
        isLoading
            ? Container(
                height: widget.size,
                color: Colors.grey.shade200,
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
