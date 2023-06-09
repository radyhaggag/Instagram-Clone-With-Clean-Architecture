import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class SendLikeForReplyUseCase extends BaseUseCase<Comment, LikeForReplyParams> {
  final BasePostRepo basePostRepo;

  SendLikeForReplyUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Comment>> call(LikeForReplyParams params) async {
    return await basePostRepo.sendLikeForReply(params);
  }
}

class LikeForReplyParams extends Equatable {
  final String postId;
  final String commentId;
  final String publisherUid;
  final String replyId;

  const LikeForReplyParams({
    required this.postId,
    required this.commentId,
    required this.publisherUid,
    required this.replyId,
  });

  @override
  List<Object> get props {
    return [
      postId,
      commentId,
      publisherUid,
      replyId,
    ];
  }
}
