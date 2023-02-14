import 'package:dartz/dartz.dart';
import '../usecases/get_post_usecase.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/error/failure.dart';
import '../usecases/add_comment_usecase.dart';
import '../usecases/add_post_usecase.dart';
import '../usecases/add_reply_usecase.dart';
import '../usecases/edit_post_usecase.dart';
import '../usecases/send_like_for_comment_usecase.dart';
import '../usecases/send_like_for_reply_usecase.dart';
import '../usecases/send_like_usecase.dart';

abstract class BasePostRepo {
  Future<Either<Failure, Post>> addPost(PostParams postParams);
  Future<Either<Failure, bool>> deletePost(String params);
  Future<Either<Failure, bool>> editPost(EditPostParams params);
  Future<Either<Failure, Post>> getPost(GetPostParams postParams);
  Future<Either<Failure, List<Person>>> getFollowings(String uid);
  Future<Either<Failure, Post>> sendLike(LikeParams params);
  Future<Either<Failure, Post>> addComment(CommentParams params);
  Future<Either<Failure, Comment>> sendLikeForComment(
    LikeForCommentParams params,
  );
  Future<Either<Failure, Comment>> sendLikeForReply(LikeForReplyParams params);
  Future<Either<Failure, Comment>> addReply(ReplyParams params);
}
