part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class SelectStory extends StoryEvent {
  final MediaType mediaType;
  final ImageSource imageSource;

  const SelectStory({required this.mediaType, required this.imageSource});

  @override
  List<Object> get props => [mediaType, imageSource];
}

class StoryReplaceToText extends StoryEvent {
  const StoryReplaceToText();
}

class StoryUnSelect extends StoryEvent {}

class UploadStory extends StoryEvent {
  const UploadStory();

  @override
  List<Object> get props => [];
}

class ChangeStoryText extends StoryEvent {
  final StoryText? storyText;

  const ChangeStoryText(this.storyText);
}

class GetNextStory extends StoryEvent {
  final int arrangementBetweenStories;
  final int storyIndex;
  final List<Stories> stories;

  const GetNextStory({
    required this.storyIndex,
    required this.arrangementBetweenStories,
    required this.stories,
  });

  @override
  List<Object> get props => [storyIndex, arrangementBetweenStories, stories];
}

class UpdateStoryProgressBar extends StoryEvent {
  final int second;

  const UpdateStoryProgressBar({
    required this.second,
  });

  @override
  List<Object> get props => [second];
}
