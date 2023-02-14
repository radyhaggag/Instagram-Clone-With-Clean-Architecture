import '../../../../../core/domain/mappers/mappers.dart';
import '../../../../../core/utils/app_boxes.dart';

import '../../../../../core/models/post/post_model.dart';
import 'base_local_search_datasource.dart';

class LocalSearchDatasource implements BaseLocalSearchDatasource {
  @override
  List<PostModel> loadSearchPosts() {
    final List<PostModel> posts = AppBoxes.searchBox.values.map((e) {
      return e.fromDomain();
    }).toList();
    return posts;
  }
}
