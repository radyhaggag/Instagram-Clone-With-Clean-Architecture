import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../../core/domain/entities/story/story.dart';
import '../../../../../core/models/story/story_model.dart';

import '../../../../../core/domain/mappers/mappers.dart';
import '../../../../../core/firebase/firestore_collections.dart';
import '../../../../../core/firebase/firestore_manager.dart';
import '../../../domain/usecases/upload_story_usecase.dart';
import 'base_remote_story_datasource.dart';

class RemoteStoryDataSource implements BaseRemoteStoryDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirestoreManager firestoreManager;

  RemoteStoryDataSource({
    required this.auth,
    required this.firestore,
    required this.storage,
    required this.firestoreManager,
  });

  @override
  Future<bool> uploadStory(StoryParams storyParams) async {
    try {
      String? imageUrl;
      String? videoUrl;
      if (storyParams.imagePath != null) {
        await storage
            .ref()
            .child('stories/images/${storyParams.storyDate}.jpg')
            .putFile(File(storyParams.imagePath!))
            .then((value) async {
          imageUrl = await value.ref.getDownloadURL();
        });
      }
      if (storyParams.videoPath != null) {
        videoUrl = await storage
            .ref()
            .child('stories/images/${storyParams.storyDate}.mp4')
            .putFile(File(storyParams.videoPath!))
            .then((value) async {
          return videoUrl = await value.ref.getDownloadURL();
        });
      }
      final User user = auth.currentUser!;
      final person = await firestoreManager.getPerson(user.uid);
      StoryModel story = StoryModel(
        publisher: person.personInfo,
        viewers: [],
        storyText: storyParams.storyText,
        imageLocalPath: storyParams.imagePath,
        videoLocalPath: storyParams.videoPath,
        imageUrl: imageUrl,
        videoUrl: videoUrl,
        storyDate: storyParams.storyDate,
        id: '',
      );

      firestore
          .collection(FirestoreCollections.stories)
          .doc(user.uid)
          .collection(FirestoreCollections.currentStories)
          .add(story.fromDomain().toMap())
          .then((value) => value.update({'id': value.id}));

      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> viewStory(Story story) async {
    try {
      final currentViewer = await firestoreManager.getPerson(
        auth.currentUser!.uid,
      );
      final storyViewersUid = story.viewers.map((e) => e.uid);
      if (!storyViewersUid.contains(auth.currentUser!.uid)) {
        story.viewers.add(currentViewer.personInfo);
        firestore
            .collection(FirestoreCollections.stories)
            .doc(story.publisher.uid)
            .collection(FirestoreCollections.currentStories)
            .doc(story.id)
            .update({
          'viewers': story.viewers.map((e) => e.fromDomain().toMap()).toList(),
        });
      }
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
