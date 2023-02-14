import '../../domain/entities/person/person_info.dart';

class PersonInfoModel extends PersonInfo {
  PersonInfoModel({
    required super.name,
    required super.imageUrl,
    required super.uid,
    required super.localImagePath,
    required super.username,
    required super.email,
    super.isVerified,
    super.bio,
    required super.gender,
  });

  factory PersonInfoModel.fromMap(Map<String, dynamic> map) {
    return PersonInfoModel(
      name: map['name'],
      imageUrl: map['imageUrl'],
      uid: map['uid'],
      localImagePath: map['localImagePath'],
      username: map['username'],
      bio: map['bio'],
      email: map['email'],
      gender: map['gender'],
      isVerified: map['isVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'imageUrl': imageUrl,
      'localImagePath': localImagePath,
      'username': username,
      'bio': bio,
      'email': email,
      'gender': gender,
      'isVerified': isVerified,
    };
  }
}
