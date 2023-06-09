import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/error/failure.dart';
import '../entities/reel.dart';
import '../usecases/add_comment_usecase.dart';
import '../usecases/add_reel_usecase.dart';
import '../usecases/get_reel_usecase.dart';
import '../usecases/send_like_for_comment_usecase.dart';
import '../usecases/send_like_usecase.dart';

abstract class BaseReelsRepo {
  Future<Either<Failure, List<Reel>>> loadReels();
  Future<Either<Failure, Reel>> addReel(ReelParams reelParams);
  Future<Either<Failure, Reel>> getReel(GetReelParams reelParams);
  Future<Either<Failure, bool>> deleteReel(String reelId);
  Future<Either<Failure, Reel>> sendLike(ReelLikeParams params);
  Future<Either<Failure, Reel>> addComment(ReelCommentParams params);
  Future<Either<Failure, Comment>> sendLikeForComment(
    LikeForReelCommentParams params,
  );
}
