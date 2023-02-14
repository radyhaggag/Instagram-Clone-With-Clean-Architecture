import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../domain/usecases/edit_post_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/add_reply_usecase.dart';
import '../../domain/usecases/send_like_for_reply_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';

import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/base_post_repo.dart';
import '../../domain/usecases/add_post_usecase.dart';
import '../datasources/base_remote_post_datasource.dart';

class PostRepo extends BasePostRepo {
  final BaseRemotePostDatasource baseRemotePostDatasource;

  PostRepo(this.baseRemotePostDatasource);

  @override
  Future<Either<Failure, Post>> addPost(PostParams postParams) async {
    try {
      final result = await baseRemotePostDatasource.addPost(postParams);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost(String params) async {
    try {
      final result = await baseRemotePostDatasource.deletePost(params);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<Person>>> getFollowings(String uid) async {
    try {
      final result = await baseRemotePostDatasource.getFollowings(uid);
      final persons = result.map((e) => e.toDomain()).toList();
      return Right(persons);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Post>> addComment(CommentParams params) async {
    try {
      final result = await baseRemotePostDatasource.addComment(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Post>> sendLike(LikeParams params) async {
    try {
      final result = await baseRemotePostDatasource.sendLike(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Comment>> addReply(ReplyParams params) async {
    try {
      final result = await baseRemotePostDatasource.addReply(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Comment>> sendLikeForComment(
      LikeForCommentParams params) async {
    try {
      final result = await baseRemotePostDatasource.sendLikeForComment(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Comment>> sendLikeForReply(
      LikeForReplyParams params) async {
    try {
      final result = await baseRemotePostDatasource.sendLikeForReply(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(GetPostParams postParams) async {
    try {
      final result = await baseRemotePostDatasource.getPost(postParams);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> editPost(EditPostParams params) async {
    try {
      final result = await baseRemotePostDatasource.editPost(params);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
