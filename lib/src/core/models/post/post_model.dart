import '../../domain/entities/person/person.dart';
import '../../domain/entities/person/person_info.dart';
import '../../domain/entities/post/comment.dart';
import '../../domain/entities/post/post.dart';
import '../../domain/mappers/mappers.dart';
import '../person/person_info_model.dart';
import '../person/person_model.dart';
import 'comment_model.dart';
import 'location_info_model.dart';
import 'post_media_model.dart';

class PostModel extends Post {
  PostModel({
    required super.publisher,
    required super.postMedia,
    required super.postText,
    required super.postDate,
    required super.locationInfo,
    required super.likes,
    required super.comments,
    required super.taggedPeople,
    required super.id,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      publisher: PersonInfoModel.fromMap(map['publisher']).toDomain(),
      postMedia: PostMediaModel.fromMap(map['postMedia']).toDomain(),
      postText: map['postText'],
      postDate: map['postDate'],
      locationInfo: map['locationInfo'] != null
          ? LocationInfoModel.fromMap(map['locationInfo']).toDomain()
          : null,
      likes: List<PersonInfo>.from(
        map['likes']
            .map((person) => PersonInfoModel.fromMap(person).toDomain())
            .toList(),
      ),
      comments: List<Comment>.from(
        map['comments']
            .map((comment) => CommentModel.fromMap(comment).toDomain())
            .toList(),
      ),
      taggedPeople: List<Person>.from(
        map['taggedPeople']
            .map((person) => PersonModel.fromMap(person).toDomain())
            .toList(),
      ),
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap({String? postId}) {
    return {
      'id': postId ?? id,
      'publisher': publisher.fromDomain().toMap(),
      'postMedia': postMedia.fromDomain().toMap(),
      'postText': postText,
      'postDate': postDate,
      'locationInfo':
          locationInfo != null ? locationInfo!.fromDomain().toMap() : null,
      'likes': likes.map((e) => e.fromDomain().toMap()).toList(),
      'comments': comments.map((e) => e.fromDomain().toMap()).toList(),
      'taggedPeople': taggedPeople.map((e) => e.fromDomain().toMap()).toList(),
    };
  }
}
