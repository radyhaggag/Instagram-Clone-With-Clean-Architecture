import '../../../../../core/models/post/post_model.dart';
import '../../../../../core/models/story/stories_model.dart';

abstract class BaseLocalHomeDatasource {
  List<StoriesModel> loadStories();
  List<PostModel> loadPosts();
}
