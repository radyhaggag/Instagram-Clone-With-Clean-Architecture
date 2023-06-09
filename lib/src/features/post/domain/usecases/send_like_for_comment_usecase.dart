import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class SendLikeForCommentUseCase
    extends BaseUseCase<Comment, LikeForCommentParams> {
  final BasePostRepo basePostRepo;

  SendLikeForCommentUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Comment>> call(LikeForCommentParams params) async {
    return await basePostRepo.sendLikeForComment(params);
  }
}

class LikeForCommentParams extends Equatable {
  final String postId;
  final String commentId;
  final String publisherUid;

  const LikeForCommentParams({
    required this.postId,
    required this.commentId,
    required this.publisherUid,
  });

  @override
  List<Object> get props {
    return [
      postId,
      commentId,
      publisherUid,
    ];
  }
}
