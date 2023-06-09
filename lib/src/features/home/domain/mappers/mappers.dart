import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/entities/story/stories.dart';
import '../../../../core/models/post/post_model.dart';
import '../../../../core/models/story/stories_model.dart';

extension StoriesModelExtension on StoriesModel {
  Stories toDomain() => Stories(stories);
}

extension StoriesExtension on Stories {
  StoriesModel fromDomain() => StoriesModel(stories);
}

extension PostExtension on Post {
  PostModel fromDomain() => PostModel(
        publisher: publisher,
        postMedia: postMedia,
        postText: postText,
        postDate: postDate,
        locationInfo: locationInfo,
        likes: likes,
        comments: comments,
        taggedPeople: taggedPeople,
        id: id,
      );
}
