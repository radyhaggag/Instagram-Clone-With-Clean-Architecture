part of 'reels_bloc.dart';

abstract class ReelsState {
  const ReelsState();
}

class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsLoadingSuccess extends ReelsState {
  final List<Reel> reels;

  ReelsLoadingSuccess(this.reels);
}

class ReelsLoadingFailed extends ReelsState {
  final String message;

  ReelsLoadingFailed(this.message);
}

class ReelVideoSelected extends ReelsState {
  final String videoPath;

  const ReelVideoSelected(this.videoPath);
}

class ReelSelectionFailed extends ReelsState {
  const ReelSelectionFailed();
}

class ReelUploadingSuccess extends ReelsState {
  final Reel reel;
  const ReelUploadingSuccess({required this.reel});
}

class ReelUploadingFailed extends ReelsState {
  final String message;
  const ReelUploadingFailed(this.message);
}

class ReelUploading extends ReelsState {
  const ReelUploading();
}

class ReelSendingLike extends ReelsState {
  final String reelId;

  const ReelSendingLike(this.reelId);
}

class ReelLikedFailed extends ReelsState {
  final String message;
  const ReelLikedFailed(this.message);
}

class ReelLikedSuccess extends ReelsState {
  final Reel reel;
  const ReelLikedSuccess(this.reel);
}

class ReelAddingComment extends ReelsState {
  const ReelAddingComment();
}

class ReelCommentedSuccess extends ReelsState {
  final Reel reel;
  const ReelCommentedSuccess(this.reel);
}

class ReelCommentedFailed extends ReelsState {
  final String message;
  const ReelCommentedFailed(this.message);
}

class ReelCommentSendingLike extends ReelsState {
  final String commentId;
  const ReelCommentSendingLike(this.commentId);
}

class ReelCommentLikedFailed extends ReelsState {
  final String message;
  const ReelCommentLikedFailed(this.message);
}

class ReelCommentLikedSuccess extends ReelsState {
  final Comment comment;
  const ReelCommentLikedSuccess(this.comment);
}

class ReelLoadingSuccess extends ReelsState {
  final Reel reel;
  const ReelLoadingSuccess({required this.reel});
}

class ReelLoadingFailed extends ReelsState {
  final String message;
  const ReelLoadingFailed(this.message);
}

class ReelLoading extends ReelsState {
  const ReelLoading();
}

class ReelDeletingSuccess extends ReelsState {
  final bool status;
  const ReelDeletingSuccess({required this.status});
}

class ReelDeletingFailed extends ReelsState {
  final String message;
  const ReelDeletingFailed(this.message);
}

class ReelDeleting extends ReelsState {
  const ReelDeleting();
}
