import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../person/person_info.dart';

part 'comment.g.dart';

@HiveType(typeId: 8)
class Comment extends HiveObject with EquatableMixin {
  @HiveField(0)
  final PersonInfo commenterInfo;
  @HiveField(1)
  final String commentText;
  @HiveField(2)
  final List<PersonInfo> likes;
  @HiveField(3)
  final String commentDate;
  @HiveField(4)
  final List<Comment> replies;
  @HiveField(5)
  final String id;

  Comment({
    required this.commenterInfo,
    required this.commentText,
    required this.likes,
    required this.commentDate,
    required this.replies,
    required this.id,
  });

  @override
  List<Object> get props {
    return [
      commenterInfo,
      commentText,
      likes,
      commentDate,
      replies,
      id,
    ];
  }
}
