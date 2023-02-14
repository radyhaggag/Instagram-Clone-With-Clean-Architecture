import '../../domain/entities/person/person_info.dart';
import '../../domain/entities/story/story.dart';
import '../../domain/mappers/mappers.dart';
import '../person/person_info_model.dart';
import 'story_text_model.dart';

class StoryModel extends Story {
  StoryModel({
    required super.publisher,
    required super.viewers,
    required super.storyDate,
    super.storyText,
    super.imageUrl,
    super.imageLocalPath,
    super.videoUrl,
    super.videoLocalPath,
    required super.id,
  });

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      publisher: PersonInfoModel.fromMap(map['publisher']).toDomain(),
      storyText: map['storyText'] != null
          ? StoryTextModel.fromMap(map['storyText'])
          : null,
      viewers: List<PersonInfo>.from(map['viewers']
          .map((e) => PersonInfoModel.fromMap(e).toDomain())
          .toList()),
      imageUrl: map['imageUrl'],
      imageLocalPath: map['imageLocalPath'],
      videoUrl: map['videoUrl'],
      videoLocalPath: map['videoLocalPath'],
      storyDate: map['storyDate'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'publisher': publisher.fromDomain().toMap(),
      'storyText': storyText?.fromDomain().toMap(),
      'viewers': viewers,
      'imageUrl': imageUrl,
      'imageLocalPath': imageLocalPath,
      'videoUrl': videoUrl,
      'videoLocalPath': videoLocalPath,
      'storyDate': storyDate,
    };
  }
}
