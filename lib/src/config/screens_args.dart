import '../core/domain/entities/person/person_info.dart';
import '../core/domain/entities/post/post.dart';

import '../core/domain/entities/post/comment.dart';
import '../core/domain/entities/story/stories.dart';
import '../features/profile/presentation/screens/view_persons_screen.dart';
import '../features/reels/domain/entities/reel.dart';

class PostScreensArgs {
  final Post post;
  final PersonInfo personInfo;
  final Comment? comment;
  final Comment? reply;

  PostScreensArgs({
    this.comment,
    this.reply,
    required this.post,
    required this.personInfo,
  });

  PostScreensArgs copyWith({
    Post? post,
    PersonInfo? personInfo,
    Comment? comment,
    Comment? reply,
  }) {
    return PostScreensArgs(
      post: post ?? this.post,
      personInfo: personInfo ?? this.personInfo,
      comment: comment ?? this.comment,
      reply: reply ?? this.reply,
    );
  }
}

class PersonsScreenArgs {
  final String uid;
  final PersonsType personsType;
  final String title;

  PersonsScreenArgs({
    required this.uid,
    required this.personsType,
    required this.title,
  });

  PersonsScreenArgs copyWith({
    String? uid,
    PersonsType? personsType,
    String? title,
  }) {
    return PersonsScreenArgs(
      uid: uid ?? this.uid,
      personsType: personsType ?? this.personsType,
      title: title ?? this.title,
    );
  }
}

class ReelsScreensArgs {
  final Reel reel;
  final Comment? comment;

  ReelsScreensArgs({
    this.comment,
    required this.reel,
  });

  ReelsScreensArgs copyWith({
    Reel? reel,
    Comment? comment,
  }) {
    return ReelsScreensArgs(
      reel: reel ?? this.reel,
      comment: comment ?? this.comment,
    );
  }
}

class ViewStoriesScreenArgs {
  final List<Stories> stories;
  final int arrangement;

  ViewStoriesScreenArgs({
    required this.stories,
    required this.arrangement,
  });
}
