import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  var currentLocation = Rx<Position?>(null);

  var locationMessage = "Fetching location...".obs;
  var isPermissionDenied = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAndTrackLocation();
  }

  Future<void> checkAndTrackLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isPermissionDenied.value = true;
          locationMessage.value = "Location permission is required.";
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isPermissionDenied.value = true;
        locationMessage.value =
            "Location permission is permanently denied. Enable it in settings.";
        return;
      }
      isPermissionDenied.value = false;
      locationMessage.value = "Tracking location...";
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) {
        currentLocation.value = position;
        locationMessage.value =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    } catch (e) {
      locationMessage.value = "Error: $e";
    }
  }
}
