import '../../../../../core/models/post/post_model.dart';
import '../../../../../core/models/story/stories_model.dart';
import '../../../../../core/utils/app_boxes.dart';
import '../../../domain/mappers/mappers.dart';
import 'base_local_home_datasource.dart';

class LocalHomeDatasource implements BaseLocalHomeDatasource {
  @override
  List<StoriesModel> loadStories() {
    final List<StoriesModel> stories = AppBoxes.storyBox.values.map((e) {
      return e.fromDomain();
    }).toList();

    return stories;
  }

  @override
  List<PostModel> loadPosts() {
    final List<PostModel> posts = AppBoxes.postBox.values.map((e) {
      return e.fromDomain();
    }).toList();
    return posts;
  }
}
