import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/story/stories.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_home_repo.dart';

class LoadStoriesUseCase extends BaseUseCase<List<Stories>, NoParams> {
  final BaseHomeRepo baseHomeRepo;

  LoadStoriesUseCase(this.baseHomeRepo);

  @override
  Future<Either<Failure, List<Stories>>> call(NoParams params) {
    return baseHomeRepo.loadStories();
  }
}
