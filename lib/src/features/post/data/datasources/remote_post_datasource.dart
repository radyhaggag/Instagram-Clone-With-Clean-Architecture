import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../../../core/firebase/firestore_collections.dart';
import '../../../../core/models/person/person_model.dart';
import '../../../../core/models/post/comment_model.dart';
import '../../domain/usecases/add_reply_usecase.dart';
import '../../domain/usecases/edit_post_usecase.dart';
import '../../domain/usecases/send_like_for_reply_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/firebase/firestore_manager.dart';
import '../../../../core/models/post/post_media_model.dart';
import '../../../../core/models/post/post_model.dart';
import '../../domain/usecases/add_post_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import 'base_remote_post_datasource.dart';

class RemotePostDatasource extends BaseRemotePostDatasource {
  RemotePostDatasource({
    required this.auth,
    required this.firestore,
    required this.storage,
    required this.firestoreManager,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirestoreManager firestoreManager;
  final FirebaseStorage storage;

  @override
  Future<PostModel> addComment(CommentParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.posts)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allPosts)
          .doc(params.postId);
      var res = await doc.get();
      var postModel = PostModel.fromMap(res.data()!);
      final postComments = postModel.comments.map((e) => e).toList();
      Comment comment = Comment(
        commenterInfo: params.commenter,
        commentText: params.commentText,
        likes: [],
        commentDate: params.commentDate,
        replies: [],
        id: postModel.comments.length.toString(),
      );
      postComments.add(comment);
      doc.update({
        'comments': postComments.map((e) => e.fromDomain().toMap()).toList()
      });
      return postModel.copyWith(comments: postComments).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostModel> addPost(PostParams postParams) async {
    try {
      final User user = auth.currentUser!;
      final person = await firestoreManager.getPerson(user.uid);
      List<String> imagesUrl = [];
      List<String> videosUrl = [];
      for (var i = 0; i < postParams.imagesPaths.length; i++) {
        await storage
            .ref()
            .child(
              'posts/images/${person.personInfo.uid}/${postParams.postDate} ($i).jpg',
            )
            .putFile(File(postParams.imagesPaths[i]))
            .then(
              (value) async => imagesUrl.add(await value.ref.getDownloadURL()),
            );
      }
      for (var i = 0; i < postParams.videosPaths.length; i++) {
        await storage
            .ref()
            .child('posts/videos/${user.uid}/${postParams.postDate} ($i).mp4')
            .putFile(File(postParams.videosPaths[i]))
            .then(
              (value) async => videosUrl.add(await value.ref.getDownloadURL()),
            );
      }

      final PostMediaModel postMediaModel = PostMediaModel(
        imagesUrl: imagesUrl,
        imagesLocalPaths: postParams.imagesPaths,
        videosUrl: videosUrl,
        videosLocalPaths: postParams.videosPaths,
      );

      final PostModel postModel = PostModel(
        publisher: person.personInfo,
        postMedia: postMediaModel.toDomain(),
        postText: postParams.postText,
        postDate: postParams.postDate,
        locationInfo: postParams.locationInfo,
        taggedPeople: postParams.taggedPeople ?? [],
        comments: [],
        likes: [],
        id: '',
      );
      final doc = await firestore
          .collection(FirestoreCollections.posts)
          .doc(person.personInfo.uid)
          .collection(FirestoreCollections.allPosts)
          .add(postModel.toMap());
      doc.update({'id': doc.id});
      await firestore
          .collection(FirestoreCollections.persons)
          .doc(person.personInfo.uid)
          .update({"numOfPosts": person.numOfPosts + 1});
      return postModel.copyWith(id: doc.id).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> addReply(ReplyParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.posts)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allPosts)
          .doc(params.postId);
      var res = await doc.get();
      var postModel = PostModel.fromMap(res.data()!);
      final postComments =
          postModel.comments.map((e) => e.fromDomain()).toList();
      final repliedComment = postComments
          .firstWhere((comment) => comment.id == params.commentId)
          .fromDomain();
      final repliedCommentIndex =
          postComments.indexWhere((comment) => comment.id == params.commentId);

      Comment newReply = Comment(
        commenterInfo: params.replier,
        commentText: params.replyText,
        likes: [],
        commentDate: params.replyDate,
        replies: [],
        id: (postComments.length + repliedComment.replies.length + 1)
            .toString(),
      );
      repliedComment.replies.add(newReply);
      postComments[repliedCommentIndex] = repliedComment;

      doc.update({
        'comments': postComments.map((e) => e.fromDomain().toMap()).toList()
      });

      return repliedComment;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deletePost(String postParams) async {
    try {
      final User user = auth.currentUser!;
      final person = await firestoreManager.getPerson(user.uid);

      await firestore
          .collection(FirestoreCollections.posts)
          .doc(user.uid)
          .collection(FirestoreCollections.allPosts)
          .doc(postParams)
          .delete();
      await firestore
          .collection(FirestoreCollections.persons)
          .doc(user.uid)
          .update({"numOfPosts": person.numOfPosts - 1});

      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> editPost(EditPostParams postParams) async {
    try {
      await firestore
          .collection(FirestoreCollections.posts)
          .doc(auth.currentUser?.uid)
          .collection(FirestoreCollections.allPosts)
          .doc(postParams.postId)
          .update({'postText': postParams.postText});
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PersonModel>> getFollowings(String uid) async {
    final result = await firestoreManager.getFollowings(uid);
    return result;
  }

  @override
  Future<PostModel> getPost(GetPostParams postParams) async {
    try {
      final doc = await firestore
          .collection(FirestoreCollections.posts)
          .doc(postParams.publisherId)
          .collection(FirestoreCollections.allPosts)
          .doc(postParams.postId)
          .get();
      final post = PostModel.fromMap(doc.data()!);
      return post;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PostModel> sendLike(LikeParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.posts)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allPosts)
          .doc(params.postId);
      var res = await doc.get();
      var postModel = PostModel.fromMap(res.data()!);
      final postLikes = postModel.likes;
      final likerPerson =
          await firestoreManager.getPerson(auth.currentUser!.uid);

      final likersUid = postLikes.map((e) => e.uid).toList();
      if (!likersUid.contains(likerPerson.personInfo.uid)) {
        postLikes.add(likerPerson.personInfo);
      } else {
        postLikes.removeWhere(
          (element) => element.uid == likerPerson.personInfo.uid,
        );
      }
      doc.update({
        'likes': postLikes.map((e) => e.fromDomain().toMap()).toList(),
      });

      return postModel.copyWith(likes: postLikes).fromDomain();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> sendLikeForComment(LikeForCommentParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.posts)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allPosts)
          .doc(params.postId);
      final res = await doc.get();
      final postModel = PostModel.fromMap(res.data()!);
      final postComments = postModel.comments;
      final likerPerson =
          await firestoreManager.getPerson(auth.currentUser!.uid);
      final likedComment = postComments
          .firstWhere((comment) => comment.id == params.commentId)
          .fromDomain();
      final likedCommentIndex =
          postComments.indexWhere((comment) => comment.id == params.commentId);
      final likersUid = likedComment.likes.map((e) => e.uid).toList();

      if (!likersUid.contains(likerPerson.personInfo.uid)) {
        likedComment.likes.add(likerPerson.personInfo);
        postComments[likedCommentIndex] = likedComment;
      } else {
        likedComment.likes.removeWhere(
            (element) => element.uid == likerPerson.personInfo.uid);
        postComments[likedCommentIndex] = likedComment;
      }
      doc.update({
        'comments': postComments.map((e) => e.fromDomain().toMap()).toList(),
      });
      return likedComment;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> sendLikeForReply(LikeForReplyParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.posts)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allPosts)
          .doc(params.postId);
      final res = await doc.get();
      final postModel = PostModel.fromMap(res.data()!);
      final postComments = postModel.comments;
      final likerPerson =
          await firestoreManager.getPerson(auth.currentUser!.uid);
      final likedComment = postComments
          .firstWhere((comment) => comment.id == params.commentId)
          .fromDomain();
      final likedCommentIndex =
          postComments.indexWhere((comment) => comment.id == params.commentId);
      final likedReply = likedComment.replies
          .firstWhere((reply) => reply.id == params.replyId)
          .fromDomain();
      final likedReplyIndex = likedComment.replies
          .indexWhere((reply) => reply.id == params.replyId);
      final likersUid = likedReply.likes.map((e) => e.uid).toList();

      if (!likersUid.contains(likerPerson.personInfo.uid)) {
        likedReply.likes.add(likerPerson.personInfo);
        likedComment.replies[likedReplyIndex] = likedReply;
        postComments[likedCommentIndex] = likedComment;
      } else {
        likedReply.likes.removeWhere(
          (element) => element.uid == likerPerson.personInfo.uid,
        );
        likedComment.replies[likedReplyIndex] = likedReply;
        postComments[likedCommentIndex] = likedComment;
      }
      doc.update({
        'comments': postComments.map((e) => e.fromDomain().toMap()).toList(),
      });
      return likedReply;
    } catch (_) {
      rethrow;
    }
  }
}
