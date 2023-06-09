import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class AddCommentUseCase extends BaseUseCase<Post, CommentParams> {
  final BasePostRepo basePostRepo;

  AddCommentUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Post>> call(CommentParams params) async {
    return await basePostRepo.addComment(params);
  }
}

class CommentParams extends Equatable {
  final String postId;
  final String commentText;
  final PersonInfo commenter;
  final String publisherUid;
  final String commentDate;

  const CommentParams({
    required this.postId,
    required this.commentText,
    required this.publisherUid,
    required this.commenter,
    required this.commentDate,
  });

  @override
  List<Object> get props =>
      [postId, commentText, publisherUid, commenter, commentDate];
}
