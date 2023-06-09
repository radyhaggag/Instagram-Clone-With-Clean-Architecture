import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../person/person.dart';
import '../person/person_info.dart';
import 'comment.dart';
import 'location_info.dart';
import 'post_media.dart';

part 'post.g.dart';

@HiveType(typeId: 6)
class Post extends HiveObject with EquatableMixin {
  @HiveField(0)
  final PersonInfo publisher;
  @HiveField(1)
  final PostMedia postMedia;
  @HiveField(2)
  final String? postText;
  @HiveField(3)
  final String postDate;
  @HiveField(4)
  final LocationInfo? locationInfo;
  @HiveField(5)
  final List<PersonInfo> likes;
  @HiveField(6)
  final List<Comment> comments;
  @HiveField(7)
  final List<Person> taggedPeople;
  @HiveField(8)
  final String id;

  Post({
    required this.publisher,
    required this.postMedia,
    required this.postText,
    required this.postDate,
    required this.locationInfo,
    required this.likes,
    required this.comments,
    required this.taggedPeople,
    required this.id,
  });

  @override
  List<Object?> get props => [
        publisher,
        postMedia,
        postText,
        postDate,
        locationInfo,
        likes,
        comments,
        taggedPeople,
      ];

  Post copyWith({
    PersonInfo? publisher,
    PostMedia? postMedia,
    String? postText,
    String? postDate,
    LocationInfo? locationInfo,
    List<PersonInfo>? likes,
    List<Comment>? comments,
    List<Person>? taggedPeople,
    String? id,
  }) {
    return Post(
      publisher: publisher ?? this.publisher,
      postMedia: postMedia ?? this.postMedia,
      postText: postText ?? this.postText,
      postDate: postDate ?? this.postDate,
      locationInfo: locationInfo ?? this.locationInfo,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      taggedPeople: taggedPeople ?? this.taggedPeople,
      id: id ?? this.id,
    );
  }
}
