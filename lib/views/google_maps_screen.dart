import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/views/geo_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:easy_localization/easy_localization.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  LocationData? _locationData;
  Location _location = new Location();
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  //ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageBytes;

  LatLng pos = LatLng(0, 0);

  Set<Marker> _markers = HashSet();
  int _markerIdCount = 1;

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  Future<void> checkPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    _serviceEnabled = await _location.requestService();
    if (!_serviceEnabled!) {
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print('gettting location ............');
    _locationData = await _location.getLocation();
    pos = LatLng(_locationData!.latitude!, _locationData!.longitude!);
    /*final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: pos,
        zoom: 16,
      ),
    ));*/
    _setMarker(pos);
  }

  void _setMarker(LatLng point) {
    final String mid = 'marker_id_$_markerIdCount';
    _markerIdCount++;
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(mid),
            position: point,
            draggable: true,
            onDragEnd: (LatLng newPosition) {
              pos = newPosition;
              print(newPosition.latitude);
              print(newPosition.longitude);
            }),
      );
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _initPos() {
    return CameraPosition(
      target: pos,
      zoom: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: showWidget(
            Scaffold(
              body: GoogleMap(
                mapType: MapType.normal,
                markers: _markers,
                initialCameraPosition: _initPos(),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  if (!kIsWeb) {
                    log("taking screenshot google map");
                    final GoogleMapController controller = await _controller.future;
                    _imageBytes = await controller.takeSnapshot();
                  }
                  Navigator.pop(context, LatLngImage(_imageBytes ?? Uint8List.fromList([]), pos));
                },
                label: Text('Ok'.tr()),
                icon: Icon(Icons.gps_fixed),
              ),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
            _locationData != null));
  }

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
