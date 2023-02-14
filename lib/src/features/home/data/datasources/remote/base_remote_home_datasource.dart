import '../../../../../core/models/post/post_model.dart';

import '../../../../../core/models/story/stories_model.dart';

abstract class BaseRemoteHomeDatasource {
  Future<List<StoriesModel>> loadStories();
  Future<List<PostModel>> loadPosts();
}
