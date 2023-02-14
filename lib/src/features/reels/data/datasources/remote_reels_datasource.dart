import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/usecases/add_reel_usecase.dart';
import '../../../../core/firebase/firestore_collections.dart';
import '../../../../core/models/post/comment_model.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/firebase/firestore_manager.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/get_reel_usecase.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../models/reel_model.dart';
import 'base_remote_reels_datasource.dart';

class RemoteReelsDatasource extends BaseRemoteReelsDatasource {
  RemoteReelsDatasource({
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
  Future<ReelModel> addComment(ReelCommentParams params) async {
    try {
      final commenter = await firestoreManager.getPerson(auth.currentUser!.uid);
      final doc = firestore
          .collection(FirestoreCollections.reels)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allReels)
          .doc(params.reelId);
      var res = await doc.get();
      var reelModel = ReelModel.fromMap(res.data()!);
      final reelComments = reelModel.comments.map((e) => e).toList();
      Comment comment = Comment(
        commenterInfo: commenter.personInfo,
        commentText: params.commentText,
        likes: [],
        commentDate: params.commentDate,
        replies: [],
        id: reelModel.comments.length.toString(),
      );
      reelComments.add(comment);
      doc.update({
        'comments': reelComments.map((e) => e.fromDomain().toMap()).toList()
      });
      return reelModel.copyWith(comments: reelComments).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ReelModel> addReel(ReelParams reelParams) async {
    try {
      final User user = auth.currentUser!;
      final person = await firestoreManager.getPerson(user.uid);
      late String videoUrl;
      await storage
          .ref()
          .child('reels/videos/${user.uid}/${reelParams.reelDate}.mp4')
          .putFile(File(reelParams.videoPath))
          .then((value) async => videoUrl = await value.ref.getDownloadURL());

      final ReelModel reelModel = ReelModel(
        publisher: person.personInfo,
        videoUrl: videoUrl,
        reelText: reelParams.reelText,
        reelDate: reelParams.reelDate,
        comments: const [],
        likes: const [],
        id: '',
      );
      final doc = await firestore
          .collection(FirestoreCollections.reels)
          .doc(person.personInfo.uid)
          .collection(FirestoreCollections.allReels)
          .add(reelModel.toMap());
      doc.update({'id': doc.id});
      return reelModel.copyWith(id: doc.id).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteReel(String reelId) async {
    try {
      await firestore
          .collection(FirestoreCollections.reels)
          .doc(auth.currentUser?.uid)
          .collection(FirestoreCollections.allReels)
          .doc(reelId)
          .delete();
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ReelModel> getReel(GetReelParams reelParams) async {
    try {
      final doc = await firestore
          .collection(FirestoreCollections.reels)
          .doc(reelParams.publisherId)
          .collection(FirestoreCollections.allReels)
          .doc(reelParams.reelId)
          .get();
      final reel = ReelModel.fromMap(doc.data()!);
      return reel;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ReelModel> sendLike(ReelLikeParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.reels)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allReels)
          .doc(params.reelId);
      var res = await doc.get();
      var reelModel = ReelModel.fromMap(res.data()!);
      final reelLikes = reelModel.likes;
      final likerPerson =
          await firestoreManager.getPerson(auth.currentUser!.uid);

      final likersUid = reelLikes.map((e) => e.uid).toList();
      if (!likersUid.contains(likerPerson.personInfo.uid)) {
        reelLikes.add(likerPerson.personInfo);
      } else {
        reelLikes.removeWhere(
          (element) => element.uid == likerPerson.personInfo.uid,
        );
      }
      doc.update({
        'likes': reelLikes.map((e) => e.fromDomain().toMap()).toList(),
      });

      return reelModel.copyWith(likes: reelLikes).fromDomain();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> sendLikeForComment(
      LikeForReelCommentParams params) async {
    try {
      final doc = firestore
          .collection(FirestoreCollections.reels)
          .doc(params.publisherUid)
          .collection(FirestoreCollections.allReels)
          .doc(params.reelId);
      final res = await doc.get();
      final reelModel = ReelModel.fromMap(res.data()!);
      final reelComments = reelModel.comments;
      final likerPerson =
          await firestoreManager.getPerson(auth.currentUser!.uid);
      final likedComment = reelComments
          .firstWhere((comment) => comment.id == params.commentId)
          .fromDomain();
      final likedCommentIndex =
          reelComments.indexWhere((comment) => comment.id == params.commentId);
      final likersUid = likedComment.likes.map((e) => e.uid).toList();

      if (!likersUid.contains(likerPerson.personInfo.uid)) {
        likedComment.likes.add(likerPerson.personInfo);
        reelComments[likedCommentIndex] = likedComment;
      } else {
        likedComment.likes.removeWhere(
            (element) => element.uid == likerPerson.personInfo.uid);
        reelComments[likedCommentIndex] = likedComment;
      }
      doc.update({
        'comments': reelComments.map((e) => e.fromDomain().toMap()).toList(),
      });
      return likedComment;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<ReelModel>> loadReels() async {
    final uid = auth.currentUser?.uid;
    List<ReelModel> allReels = [];
    final List<ReelModel> yourReels = await _getPersonReels(uid!);
    allReels.addAll(yourReels);
    final followers = await firestoreManager.getFollowings(uid);
    for (var follower in followers) {
      final followerPosts = await _getPersonReels(follower.personInfo.uid);
      allReels.addAll(followerPosts);
    }
    return allReels;
  }

  Future<List<ReelModel>> _getPersonReels(String uid) async {
    List<ReelModel> reels = [];
    final result = await firestore
        .collection(FirestoreCollections.reels)
        .doc(uid)
        .collection(FirestoreCollections.allReels)
        .get();

    reels = result.docs.map((e) => ReelModel.fromMap(e.data())).toList();

    return reels;
  }
}
