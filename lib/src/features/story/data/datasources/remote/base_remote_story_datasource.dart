import '../../../../../core/domain/entities/story/story.dart';
import '../../../domain/usecases/upload_story_usecase.dart';

abstract class BaseRemoteStoryDatasource {
  Future<bool> uploadStory(StoryParams story);
  Future<bool> viewStory(Story story);
}
