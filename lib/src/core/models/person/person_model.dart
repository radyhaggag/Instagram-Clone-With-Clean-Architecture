import '../../domain/entities/person/person.dart';
import '../../domain/mappers/mappers.dart';
import 'person_info_model.dart';

class PersonModel extends Person {
  PersonModel({
    required super.personInfo,
    super.numOfPosts,
    super.numOfFollowers,
    super.numOfFollowings,
  });

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      personInfo: PersonInfoModel.fromMap(map['personInfo']),
      numOfPosts: map['numOfPosts'],
      numOfFollowers: map['numOfFollowers'],
      numOfFollowings: map['numOfFollowings'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'personInfo': personInfo.fromDomain().toMap(),
      'numOfPosts': numOfPosts,
      'numOfFollowers': numOfFollowers,
      'numOfFollowings': numOfFollowings,
    };
  }
}
