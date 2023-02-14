import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/token_model.dart';

import '../models/person/person_model.dart';
import '../utils/app_strings.dart';
import 'firestore_collections.dart';

const String defaultPicturePath = 'images/default_profile_image.png';

class FirestoreManager {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirestoreManager({required this.firestore, required this.storage});

  Future<String> addPerson(PersonModel personModel) async {
    await firestore
        .collection(FirestoreCollections.persons)
        .doc(personModel.personInfo.uid)
        .set(personModel.toMap());
    return AppStrings.userCreatedSuccessfully;
  }

  Future<PersonModel> getPerson(String uid) async {
    final doc =
        await firestore.collection(FirestoreCollections.persons).doc(uid).get();
    return PersonModel.fromMap(doc.data()!);
  }

  Future<bool> checkIfPersonExist(String uid) async {
    final person =
        await firestore.collection(FirestoreCollections.persons).doc(uid).get();
    return person.exists;
  }

  Future<void> updateUserUsername({
    required String uid,
    required String username,
  }) async {
    await firestore.collection(FirestoreCollections.persons).doc(uid).set({
      'username': username,
    });
  }

  Future<void> updateUserBirthday({
    required String uid,
    required String birthday,
  }) async {
    await firestore.collection(FirestoreCollections.persons).doc(uid).set({
      'birthday': birthday,
    });
  }

  Future<void> updateUserProfileImage({
    required String uid,
    required String imageUrl,
  }) async {
    await firestore.collection(FirestoreCollections.persons).doc(uid).set({
      'imageUrl': imageUrl,
    });
  }

  Future<String> getDefaultImage() async {
    Reference ref = storage.ref().child(defaultPicturePath);
    return await ref.getDownloadURL();
  }

  Future<List<String>> getFollowingsUid(String uid) async {
    List<String> followingsUid = [];
    final result = await firestore
        .collection(FirestoreCollections.persons)
        .doc(uid)
        .collection(FirestoreCollections.followings)
        .get();

    followingsUid = result.docs
        .map((e) => PersonModel.fromMap(e.data()).personInfo.uid)
        .toList();

    return followingsUid;
  }

  Future<List<String>> getFollowersUid(String uid) async {
    List<String> followersUid = [];
    final result = await firestore
        .collection(FirestoreCollections.persons)
        .doc(uid)
        .collection(FirestoreCollections.followers)
        .get();

    followersUid = result.docs
        .map((e) => PersonModel.fromMap(e.data()).personInfo.uid)
        .toList();

    return followersUid;
  }

  Future<List<PersonModel>> getFollowings(String uid) async {
    List<PersonModel> followings = [];
    final result = await firestore
        .collection(FirestoreCollections.persons)
        .doc(uid)
        .collection(FirestoreCollections.followings)
        .get();

    followings = result.docs.map((e) => PersonModel.fromMap(e.data())).toList();
    return followings;
  }

  Future<List<PersonModel>> getFollowers(String uid) async {
    List<PersonModel> followers = [];
    final result = await firestore
        .collection(FirestoreCollections.persons)
        .doc(uid)
        .collection(FirestoreCollections.followers)
        .get();

    followers = result.docs.map((e) => PersonModel.fromMap(e.data())).toList();
    return followers;
  }

  Future<void> addToken(String uid, String token) async {
    final tokensRef = firestore.collection(FirestoreCollections.tokens);
    final tokenDoc = await tokensRef.doc(uid).get();
    if (tokenDoc.exists) {
      await tokensRef.doc(uid).update({'deviceToken': token});
    } else {
      TokenModel tokenModel = TokenModel(uid: uid, deviceToken: token);
      await tokensRef.doc(uid).set(tokenModel.toMap());
    }
  }
}
