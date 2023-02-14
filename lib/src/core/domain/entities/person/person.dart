// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'person_info.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject with EquatableMixin {
  @HiveField(0)
  final PersonInfo personInfo;
  final int numOfPosts;
  @HiveField(1)
  final int numOfFollowers;
  @HiveField(2)
  final int numOfFollowings;

  Person({
    required this.personInfo,
    this.numOfPosts = 0,
    this.numOfFollowers = 0,
    this.numOfFollowings = 0,
  });

  @override
  List<Object> get props {
    return [personInfo, numOfFollowers, numOfFollowings, numOfPosts];
  }

  Person copyWith({
    PersonInfo? personInfo,
    int? numOfPosts,
    int? numOfFollowers,
    int? numOfFollowings,
  }) {
    return Person(
      personInfo: personInfo ?? this.personInfo,
      numOfPosts: numOfPosts ?? this.numOfPosts,
      numOfFollowers: numOfFollowers ?? this.numOfFollowers,
      numOfFollowings: numOfFollowings ?? this.numOfFollowings,
    );
  }
}
