import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_home_repo.dart';

class LoadPostsUseCase extends BaseUseCase<List<Post>, NoParams> {
  final BaseHomeRepo baseHomeRepo;

  LoadPostsUseCase(this.baseHomeRepo);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return baseHomeRepo.loadPosts();
  }
}
