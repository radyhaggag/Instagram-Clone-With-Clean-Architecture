import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_search_repo.dart';

class LoadSearchPostsUseCase extends BaseUseCase<List<Post>, String> {
  final BaseSearchRepo baseSearchRepo;

  LoadSearchPostsUseCase(this.baseSearchRepo);

  @override
  Future<Either<Failure, List<Post>>> call(String params) async {
    return await baseSearchRepo.loadSearchPosts();
  }
}
