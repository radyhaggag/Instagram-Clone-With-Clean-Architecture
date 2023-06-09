import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseCheckInternetConnectivity {
  Future<bool> isConnected();
}

class CheckInternetConnectivity implements BaseCheckInternetConnectivity {
  final Connectivity connectivity;

  CheckInternetConnectivity({required this.connectivity});

  @override
  Future<bool> isConnected() async {
    if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
