import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_reels_repo.dart';

class SendLikeForReelCommentUseCase
    extends BaseUseCase<Comment, LikeForReelCommentParams> {
  final BaseReelsRepo baseReelsRepo;

  SendLikeForReelCommentUseCase(this.baseReelsRepo);

  @override
  Future<Either<Failure, Comment>> call(LikeForReelCommentParams params) async {
    return await baseReelsRepo.sendLikeForComment(params);
  }
}

class LikeForReelCommentParams extends Equatable {
  final String reelId;
  final String commentId;
  final String publisherUid;

  const LikeForReelCommentParams({
    required this.reelId,
    required this.commentId,
    required this.publisherUid,
  });

  @override
  List<Object> get props => [reelId, commentId, publisherUid];
}
