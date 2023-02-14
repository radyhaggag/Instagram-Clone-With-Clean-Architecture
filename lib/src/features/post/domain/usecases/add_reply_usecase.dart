import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class AddReplyUseCase extends BaseUseCase<Comment, ReplyParams> {
  final BasePostRepo basePostRepo;

  AddReplyUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Comment>> call(ReplyParams params) async {
    return await basePostRepo.addReply(params);
  }
}

class ReplyParams extends Equatable {
  final String postId;
  final String commentId;
  final String replyText;
  final PersonInfo replier;
  final String publisherUid;
  final String replyDate;

  const ReplyParams({
    required this.postId,
    required this.commentId,
    required this.replyText,
    required this.publisherUid,
    required this.replier,
    required this.replyDate,
  });

  @override
  List<Object> get props {
    return [
      postId,
      commentId,
      replyText,
      replier,
      publisherUid,
      replyDate,
    ];
  }
}
