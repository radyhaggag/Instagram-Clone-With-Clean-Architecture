import '../../../../../core/models/post/post_model.dart';

abstract class BaseLocalSearchDatasource {
  List<PostModel> loadSearchPosts();
}
