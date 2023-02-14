part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class SelectPostMedia extends PostEvent {
  final MediaType mediaType;
  final ImageSource imageSource;

  const SelectPostMedia({required this.mediaType, required this.imageSource});
}

class PostUnSelect extends PostEvent {}

class UploadPost extends PostEvent {
  final String? text;
  final String postDate;

  UploadPost(this.text, this.postDate);
}

class PostGetFollowings extends PostEvent {
  final String uid;
  final Post? post;

  PostGetFollowings({
    required this.uid,
    this.post,
  });
}

class CommentGetLikers extends PostEvent {
  final String uid;
  final Comment comment;

  CommentGetLikers({
    required this.uid,
    required this.comment,
  });
}

class SearchAboutTagsPeople extends PostEvent {
  final String name;

  const SearchAboutTagsPeople(this.name);
}

class SelectTagsPeople extends PostEvent {
  final Person person;

  const SelectTagsPeople(this.person);
}

class SaveLocation extends PostEvent {
  final double? lat;
  final double? lng;
  final String? name;

  const SaveLocation(this.lat, this.lng, this.name);
}

class SendLike extends PostEvent {
  final LikeParams likeParams;

  const SendLike(this.likeParams);
}

class AddComment extends PostEvent {
  final CommentParams commentParams;

  const AddComment(this.commentParams);
}

class SendLikeForComment extends PostEvent {
  final LikeForCommentParams likeParams;

  const SendLikeForComment(this.likeParams);
}

class SendLikeForReply extends PostEvent {
  final LikeForReplyParams likeParams;

  const SendLikeForReply(this.likeParams);
}

class AddReply extends PostEvent {
  final ReplyParams replyParams;

  const AddReply(this.replyParams);
}

class GetPost extends PostEvent {
  final GetPostParams postParams;

  const GetPost(this.postParams);
}

class DeletePost extends PostEvent {
  final String postId;

  const DeletePost(this.postId);
}

class EditPost extends PostEvent {
  final EditPostParams postParams;

  const EditPost(this.postParams);
}
