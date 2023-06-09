import '../../../../core/domain/entities/post/post_media.dart';

import '../../../../core/domain/entities/post/post.dart';
import '../../data/models/reel_model.dart';
import '../entities/reel.dart';

extension ReelModelExtension on ReelModel {
  Reel toDomain() => Reel(
        publisher: publisher,
        reelText: reelText,
        reelDate: reelDate,
        comments: comments,
        likes: likes,
        videoUrl: videoUrl,
        id: id,
      );
}

extension ReelExtension on Reel {
  ReelModel fromDomain() => ReelModel(
        publisher: publisher,
        reelText: reelText,
        reelDate: reelDate,
        comments: comments,
        likes: likes,
        videoUrl: videoUrl,
        id: id,
      );
}

extension ReelToPostExtension on Reel {
  Post toPost() => Post(
        publisher: publisher,
        postText: reelText,
        postDate: reelDate,
        comments: comments,
        likes: likes,
        postMedia: PostMedia(
            imagesUrl: [],
            imagesLocalPaths: [],
            videosUrl: [videoUrl],
            videosLocalPaths: []),
        id: id,
        locationInfo: null,
        taggedPeople: [],
      );
}

extension PostToReelExtension on Post {
  Reel toReel() => Reel(
        publisher: publisher,
        reelText: postText,
        reelDate: postDate,
        comments: comments,
        likes: likes,
        videoUrl: postMedia.videosUrl.first,
        id: id,
      );
}
