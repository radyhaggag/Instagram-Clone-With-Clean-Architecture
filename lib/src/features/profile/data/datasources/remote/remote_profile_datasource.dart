import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../../core/domain/entities/person/person_info.dart';
import '../../../../../core/domain/entities/post/post.dart';
import '../../../../../core/domain/mappers/mappers.dart';
import '../../../../../core/firebase/firestore_collections.dart';

import '../../../../../core/firebase/firestore_manager.dart';
import '../../../../../core/models/person/person_model.dart';
import '../../../../../core/models/post/post_model.dart';
import '../../../../../core/utils/app_boxes.dart';
import 'base_remote_profile_datasource.dart';
import '../../../domain/entities/profile.dart';
import '../../../../reels/data/models/reel_model.dart';
import '../../../../reels/domain/mappers/mappers.dart';

class RemoteProfileDatasource implements BaseRemoteProfileDatasource {
  RemoteProfileDatasource({
    required this.firebaseFirestore,
    required this.firestoreManager,
    required this.auth,
    required this.storage,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;
  final FirestoreManager firestoreManager;
  final FirebaseStorage storage;

  @override
  Future<String> follow(String personUid) async {
    /*
      Follow idea is add person which you will follow in your followings
      and edit num of followings on persons collection
      then add yourself as follower in the followers collection to this person
      which you will follow and the same idea in un follow.
    */
    try {
      // First in your doc
      var me = await firestoreManager.getPerson(auth.currentUser!.uid);
      var person = await firestoreManager.getPerson(personUid);
      final yourDocRef = firebaseFirestore
          .collection(FirestoreCollections.persons)
          .doc(auth.currentUser?.uid);
      person = person
          .copyWith(numOfFollowers: person.numOfFollowers + 1)
          .fromDomain();
      me = me.copyWith(numOfFollowings: me.numOfFollowings + 1).fromDomain();

      await yourDocRef
          .collection(FirestoreCollections.followings)
          .doc(person.personInfo.uid)
          .set(person.fromDomain().toMap());
      await yourDocRef.update({'numOfFollowings': me.numOfFollowings});

      // Second in the person which you following doc
      final hisDocRef = firebaseFirestore
          .collection(FirestoreCollections.persons)
          .doc(person.personInfo.uid);

      await hisDocRef
          .collection(FirestoreCollections.followers)
          .doc(auth.currentUser?.uid)
          .set(me.fromDomain().toMap());
      await hisDocRef.update({'numOfFollowers': person.numOfFollowers});

      return person.personInfo.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PersonModel>> getFollowers(String uid) async {
    try {
      final followers = await firestoreManager.getFollowers(uid);
      return followers;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PersonModel>> getFollowings(String uid) async {
    try {
      final followings = await firestoreManager.getFollowings(uid);
      return followings;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Profile> getProfile(String uid) async {
    try {
      final person = await firestoreManager.getPerson(uid);
      List<Post> posts = [];
      final allPosts = await firebaseFirestore
          .collection(FirestoreCollections.posts)
          .doc(uid)
          .collection(FirestoreCollections.allPosts)
          .get();
      for (var doc in allPosts.docs) {
        final post = PostModel.fromMap(doc.data());
        posts.add(post.toDomain());
      }
      final allReels = await firebaseFirestore
          .collection(FirestoreCollections.reels)
          .doc(uid)
          .collection(FirestoreCollections.allReels)
          .get();
      for (var doc in allReels.docs) {
        final reel = ReelModel.fromMap(doc.data());
        posts.add(reel.toPost());
      }
      final Profile profile = Profile(person: person, posts: posts);
      final localProfile = AppBoxes.profileBox.values
          .where(
            (e) => e.person.personInfo.uid == profile.person.personInfo.uid,
          )
          .toList();
      for (var e in localProfile) {
        AppBoxes.profileBox.delete(e);
      }
      AppBoxes.profileBox.add(profile);
      return profile;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> unFollow(String personUid) async {
    try {
      // First in your doc
      var me = await firestoreManager.getPerson(auth.currentUser!.uid);
      var person = await firestoreManager.getPerson(personUid);

      person = person
          .copyWith(numOfFollowers: person.numOfFollowers - 1)
          .fromDomain();
      me = me.copyWith(numOfFollowings: me.numOfFollowings - 1).fromDomain();

      final yourDocRef = firebaseFirestore
          .collection(FirestoreCollections.persons)
          .doc(auth.currentUser?.uid);

      await yourDocRef
          .collection(FirestoreCollections.followings)
          .doc(person.personInfo.uid)
          .delete();

      await yourDocRef.update({'numOfFollowings': me.numOfFollowings});
      // Second in the person which you following doc
      final hisDocRef = firebaseFirestore
          .collection(FirestoreCollections.persons)
          .doc(person.personInfo.uid);

      await hisDocRef
          .collection(FirestoreCollections.followers)
          .doc(auth.currentUser?.uid)
          .delete();

      await hisDocRef.update({'numOfFollowers': person.numOfFollowers});

      return person.personInfo.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateProfile(PersonInfo params) async {
    try {
      String? imageUrl;
      await storage
          .ref()
          .child('profile/images/${params.uid}/${DateTime.now().toLocal()}.jpg')
          .putFile(File(params.localImagePath))
          .then(
            (value) async => imageUrl = await value.ref.getDownloadURL(),
          );

      final personInfo = params.copyWith(imageUrl: imageUrl);

      firebaseFirestore
          .collection(FirestoreCollections.persons)
          .doc(auth.currentUser?.uid)
          .update({'personInfo': personInfo.fromDomain().toMap()});
      return personInfo.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut().then((_) => AppBoxes.personBox.clear());
  }
}
