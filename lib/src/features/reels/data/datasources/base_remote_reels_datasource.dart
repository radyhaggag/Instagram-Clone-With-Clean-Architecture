import '../../../../core/models/post/comment_model.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/add_reel_usecase.dart';
import '../../domain/usecases/get_reel_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../models/reel_model.dart';

abstract class BaseRemoteReelsDatasource {
  Future<ReelModel> addReel(ReelParams reelParams);
  Future<List<ReelModel>> loadReels();
  Future<bool> deleteReel(String reelId);
  Future<ReelModel> getReel(GetReelParams reelParams);
  Future<ReelModel> sendLike(ReelLikeParams params);
  Future<ReelModel> addComment(ReelCommentParams params);
  Future<CommentModel> sendLikeForComment(LikeForReelCommentParams params);
}
