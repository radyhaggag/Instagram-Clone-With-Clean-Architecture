part of 'post_bloc.dart';

abstract class PostState {
  const PostState();
}

class PostInitial extends PostState {}

class PostImageSelected extends PostState {
  final List<String> filePath;

  const PostImageSelected(this.filePath);
}

class PostVideoSelected extends PostState {
  final String filePath;

  const PostVideoSelected(this.filePath);
}

class PostSelectionFailed extends PostState {
  const PostSelectionFailed();
}

class PostFollowingsLoadedSuccess extends PostState {
  final List<Person> persons;
  final Post? post;
  const PostFollowingsLoadedSuccess({
    required this.persons,
    this.post,
  });
}

class PostFollowingsLoadingFailed extends PostState {
  final String message;
  const PostFollowingsLoadingFailed(this.message);
}

class PostFollowingsLoading extends PostState {
  const PostFollowingsLoading();
}

class CommentFollowingsLoadedSuccess extends PostState {
  final List<Person> persons;
  final Comment comment;
  const CommentFollowingsLoadedSuccess({
    required this.persons,
    required this.comment,
  });
}

class CommentFollowingsLoadingFailed extends PostState {
  final String message;
  const CommentFollowingsLoadingFailed(this.message);
}

class CommentFollowingsLoading extends PostState {
  const CommentFollowingsLoading();
}

class PostSearchAboutTagsPeopleLoaded extends PostState {
  final List<Person> persons;
  const PostSearchAboutTagsPeopleLoaded(this.persons);
}

class PostTaggedPeopleSelected extends PostState {
  final List<Person> persons;
  const PostTaggedPeopleSelected(this.persons);
}

class PostLatLngSaved extends PostState {}

class PostUploadingSuccess extends PostState {
  final Post post;
  const PostUploadingSuccess({required this.post});
}

class PostUploadingFailed extends PostState {
  final String message;
  const PostUploadingFailed(this.message);
}

class PostUploading extends PostState {
  const PostUploading();
}

class PostSendingLike extends PostState {
  final String postId;

  const PostSendingLike(this.postId);
}

class PostLikedFailed extends PostState {
  final String message;
  const PostLikedFailed(this.message);
}

class PostLikedSuccess extends PostState {
  final Post post;
  const PostLikedSuccess(this.post);
}

class PostAddingComment extends PostState {
  const PostAddingComment();
}

class PostCommentedSuccess extends PostState {
  final Post post;
  const PostCommentedSuccess(this.post);
}

class PostCommentedFailed extends PostState {
  final String message;
  const PostCommentedFailed(this.message);
}

class CommentSendingLike extends PostState {
  final String commentId;
  const CommentSendingLike(this.commentId);
}

class CommentLikedFailed extends PostState {
  final String message;
  const CommentLikedFailed(this.message);
}

class CommentLikedSuccess extends PostState {
  final Comment comment;
  const CommentLikedSuccess(this.comment);
}

class CommentAddingReply extends PostState {
  const CommentAddingReply();
}

class CommentRepliedSuccess extends PostState {
  final Comment comment;
  const CommentRepliedSuccess(this.comment);
}

class CommentRepliedFailed extends PostState {
  final String message;
  const CommentRepliedFailed(this.message);
}

class PostLoadingSuccess extends PostState {
  final Post post;
  const PostLoadingSuccess({required this.post});
}

class PostLoadingFailed extends PostState {
  final String message;
  const PostLoadingFailed(this.message);
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostDeletingSuccess extends PostState {
  final bool status;
  const PostDeletingSuccess({required this.status});
}

class PostDeletingFailed extends PostState {
  final String message;
  const PostDeletingFailed(this.message);
}

class PostDeleting extends PostState {
  const PostDeleting();
}

class PostEditingSuccess extends PostState {
  final bool status;
  const PostEditingSuccess({required this.status});
}

class PostEditingFailed extends PostState {
  final String message;
  const PostEditingFailed(this.message);
}

class PostEditing extends PostState {
  const PostEditing();
}
