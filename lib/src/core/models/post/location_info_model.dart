import '../../domain/entities/post/location_info.dart';

class LocationInfoModel extends LocationInfo {
  LocationInfoModel({
    required super.lat,
    required super.lng,
    required super.name,
  });

  factory LocationInfoModel.fromMap(Map<String, dynamic> map) {
    return LocationInfoModel(
      lat: map['lat'],
      lng: map['lng'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'name': name,
    };
  }
}
