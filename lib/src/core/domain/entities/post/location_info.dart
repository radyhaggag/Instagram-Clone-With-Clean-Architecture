import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'location_info.g.dart';

@HiveType(typeId: 7)
class LocationInfo extends HiveObject with EquatableMixin {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lng;
  @HiveField(2)
  final String name;

  LocationInfo({
    required this.lat,
    required this.lng,
    required this.name,
  });

  @override
  List<Object> get props => [lat, lng, name];
}
