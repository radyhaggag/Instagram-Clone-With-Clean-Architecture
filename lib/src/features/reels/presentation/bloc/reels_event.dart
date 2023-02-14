part of 'reels_bloc.dart';

abstract class ReelsEvent {
  const ReelsEvent();
}

class LoadReels extends ReelsEvent {}

class SelectReelVideo extends ReelsEvent {}

class UnSelectReel extends ReelsEvent {}

class UploadReel extends ReelsEvent {
  UploadReel(this.text, this.reelDate);

  final String reelDate;
  final String? text;
}

class SendReelLike extends ReelsEvent {
  const SendReelLike(this.likeParams);

  final ReelLikeParams likeParams;
}

class AddReelComment extends ReelsEvent {
  const AddReelComment(this.commentParams);

  final ReelCommentParams commentParams;
}

class SendLikeForReelComment extends ReelsEvent {
  const SendLikeForReelComment(this.likeParams);

  final LikeForReelCommentParams likeParams;
}

class GetReel extends ReelsEvent {
  const GetReel(this.reelParams);

  final GetReelParams reelParams;
}

class DeleteReel extends ReelsEvent {
  const DeleteReel(this.reelId);

  final String reelId;
}
