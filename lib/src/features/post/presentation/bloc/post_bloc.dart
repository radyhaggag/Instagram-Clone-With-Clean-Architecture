import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/entities/post/location_info.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/add_reply_usecase.dart';

import '../../../../core/utils/app_enums.dart';
import '../../domain/usecases/add_post_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/edit_post_usecase.dart';
import '../../domain/usecases/get_followings_usecase.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_for_reply_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AddPostUseCase addPostUsecase;
  final GetPostUseCase getPostUsecase;
  final GetFollowingsUseCase getFollowingsUsecase;
  final SendLikeUseCase sendLikeUseCase;
  final AddCommentUseCase addCommentUseCase;
  final SendLikeForCommentUseCase sendLikeForCommentUseCase;
  final SendLikeForReplyUseCase sendLikeForReplyUseCase;
  final AddReplyUseCase addReplyUseCase;
  final DeletePostUseCase deletePostUsecase;
  final EditPostUseCase editPostUsecase;

  PostBloc({
    required this.addPostUsecase,
    required this.getFollowingsUsecase,
    required this.sendLikeUseCase,
    required this.addCommentUseCase,
    required this.sendLikeForCommentUseCase,
    required this.addReplyUseCase,
    required this.getPostUsecase,
    required this.sendLikeForReplyUseCase,
    required this.deletePostUsecase,
    required this.editPostUsecase,
  }) : super(PostInitial()) {
    on<PostEvent>(
      (event, emit) async {
        if (event is SelectPostMedia) await _selectPostMedia(event, emit);
        if (event is PostGetFollowings) await _getPostFollowings(event, emit);
        if (event is CommentGetLikers) {
          await _getCommentFollowings(event, emit);
        }
        if (event is SearchAboutTagsPeople) {
          await _searchAboutTagsPeople(event, emit);
        }
        if (event is SelectTagsPeople) await _selectTaggedPeople(event, emit);
        if (event is SaveLocation) _saveLatLng(event, emit);
        if (event is UploadPost) await _uploadPost(event, emit);
        if (event is SendLike) await _sendLike(event, emit);
        if (event is AddComment) await _addComment(event, emit);
        if (event is SendLikeForComment) await _sendLikeForComment(event, emit);
        if (event is SendLikeForReply) await _sendLikeForReply(event, emit);
        if (event is AddReply) await _addReply(event, emit);
        if (event is GetPost) await _getPost(event, emit);
        if (event is DeletePost) await _deletePost(event, emit);
        if (event is EditPost) await _editPost(event, emit);
      },
    );
  }

  List<String>? _imagesPath;
  List<String>? get imagesPaths => _imagesPath;
  String? _videoPath;
  String? get videoPath => _videoPath;

  Future<void> _selectPostMedia(
    SelectPostMedia event,
    Emitter<PostState> emit,
  ) async {
    if (event.mediaType == MediaType.image) {
      final List<XFile>? pickedFile;
      pickedFile = await ImagePicker().pickMultiImage(imageQuality: 70);
      if (pickedFile.isNotEmpty) {
        _imagesPath = pickedFile.map((e) => e.path).toList();
        emit(PostImageSelected(_imagesPath!));
      } else {
        emit(const PostSelectionFailed());
      }
    } else {
      final XFile? pickedFile;
      pickedFile = await ImagePicker().pickVideo(
        source: event.imageSource,
        maxDuration: const Duration(seconds: 30),
      );
      if (pickedFile != null) {
        _videoPath = pickedFile.path;
        emit(PostVideoSelected(_videoPath!));
      } else {
        emit(const PostSelectionFailed());
      }
    }
  }

  List<Person> _followings = [];
  List<Person> get followings => _followings;

  Future<void> _getPostFollowings(
    PostGetFollowings event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostFollowingsLoading());
    final result = await getFollowingsUsecase(event.uid);
    result.fold(
      (l) => emit(PostFollowingsLoadingFailed(l.message)),
      (r) {
        _followings = r;
        emit(PostFollowingsLoadedSuccess(persons: r, post: event.post));
      },
    );
  }

  Future<void> _getCommentFollowings(
    CommentGetLikers event,
    Emitter<PostState> emit,
  ) async {
    emit(const CommentFollowingsLoading());
    final result = await getFollowingsUsecase(event.uid);
    result.fold(
      (l) => emit(CommentFollowingsLoadingFailed(l.message)),
      (r) {
        _followings = r;
        emit(
          CommentFollowingsLoadedSuccess(persons: r, comment: event.comment),
        );
      },
    );
  }

  List<Person> _searchList = [];
  List<Person> get searchList => _searchList;

  Future<void> _searchAboutTagsPeople(
    SearchAboutTagsPeople event,
    Emitter<PostState> emit,
  ) async {
    _searchList = followings.where((element) {
      return element.personInfo.name == event.name ||
          element.personInfo.name.contains(event.name);
    }).toList();
    emit(PostSearchAboutTagsPeopleLoaded(_searchList));
  }

  final List<Person> _taggedPeople = [];
  List<Person> get taggedPeople => _taggedPeople;

  Future<void> _selectTaggedPeople(
    SelectTagsPeople event,
    Emitter<PostState> emit,
  ) async {
    if (!_taggedPeople.contains(event.person)) {
      _taggedPeople.add(event.person);
    } else {
      _taggedPeople.remove(event.person);
    }
    emit(PostTaggedPeopleSelected(taggedPeople));
  }

  double? lat;
  double? lng;
  String? locationName;

  void _saveLatLng(
    SaveLocation event,
    Emitter<PostState> emit,
  ) {
    lat = event.lat;
    lng = event.lng;
    locationName = event.name;
    emit(PostLatLngSaved());
  }

  Future<void> _uploadPost(UploadPost event, Emitter<PostState> emit) async {
    emit(const PostUploading());
    PostParams postParams = PostParams(
      imagesPaths: imagesPaths ?? [],
      videosPaths: videoPath != null ? [videoPath!] : [],
      postText: event.text,
      postDate: event.postDate,
      taggedPeople: taggedPeople.map((e) => e).toList(),
      locationInfo: locationName != null
          ? LocationInfo(lat: lat!, lng: lng!, name: locationName!)
          : null,
    );
    final result = await addPostUsecase(postParams);
    result.fold(
      (l) => emit(PostUploadingFailed(l.message)),
      (r) => emit(PostUploadingSuccess(post: r)),
    );
  }

  _sendLike(SendLike event, Emitter<PostState> emit) async {
    emit(PostSendingLike(event.likeParams.postId));

    final result = await sendLikeUseCase(event.likeParams);
    result.fold(
      (l) => emit(PostLikedFailed(l.message)),
      (r) => emit(PostLikedSuccess(r)),
    );
  }

  _addComment(AddComment event, Emitter<PostState> emit) async {
    emit(const PostAddingComment());

    final result = await addCommentUseCase(event.commentParams);
    result.fold(
      (l) => emit(PostCommentedFailed(l.message)),
      (r) => emit(PostCommentedSuccess(r)),
    );
  }

  _sendLikeForComment(SendLikeForComment event, Emitter<PostState> emit) async {
    emit(CommentSendingLike(event.likeParams.commentId));

    final result = await sendLikeForCommentUseCase(event.likeParams);
    result.fold(
      (l) => emit(CommentLikedFailed(l.message)),
      (r) => emit(CommentLikedSuccess(r)),
    );
  }

  _addReply(AddReply event, Emitter<PostState> emit) async {
    emit(const CommentAddingReply());

    final result = await addReplyUseCase(event.replyParams);
    result.fold(
      (l) => emit(CommentRepliedFailed(l.message)),
      (r) => emit(CommentRepliedSuccess(r)),
    );
  }

  _getPost(GetPost event, Emitter<PostState> emit) async {
    emit(const PostLoading());

    final result = await getPostUsecase(event.postParams);
    result.fold(
      (l) => emit(PostLoadingFailed(l.message)),
      (r) => emit(PostLoadingSuccess(post: r)),
    );
  }

  _sendLikeForReply(SendLikeForReply event, Emitter<PostState> emit) async {
    emit(CommentSendingLike(event.likeParams.replyId));

    final result = await sendLikeForReplyUseCase(event.likeParams);
    result.fold(
      (l) => emit(CommentLikedFailed(l.message)),
      (r) => emit(CommentLikedSuccess(r)),
    );
  }

  _deletePost(DeletePost event, Emitter<PostState> emit) async {
    emit(const PostDeleting());

    final result = await deletePostUsecase(event.postId);
    result.fold(
      (l) => emit(PostDeletingFailed(l.message)),
      (r) => emit(PostDeletingSuccess(status: r)),
    );
  }

  _editPost(EditPost event, Emitter<PostState> emit) async {
    emit(const PostEditing());

    final result = await editPostUsecase(event.postParams);
    result.fold(
      (l) => emit(PostEditingFailed(l.message)),
      (r) => emit(PostEditingSuccess(status: r)),
    );
  }
}
