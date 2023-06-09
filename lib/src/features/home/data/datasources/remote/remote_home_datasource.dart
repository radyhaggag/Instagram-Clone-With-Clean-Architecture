import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/firebase/firestore_collections.dart';
import '../../../../../core/firebase/firestore_manager.dart';
import '../../../../../core/models/post/post_model.dart';
import '../../../../../core/models/story/stories_model.dart';
import '../../../../../core/models/story/story_model.dart';
import '../../../../../core/utils/app_boxes.dart';
import 'base_remote_home_datasource.dart';

class RemoteHomeDatasource implements BaseRemoteHomeDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirestoreManager firestoreManager;

  RemoteHomeDatasource({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firestoreManager,
  });

  @override
  Future<List<StoriesModel>> loadStories() async {
    await AppBoxes.storyBox.clear();
    final List<StoriesModel> stories = [];
    final uid = firebaseAuth.currentUser?.uid;
    final ownStories = StoriesModel(await _getPersonStories(uid!));
    if (ownStories.stories.isNotEmpty) {
      stories.add(ownStories);
      await AppBoxes.storyBox.add(ownStories);
    }
    List<String> followingsUid = await firestoreManager.getFollowingsUid(uid);
    for (var uid in followingsUid) {
      final followingStories = StoriesModel(await _getPersonStories(uid));
      if (followingStories.stories.isNotEmpty) {
        stories.add(followingStories);
        await AppBoxes.storyBox.add(followingStories);
      }
    }
    return stories;
  }

  Future<List<StoryModel>> _getPersonStories(String uid) async {
    final followingStories = await firebaseFirestore
        .collection(FirestoreCollections.stories)
        .doc(uid)
        .collection(FirestoreCollections.currentStories)
        .get();

    List<StoryModel> allStories = followingStories.docs
        .map((story) => StoryModel.fromMap(story.data()))
        .toList();

    return allStories;
  }

  @override
  Future<List<PostModel>> loadPosts() async {
    await AppBoxes.postBox.clear();
    final uid = firebaseAuth.currentUser?.uid;
    List<PostModel> allPosts = [];
    final List<PostModel> yourPosts = await _getPersonPosts(uid!);
    allPosts.addAll(yourPosts);
    final followers = await firestoreManager.getFollowings(uid);
    for (var follower in followers) {
      final followerPosts = await _getPersonPosts(follower.personInfo.uid);
      allPosts.addAll(followerPosts);
    }
    if (allPosts.isNotEmpty) {
      await AppBoxes.postBox.addAll(allPosts);
    }
    return allPosts;
  }

  Future<List<PostModel>> _getPersonPosts(String uid) async {
    final allPosts = await firebaseFirestore
        .collection(FirestoreCollections.posts)
        .doc(uid)
        .collection(FirestoreCollections.allPosts)
        .get();

    List<PostModel> posts = allPosts.docs
        .map((post) => PostModel.fromMap(
              post.data(),
            ))
        .toList();

    return posts;
  }
}
