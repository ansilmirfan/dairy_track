// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:developer';
import 'package:dairy_track/features/data/data_source/firebase/data_source.dart';
import 'package:dairy_track/features/data/models/delivery_model.dart';
import 'package:dairy_track/features/data/models/driver_model.dart';
import 'package:dairy_track/features/data/models/store_model.dart';
import 'package:dairy_track/features/presentation/getx/location_service.dart';
import 'package:dairy_track/features/presentation/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final LocationController _locationController = Get.put(LocationController());
  var mapController = Completer<GoogleMapController>().obs;
  final DataSource _dataSource = DataSource();
  var loading = false.obs;
  //-------------marks to the route-----------------
  var polylines = const <Polyline>{}.obs;
  Rx<DeliveryModel?> deliverymodel = Rx<DeliveryModel?>(null);
  //----initial camera position----------------
  var initialCameraPossition = const CameraPosition(
    target: LatLng(11.641607, 76.110927),
    zoom: 17,
  ).obs;
//------------markers---------------
  var markers = <Marker>{}.obs;

  //-----------listening to the users location and moving the camera to the center----------
  @override
  void onInit() {
    super.onInit();

    _setCameraToCurrentLocation();
    _addCompanyToMarkers();
  }

//-----------------adding company location to markers-----------------
  void _addCompanyToMarkers() {
    var companyLocation = Marker(
      onTap: () {
        if (_locationController.currentLocation.value != null) {
          showLocationToThePoint(
              LatLng(_locationController.currentLocation.value!.latitude,
                  _locationController.currentLocation.value!.longitude),
              const LatLng(11.641607, 76.110927),
              'company');
        }
      },
      markerId: const MarkerId('Company Location'),
      position: const LatLng(11.641607, 76.110927),
      icon: BitmapDescriptor.defaultMarkerWithHue(240),
      infoWindow: const InfoWindow(title: 'Company Location'),
    );

    markers.value.add(companyLocation);
  }

//-----------setting up camera location listen to the changes in the current location of the user----------------
  void _setCameraToCurrentLocation() {
    _locationController.currentLocation.stream.listen((postion) {
      if (postion != null) {
        _cameraToPossition(LatLng(postion.latitude, postion.longitude));

        //------------setting new polyline is the user moves ----------------
        if (polylines.value.isNotEmpty) {
          final polyline = polylines.value.first;
          final endPoint = polyline.points.last;
          final startPoint = LatLng(postion.latitude, postion.longitude);

          showLocationToThePoint(
              startPoint, endPoint, polyline.mapsId.toString());
        }
      }
    });
  }

  //-------------adding the delivery location to the map pointers----------------
  void addLocations(String id) async {
    loading.value = true;
    try {
      final data = await _dataSource.getTodaysOrder(id);
      if (data != null) {
        //----getting drivers data---------------
        final driverId = data['driver'];
        final driverMap = await _dataSource.getOne('drivers', driverId);
        final driverModel = DriverModel.fromMap(driverMap);
        //----------deliver shops model-------------
        final List<Map> shops = List<Map>.from(data['shops'] ?? []);
        List<ShopDeliveryModel> shopDeliveryModel = [];
        for (var element in shops) {
          final shopMap =
              await _dataSource.getOne('sellers', element['shop id']);
          final shopModel = ShopModel.fromMap(shopMap);
          shopDeliveryModel.add(
            ShopDeliveryModel(
                shopModel: shopModel,
                dateTime: DateTime.tryParse(element['date'] ?? ''),
                deliveredQuantity: element['delivered quantity'],
                status: element['status']),
          );
        }
        //------initilising delivery model-------------------
        final DeliveryModel model = DeliveryModel.fromMap(
            map: data, driverModel: driverModel, shops: shopDeliveryModel);
        deliverymodel.value = model;
        //----------setting up markers for the map--------------
        for (var element in model.shops) {
          final marker = Marker(
              onTap: () {
                if (_locationController.currentLocation.value != null) {
                  //--------current location------------
                  var currentLocation = LatLng(
                      _locationController.currentLocation.value!.latitude,
                      _locationController.currentLocation.value!.longitude);
                  //----------delivery location----------------
                  var deliveryLocation = LatLng(
                      element.shopModel.location.latitude,
                      element.shopModel.location.longitude);
                  showLocationToThePoint(
                      currentLocation, deliveryLocation, element.shopModel.id);
                } else {
                  log('current location is null');
                }
              },
              markerId: MarkerId(element.shopModel.id),
              position: LatLng(element.shopModel.location.latitude,
                  element.shopModel.location.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  element.status == 'Delivered' ? 120.0 : 0.0),
              infoWindow: InfoWindow(
                title: element.shopModel.name,
                snippet: element.status,
                onTap: () {
                  showStatuUpdationDialog(model, element.shopModel.id);
                },
              ));
          markers.value.add(marker);
        }
      }
      log('markers value===${markers.length}');
      loading.value = false;
    } catch (e) {
      log('error from getting locations of shops$e');
      loading.value = false;
    }
  }

  //-------- setting camera possition to the center of the current user location--------------
  Future<void> _cameraToPossition(LatLng pos) async {
    final GoogleMapController controller = await mapController.value.future;
    CameraPosition newCameraPossition = CameraPosition(target: pos, zoom: 17);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPossition));
  }

  //---------showing location to the place---------------
  void showLocationToThePoint(LatLng startPos, LatLng endPos, String id) async {
    loading.value = true;
    try {
      final apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
      GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(apiKey: apiKey);
      var coordinates = await googleMapPolyline.getCoordinatesWithLocation(
          origin: startPos, destination: endPos, mode: RouteMode.driving);
      if (coordinates != null) {
        final poly = Polyline(
          polylineId: PolylineId(id),
          points: coordinates,
          color: Colors.blue,
          width: 7,
        );
        polylines.value = {poly};
      }

      loading.value = false;
    } catch (e) {
      log('error from showing route$e');
      loading.value = false;
    }
  }

  deliveredStatusUpdate({
    required String id,
    required DeliveryModel model,
  }) async {
    try {
      loading.value = true;
      log('id ======$id');
      await _dataSource.edit(
          id, 'delivery datasource', DeliveryModel.toMap(model));
      loading.value = false;
      Get.back();
      addLocations(model.driver.id);
    } catch (e) {
      loading.value = false;
      log('error while updating===$e');
    }
  }

  //----------------clear polylines--------------
  void clearPolyLines() => polylines.value = {};
}
