import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'person_info.g.dart';

@HiveType(typeId: 1)
class PersonInfo extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String uid;
  @HiveField(3)
  final String localImagePath;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final bool isVerified;
  @HiveField(6)
  final String email;
  @HiveField(7)
  final String? bio;
  @HiveField(8)
  final String gender;
  @HiveField(9)
  PersonInfo({
    required this.name,
    required this.imageUrl,
    required this.uid,
    required this.localImagePath,
    required this.username,
    required this.email,
    required this.gender,
    this.bio,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [name, imageUrl, uid, localImagePath];

  PersonInfo copyWith({
    String? name,
    String? imageUrl,
    String? uid,
    String? localImagePath,
    String? username,
    bool? isVerified,
    String? email,
    String? bio,
    String? gender,
  }) {
    return PersonInfo(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      uid: uid ?? this.uid,
      localImagePath: localImagePath ?? this.localImagePath,
      username: username ?? this.username,
      isVerified: isVerified ?? this.isVerified,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
    );
  }
}
