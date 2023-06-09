import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_permissions.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/post_bloc.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

const double zoomVal = 14.4746;

class _AddLocationScreenState extends State<AddLocationScreen> {
  Future<Position?> getCurrentLocation() async {
    if (await AppPermissions.checkLocationPermissions()) {
      return Geolocator.getCurrentPosition();
    } else {
      buildToast(
        toastType: ToastType.error,
        msg: AppStrings.enableLocationService,
      );
    }
    return null;
  }

  Position? currentLocation;

  double? lat;
  double? lng;
  String? _currentLocationName;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: zoomVal,
  );

  final Set<Marker> markers = <Marker>{};
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.chooseLocation,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            child: const Text(AppStrings.done),
            onPressed: () async {
              if (lat != null && lng != null) {
                context.read<PostBloc>().add(SaveLocation(
                      lat,
                      lng,
                      _currentLocationName,
                    ));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) async {
          _googleMapController = controller;
          currentLocation = await getCurrentLocation();
        },
        onTap: (latLng) async {
          _googleMapController.animateCamera(
            getNewCameraPosition(latLng),
          );
          lat = latLng.latitude;
          lng = latLng.longitude;
          markers.clear();
          setState(() {
            markers.add(
              Marker(markerId: const MarkerId('1'), position: latLng),
            );
          });
          if (lat != null && lng != null) {
            List<Placemark> placemarks = await placemarkFromCoordinates(
              lat!,
              lng!,
            );
            Placemark place1 = placemarks[0];
            Placemark place2 = placemarks[1];
            _currentLocationName =
                "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
          }
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoCurrentLocation,
        child: const Icon(Icons.location_on_outlined),
      ),
    );
  }

  void _gotoCurrentLocation() async {
    if (currentLocation == null) return;
    lat = currentLocation!.latitude;
    lng = currentLocation!.longitude;
    LatLng latLng = LatLng(lat!, lng!);
    _googleMapController.animateCamera(
      getNewCameraPosition(latLng),
    );
    markers.clear();
    setState(() {
      markers.add(
        Marker(markerId: const MarkerId('1'), position: latLng),
      );
    });
  }

  CameraUpdate getNewCameraPosition(LatLng latLng) {
    return CameraUpdate.newCameraPosition(
      CameraPosition(target: latLng, zoom: zoomVal),
    );
  }
}
// AIzaSyAAvAh8QDgVSHMqFx4Hm6oRlFvRH6Ouyjs