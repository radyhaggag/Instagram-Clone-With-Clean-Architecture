import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/story/story.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_story_repo.dart';

class ViewStoryUseCase extends BaseUseCase<bool, Story> {
  final BaseStoryRepo baseStoryRepo;

  ViewStoryUseCase(this.baseStoryRepo);

  @override
  Future<Either<Failure, bool>> call(Story params) {
    return baseStoryRepo.viewStory(params);
  }
}
