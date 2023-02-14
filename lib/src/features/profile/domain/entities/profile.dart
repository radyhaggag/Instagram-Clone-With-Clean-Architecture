// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:instagram_clone/src/core/domain/entities/person/person.dart';

import '../../../../core/domain/entities/post/post.dart';

part 'profile.g.dart';

@HiveType(typeId: 9)
class Profile extends HiveObject with EquatableMixin {
  @HiveField(0)
  final Person person;
  @HiveField(1)
  final List<Post> posts;
  Profile({
    required this.person,
    required this.posts,
  });

  @override
  List<Object> get props => [person, posts];

  Profile copyWith({
    Person? person,
    List<Post>? posts,
  }) {
    return Profile(
      person: person ?? this.person,
      posts: posts ?? this.posts,
    );
  }
}
