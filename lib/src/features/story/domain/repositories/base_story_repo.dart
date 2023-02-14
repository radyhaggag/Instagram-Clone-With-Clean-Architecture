import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/story/story.dart';

import '../../../../core/error/failure.dart';
import '../usecases/upload_story_usecase.dart';

abstract class BaseStoryRepo {
  Future<Either<Failure, bool>> uploadStory(StoryParams storyParams);
  Future<Either<Failure, bool>> viewStory(Story story);
}
