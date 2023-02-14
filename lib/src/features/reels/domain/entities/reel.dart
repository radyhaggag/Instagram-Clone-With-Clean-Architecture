import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/domain/entities/post/comment.dart';

class Reel extends Equatable {
  final PersonInfo publisher;

  final String videoUrl;

  final String? reelText;

  final String reelDate;

  final List<PersonInfo> likes;

  final List<Comment> comments;

  final String id;

  const Reel({
    required this.publisher,
    required this.videoUrl,
    required this.reelText,
    required this.reelDate,
    required this.likes,
    required this.comments,
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      publisher,
      videoUrl,
      reelText,
      reelDate,
      likes,
      comments,
      id,
    ];
  }

  Reel copyWith({
    PersonInfo? publisher,
    String? videoUrl,
    String? reelText,
    String? reelDate,
    List<PersonInfo>? likes,
    List<Comment>? comments,
    String? id,
  }) {
    return Reel(
      publisher: publisher ?? this.publisher,
      videoUrl: videoUrl ?? this.videoUrl,
      reelText: reelText ?? this.reelText,
      reelDate: reelDate ?? this.reelDate,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      id: id ?? this.id,
    );
  }
}
