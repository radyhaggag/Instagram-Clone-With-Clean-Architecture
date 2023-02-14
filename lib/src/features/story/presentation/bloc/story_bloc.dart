import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/usecases/view_story_usecase.dart';

import '../../../../core/domain/entities/story/stories.dart';
import '../../../../core/domain/entities/story/story.dart';
import '../../../../core/domain/entities/story/story_text.dart';
import '../../../../core/utils/app_enums.dart';
import '../../domain/usecases/upload_story_usecase.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final UploadStoryUseCase uploadStoryUseCase;
  final ViewStoryUseCase viewStoryUseCase;
  StoryBloc({
    required this.uploadStoryUseCase,
    required this.viewStoryUseCase,
  }) : super(StoryInitial()) {
    on<StoryEvent>((event, emit) async {
      if (event is SelectStory) {
        await _selectStory(event, emit);
      }
      if (event is StoryUnSelect) {
        _imagePath = _videoPath = null;
      }
      if (event is UploadStory) {
        await _uploadStory(event, emit);
      }
      if (event is ChangeStoryText) {
        _changeStoryText(event, emit);
      }
      if (event is StoryReplaceToText) {
        _imagePath = _videoPath = null;
        emit(const StoryTextSelected());
      }
      if (event is GetNextStory) {
        await _getNextStory(event, emit);
      }
      if (event is UpdateStoryProgressBar) {
        _updateStoryProgressBar(event, emit);
      }
    });
  }

  String? _imagePath;
  String? get imagePath => _imagePath;
  String? _videoPath;
  String? get videoPath => _videoPath;

  Future<void> _selectStory(SelectStory event, Emitter<StoryState> emit) async {
    final XFile? pickedFile;
    if (event.mediaType == MediaType.image) {
      pickedFile = await ImagePicker().pickImage(
        source: event.imageSource,
        imageQuality: 70,
      );
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
        emit(StoryImageSelected(pickedFile.path));
      }
    } else {
      pickedFile = await ImagePicker().pickVideo(
        source: event.imageSource,
        maxDuration: const Duration(seconds: 30),
      );
      if (pickedFile != null) {
        _videoPath = pickedFile.path;
        emit(StoryVideoSelected(_videoPath!));
      }
    }
    if (pickedFile == null) emit(const StorySelectionFailed());
  }

  StoryText? _storyText;
  StoryText? get storyText => _storyText;

  void _changeStoryText(
    ChangeStoryText event,
    Emitter<StoryState> emit,
  ) {
    _storyText = event.storyText;
    emit(StoryTextChanged());
  }

  Future<void> _uploadStory(UploadStory event, Emitter<StoryState> emit) async {
    emit(const StoryUploading());
    StoryParams storyParams = StoryParams(
      storyText: _storyText,
      imagePath: imagePath,
      videoPath: videoPath,
      storyDate: DateTime.now().toUtc().toString(),
    );
    final result = await uploadStoryUseCase(storyParams);
    result.fold(
      (l) => emit(StoryUploadingFailed(l.message)),
      (r) => emit(const StoryUploadingSuccess()),
    );
  }

  _getNextStory(GetNextStory event, Emitter<StoryState> emit) async {
    if (event.arrangementBetweenStories >= event.stories.length) return;
    if (event.stories[event.arrangementBetweenStories].stories.isEmpty) {
      return;
    }
    final story = event
        .stories[event.arrangementBetweenStories].stories[event.storyIndex];
    emit(NextStoryReady(story));

    if (FirebaseAuth.instance.currentUser?.uid == story.publisher.uid) {
      return;
    }
    final viewersUid = story.viewers.map((e) => e.uid).toList();
    if (viewersUid.contains(FirebaseAuth.instance.currentUser?.uid)) {
      return;
    }

    viewStoryUseCase(story);
  }

  _updateStoryProgressBar(
    UpdateStoryProgressBar event,
    Emitter<StoryState> emit,
  ) {
    emit(StoryProgressBarValue(event.second));
  }
}
