import 'package:dartz/dartz.dart';
import '../../domain/entities/reel.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/usecases/add_reel_usecase.dart';
import '../../../../core/domain/entities/post/comment.dart';

import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/base_reels_repo.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/get_reel_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../datasources/base_remote_reels_datasource.dart';

class ReelsRepo extends BaseReelsRepo {
  ReelsRepo(this.baseRemoteReelsDatasource);

  final BaseRemoteReelsDatasource baseRemoteReelsDatasource;

  @override
  Future<Either<Failure, Reel>> addComment(ReelCommentParams params) async {
    try {
      final result = await baseRemoteReelsDatasource.addComment(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Reel>> addReel(ReelParams reelParams) async {
    try {
      final result = await baseRemoteReelsDatasource.addReel(reelParams);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteReel(String reelId) async {
    try {
      final result = await baseRemoteReelsDatasource.deleteReel(reelId);
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Reel>> getReel(GetReelParams reelParams) async {
    try {
      final result = await baseRemoteReelsDatasource.getReel(reelParams);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Reel>> sendLike(ReelLikeParams params) async {
    try {
      final result = await baseRemoteReelsDatasource.sendLike(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Comment>> sendLikeForComment(
      LikeForReelCommentParams params) async {
    try {
      final result = await baseRemoteReelsDatasource.sendLikeForComment(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<Reel>>> loadReels() async {
    try {
      final result = await baseRemoteReelsDatasource.loadReels();
      final reels = result.map((e) => e.toDomain()).toList();
      return Right(reels);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
