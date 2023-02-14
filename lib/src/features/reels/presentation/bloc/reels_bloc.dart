import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../domain/entities/reel.dart';
import '../../domain/usecases/add_comment_usecase.dart';

import '../../domain/usecases/add_reel_usecase.dart';
import '../../domain/usecases/delete_reel_usecase.dart';
import '../../domain/usecases/get_reel_usecase.dart';
import '../../domain/usecases/load_reels_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final AddReelUsecase addReelUseCase;
  final GetReelUseCase getReelUseCase;
  final SendReelLikeUseCase sendLikeUseCase;
  final AddReelCommentUseCase addCommentUseCase;
  final SendLikeForReelCommentUseCase sendLikeForCommentUseCase;
  final DeleteReelUseCase deleteReelUseCase;
  final LoadReelsUseCase loadReelsUseCase;

  ReelsBloc({
    required this.addReelUseCase,
    required this.getReelUseCase,
    required this.sendLikeUseCase,
    required this.addCommentUseCase,
    required this.sendLikeForCommentUseCase,
    required this.deleteReelUseCase,
    required this.loadReelsUseCase,
  }) : super(ReelsInitial()) {
    on<ReelsEvent>(
      (event, emit) async {
        if (event is LoadReels) await _loadReels(event, emit);
        if (event is SelectReelVideo) await _selectReelVideo(event, emit);
        if (event is UploadReel) await _uploadReel(event, emit);
        if (event is SendReelLike) await _sendReelLike(event, emit);
        if (event is AddReelComment) await _addReelComment(event, emit);
        if (event is SendLikeForReelComment) {
          await _sendLikeForReelComment(event, emit);
        }
        if (event is GetReel) await _getReel(event, emit);
        if (event is DeleteReel) await _deleteReel(event, emit);
      },
    );
  }

  String? _videoPath;
  String? get videoPath => _videoPath;

  Future<void> _selectReelVideo(
    SelectReelVideo event,
    Emitter<ReelsState> emit,
  ) async {
    final XFile? pickedFile;
    pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 30),
    );
    if (pickedFile != null) {
      _videoPath = pickedFile.path;
      emit(ReelVideoSelected(_videoPath!));
    } else {
      emit(const ReelSelectionFailed());
    }
  }

  Future<void> _uploadReel(UploadReel event, Emitter<ReelsState> emit) async {
    if (videoPath == null) return;
    emit(const ReelUploading());
    ReelParams reelParams = ReelParams(
      videoPath: videoPath!,
      reelText: event.text,
      reelDate: event.reelDate,
    );
    final result = await addReelUseCase(reelParams);
    result.fold(
      (l) => emit(ReelUploadingFailed(l.message)),
      (r) => emit(ReelUploadingSuccess(reel: r)),
    );
  }

  _sendReelLike(SendReelLike event, Emitter<ReelsState> emit) async {
    emit(ReelSendingLike(event.likeParams.reelId));

    final result = await sendLikeUseCase(event.likeParams);
    result.fold(
      (l) => emit(ReelLikedFailed(l.message)),
      (r) => emit(ReelLikedSuccess(r)),
    );
  }

  _addReelComment(AddReelComment event, Emitter<ReelsState> emit) async {
    emit(const ReelAddingComment());

    final result = await addCommentUseCase(event.commentParams);
    result.fold(
      (l) => emit(ReelCommentedFailed(l.message)),
      (r) => emit(ReelCommentedSuccess(r)),
    );
  }

  _sendLikeForReelComment(
      SendLikeForReelComment event, Emitter<ReelsState> emit) async {
    emit(ReelCommentSendingLike(event.likeParams.commentId));

    final result = await sendLikeForCommentUseCase(event.likeParams);
    result.fold(
      (l) => emit(ReelCommentLikedFailed(l.message)),
      (r) => emit(ReelCommentLikedSuccess(r)),
    );
  }

  _getReel(GetReel event, Emitter<ReelsState> emit) async {
    emit(const ReelLoading());

    final result = await getReelUseCase(event.reelParams);
    result.fold(
      (l) => emit(ReelLoadingFailed(l.message)),
      (r) => emit(ReelLoadingSuccess(reel: r)),
    );
  }

  _deleteReel(DeleteReel event, Emitter<ReelsState> emit) async {
    emit(const ReelDeleting());

    final result = await deleteReelUseCase(event.reelId);
    result.fold(
      (l) => emit(ReelDeletingFailed(l.message)),
      (r) => emit(ReelDeletingSuccess(status: r)),
    );
  }

  _loadReels(LoadReels event, Emitter<ReelsState> emit) async {
    emit(ReelsLoading());
    final result = await loadReelsUseCase(null);

    result.fold(
      (l) => emit(ReelsLoadingFailed(l.message)),
      (r) => emit(ReelsLoadingSuccess(r)),
    );
  }
}
