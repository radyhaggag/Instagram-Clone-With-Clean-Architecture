part of 'story_bloc.dart';

abstract class StoryState {
  const StoryState();
}

class StoryInitial extends StoryState {}

class StoryImageSelected extends StoryState {
  final String filePath;

  const StoryImageSelected(this.filePath);
}

class StoryVideoSelected extends StoryState {
  final String filePath;

  const StoryVideoSelected(this.filePath);
}

class StorySelectionFailed extends StoryState {
  const StorySelectionFailed();
}

class StoryTextSelected extends StoryState {
  const StoryTextSelected();
}

class StoryUploading extends StoryState {
  const StoryUploading();
}

class StoryUploadingSuccess extends StoryState {
  const StoryUploadingSuccess();
}

class StoryUploadingFailed extends StoryState {
  final String message;

  const StoryUploadingFailed(this.message);
}

class StoryTextChanged extends StoryState {}

class NextStoryReady extends StoryState {
  final Story story;

  const NextStoryReady(this.story);
}

class StoryProgressBarValue extends StoryState {
  final int value;

  const StoryProgressBarValue(this.value);
}
