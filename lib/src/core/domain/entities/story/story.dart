// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../person/person_info.dart';
import 'story_text.dart';

part 'story.g.dart';

@HiveType(typeId: 3)
class Story extends HiveObject with EquatableMixin {
  @HiveField(0)
  final PersonInfo publisher;
  @HiveField(1)
  final StoryText? storyText;
  @HiveField(2)
  final List<PersonInfo> viewers;
  @HiveField(3)
  final String? imageUrl;
  @HiveField(4)
  final String? imageLocalPath;
  @HiveField(5)
  final String? videoUrl;
  @HiveField(6)
  final String? videoLocalPath;
  @HiveField(7)
  final String storyDate;
  @HiveField(8)
  final String id;

  Story({
    required this.publisher,
    required this.viewers,
    required this.storyDate,
    required this.id,
    this.storyText,
    this.imageUrl,
    this.imageLocalPath,
    this.videoUrl,
    this.videoLocalPath,
  });

  @override
  List<Object> get props => [publisher, viewers, storyDate];

  Story copyWith({
    PersonInfo? publisher,
    StoryText? storyText,
    List<PersonInfo>? viewers,
    String? imageUrl,
    String? imageLocalPath,
    String? videoUrl,
    String? videoLocalPath,
    String? storyDate,
    String? id,
  }) {
    return Story(
      publisher: publisher ?? this.publisher,
      storyText: storyText ?? this.storyText,
      viewers: viewers ?? this.viewers,
      imageUrl: imageUrl ?? this.imageUrl,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
      videoUrl: videoUrl ?? this.videoUrl,
      videoLocalPath: videoLocalPath ?? this.videoLocalPath,
      storyDate: storyDate ?? this.storyDate,
      id: id ?? this.id,
    );
  }
}
