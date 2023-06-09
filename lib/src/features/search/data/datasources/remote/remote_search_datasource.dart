import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/domain/mappers/mappers.dart';
import '../../../../../core/firebase/firestore_collections.dart';

import '../../../../../core/firebase/firestore_manager.dart';
import '../../../../../core/models/post/post_model.dart';
import '../../../../../core/models/person/person_model.dart';
import '../../../../reels/data/models/reel_model.dart';
import '../../../../reels/domain/mappers/mappers.dart';

import '../../../../../core/utils/app_boxes.dart';
import 'base_remote_search_datasource.dart';

class RemoteSearchDatasource implements BaseRemoteSearchDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirestoreManager firestoreManager;
  final FirebaseAuth auth;

  RemoteSearchDatasource({
    required this.firebaseFirestore,
    required this.firestoreManager,
    required this.auth,
  });

  @override
  Future<List<PostModel>> loadSearchPosts() async {
    try {
      await AppBoxes.searchBox.clear();

      List<PostModel> posts = [];
      List<String> targetsUid = []; // Uid of each one will fetch his posts

      final followingsUid = await firestoreManager.getFollowingsUid(
        auth.currentUser!.uid,
      );
      final followersUid = await firestoreManager.getFollowersUid(
        auth.currentUser!.uid,
      );

      for (var uid in followingsUid) {
        targetsUid.add(uid);
      }

      for (var uid in followersUid) {
        if (!targetsUid.contains(uid)) targetsUid.add(uid);
      }

      for (var uid in targetsUid) {
        final allPosts = await firebaseFirestore
            .collection(FirestoreCollections.posts)
            .doc(uid)
            .collection(FirestoreCollections.allPosts)
            .get();

        for (var doc in allPosts.docs) {
          final post = PostModel.fromMap(doc.data());
          posts.add(post);
        }
        final allReels = await firebaseFirestore
            .collection(FirestoreCollections.reels)
            .doc(uid)
            .collection(FirestoreCollections.allReels)
            .get();

        for (var doc in allReels.docs) {
          final reel = ReelModel.fromMap(doc.data());
          posts.add(reel.toPost().fromDomain());
        }
      }

      await AppBoxes.searchBox.addAll(posts);

      return posts;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PersonModel>> search(String name) async {
    try {
      List<PersonModel> persons = [];
      final personCollection = await firebaseFirestore
          .collection(FirestoreCollections.persons)
          .get();
      for (var doc in personCollection.docs) {
        final person = PersonModel.fromMap(
          doc.data(),
        );
        final personName = person.personInfo.name.toLowerCase();

        final nameLowerCase = name.toLowerCase();
        if (personName.contains(nameLowerCase)) {
          persons.add(person);
        }
      }
      return persons;
    } catch (_) {
      rethrow;
    }
  }
}
