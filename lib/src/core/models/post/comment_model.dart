import '../../domain/entities/person/person_info.dart';
import '../../domain/entities/post/comment.dart';
import '../../domain/mappers/mappers.dart';
import '../person/person_info_model.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.commenterInfo,
    required super.commentText,
    required super.likes,
    required super.commentDate,
    required super.replies,
    required super.id,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commenterInfo: PersonInfoModel.fromMap(map['commenterInfo']).toDomain(),
      commentText: map['commentText'],
      likes: List<PersonInfo>.from(
        map['likes']
            .map((replay) => PersonInfoModel.fromMap(replay).toDomain()),
      ).toList(),
      commentDate: map['commentDate'],
      replies: List<Comment>.from(
        map['replies'].map((replay) => CommentModel.fromMap(replay).toDomain()),
      ).toList(),
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commenterInfo': commenterInfo.fromDomain().toMap(),
      'commentText': commentText,
      'id': id,
      'commentDate': commentDate,
      'likes': likes.map((e) => e.fromDomain().toMap()).toList(),
      'replies': replies.map((e) => e.fromDomain().toMap()).toList(),
    };
  }
}
