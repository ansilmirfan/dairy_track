// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dairy_track/features/presentation/getx/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final LocationController controller = Get.put(LocationController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
//------------company location-------------------
  static const CameraPosition _companyLocation = CameraPosition(
    target: LatLng(11.641607, 76.110927),
    zoom: 17,
  );
  //-------------markers-------------
  Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isPermissionDenied.value) {
          return _requestForPermission();
        } else {
          return GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _companyLocation,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers,
            onLongPress: (argument) {
              Get.back(result: argument);
            },
          );
        }
      }),
    );
  }

  Center _requestForPermission() {
    return Center(
      child: Column(
        children: [
          const Text('Location permission is denied please enable to continue'),
          ElevatedButton(
              onPressed: () {
                controller.checkAndTrackLocation();
              },
              child: const Text('Request Permission'))
        ],
      ),
    );
  }
}
