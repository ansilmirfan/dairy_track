// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'dart:async';

import 'package:dairy_track/features/presentation/getx/location_service.dart';
import 'package:dairy_track/features/presentation/getx/log_in_auth.dart';
import 'package:dairy_track/features/presentation/getx/map_data_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocationController controller = Get.put(LocationController());

  final LoginAuthController authController = Get.put(LoginAuthController());

  final MapController mapController = Get.put(MapController());
  @override
  void initState() {
    super.initState();
    mapController.addLocations(authController.driver!.id);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    //--------for hiding the top bar in the mobile

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          mapController.addLocations(authController.driver!.id);
        },
        child: Obx(() {
          if (!authController.isOrderUpdated.value) {
            return _refreshButton();
          } else if (controller.isPermissionDenied.value) {
            return _requestForPermission();
          } else {
            return _buildBody();
          }
        }),
      ),
    );
  }

  _buildBody() {
    return Obx(() {
      return Stack(
        children: [
          _googleMap(),
          if (mapController.loading.value) _loading(),
        ],
      );
    });
  }

  SizedBox _loading() {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  GoogleMap _googleMap() {
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.hybrid,
      onTap: (argument) {
        mapController.clearPolyLines();
      },
      polylines: mapController.polylines.value,
      initialCameraPosition: mapController.initialCameraPossition.value,
      markers: mapController.markers,
      onMapCreated: (GoogleMapController controller) {
        mapController.mapController.value.complete(controller);
      },
      onLongPress: (argument) {
        Get.back(result: argument);
      },
    );
  }

  Center _requestForPermission() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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

  Center _refreshButton() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Delivery is not updated Please contact the admin'),
          ElevatedButton(
              onPressed: () {
                authController
                    .isOrderUpdatedChecking(authController.driver!.id);
              },
              child: const Text('Refresh'))
        ],
      ),
    );
  }
}
