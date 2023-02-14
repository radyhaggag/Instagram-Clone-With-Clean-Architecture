import '../../../../../core/models/person/person_model.dart';
import '../../../../../core/models/post/post_model.dart';

abstract class BaseRemoteSearchDatasource {
  Future<List<PostModel>> loadSearchPosts();
  Future<List<PersonModel>> search(String name);
}
