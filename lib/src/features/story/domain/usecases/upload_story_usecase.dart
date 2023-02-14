import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/story/story_text.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_story_repo.dart';

class UploadStoryUseCase extends BaseUseCase<bool, StoryParams> {
  final BaseStoryRepo baseStoryRepo;

  UploadStoryUseCase(this.baseStoryRepo);

  @override
  Future<Either<Failure, bool>> call(StoryParams params) {
    return baseStoryRepo.uploadStory(params);
  }
}

class StoryParams {
  final String storyDate;
  final StoryText? storyText;
  final String? imagePath;
  final String? videoPath;

  const StoryParams({
    required this.storyDate,
    required this.storyText,
    required this.imagePath,
    required this.videoPath,
  });
}
