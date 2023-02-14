import '../../../../core/models/person/person_model.dart';
import '../../../../core/models/post/comment_model.dart';
import '../../../../core/models/post/post_model.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/add_post_usecase.dart';
import '../../domain/usecases/add_reply_usecase.dart';
import '../../domain/usecases/edit_post_usecase.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_for_reply_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';

abstract class BaseRemotePostDatasource {
  Future<PostModel> addPost(PostParams postParams);
  Future<bool> deletePost(String postParams);
  Future<bool> editPost(EditPostParams postParams);
  Future<PostModel> getPost(GetPostParams postParams);
  Future<List<PersonModel>> getFollowings(String uid);
  Future<PostModel> sendLike(LikeParams params);
  Future<PostModel> addComment(CommentParams params);
  Future<CommentModel> addReply(ReplyParams params);
  Future<CommentModel> sendLikeForComment(LikeForCommentParams params);
  Future<CommentModel> sendLikeForReply(LikeForReplyParams params);
}
