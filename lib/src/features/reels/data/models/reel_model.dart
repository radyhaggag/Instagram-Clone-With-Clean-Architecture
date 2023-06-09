import '../../../../core/domain/mappers/mappers.dart';
import '../../domain/entities/reel.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/models/person/person_info_model.dart';
import '../../../../core/models/post/comment_model.dart';

class ReelModel extends Reel {
  const ReelModel({
    required super.publisher,
    required super.videoUrl,
    required super.reelText,
    required super.reelDate,
    required super.likes,
    required super.comments,
    required super.id,
  });

  factory ReelModel.fromMap(Map<String, dynamic> map) {
    return ReelModel(
      publisher: PersonInfoModel.fromMap(map['publisher']).toDomain(),
      videoUrl: map['videoUrl'],
      reelText: map['reelText'],
      reelDate: map['reelDate'],
      likes: List<PersonInfo>.from(
        map['likes'].map(
          (person) => PersonInfoModel.fromMap(person).toDomain(),
        ),
      ),
      comments: List<Comment>.from(
        map['comments']
            .map((comment) => CommentModel.fromMap(comment).toDomain()),
      ),
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap({String? reelId}) {
    return {
      'id': reelId ?? id,
      'videoUrl': videoUrl,
      'publisher': publisher.fromDomain().toMap(),
      'reelText': reelText,
      'reelDate': reelDate,
      'likes': likes.map((e) => e.fromDomain().toMap()).toList(),
      'comments': comments.map((e) => e.fromDomain().toMap()).toList(),
    };
  }
}
