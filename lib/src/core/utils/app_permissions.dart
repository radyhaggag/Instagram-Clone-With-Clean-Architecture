import 'package:geolocator/geolocator.dart';

class AppPermissions {
  AppPermissions._();

  static Future<bool> _checkIfLocationServiceEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> checkLocationPermissions() async {
    if (!await _checkIfLocationServiceEnable()) return false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always ||
        permission != LocationPermission.whileInUse) {
      await Geolocator.requestPermission().then((value) {
        if (value != LocationPermission.always ||
            value != LocationPermission.whileInUse) {
          return false;
        } else {
          return true;
        }
      });
      return true;
    }
    return true;
  }
}
