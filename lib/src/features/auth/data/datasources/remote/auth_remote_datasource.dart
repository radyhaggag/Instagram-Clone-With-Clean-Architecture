import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../../../core/utils/app_strings.dart';

import '../../../../../core/cash_manager.dart';
import '../../../../../core/domain/entities/person/person_info.dart';
import '../../../../../core/error/error_codes.dart';
import '../../../../../core/firebase/firestore_manager.dart';
import '../../../../../core/models/person/person_model.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';
import 'base_remote_auth_datasource.dart';

class RemoteAuthDataSource implements BaseRemoteAuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirestoreManager firestoreManager;
  final FirebaseMessaging firebaseMessaging;

  RemoteAuthDataSource({
    required this.firebaseAuth,
    required this.firestoreManager,
    required this.firebaseMessaging,
  });

  @override
  Future<PersonModel> signUp(SignupParams signupParams) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: signupParams.email, password: signupParams.password);
      final uid = userCredential.user!.uid;
      final imageUrl = await firestoreManager.getDefaultImage();
      final imagePath =
          await CashManager.saveFile(imageUrl, signupParams.username);

      PersonModel personModel = PersonModel(
        personInfo: PersonInfo(
          email: signupParams.email,
          name: signupParams.fullName,
          imageUrl: imageUrl,
          uid: uid,
          localImagePath: imagePath,
          username: signupParams.username,
          gender: AppStrings.preferNotSay,
        ),
      );
      userCredential.user?.updateDisplayName(personModel.personInfo.name);
      userCredential.user?.updatePhotoURL(imageUrl);

      String? token = await firebaseMessaging.getToken();
      if (token != null) await firestoreManager.addToken(uid, token);

      await firestoreManager.addPerson(personModel);
      return personModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PersonModel> login(LoginParams loginParams) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: loginParams.email, password: loginParams.password);
      final uid = userCredential.user!.uid;
      final personModel = await firestoreManager.getPerson(uid);
      String? token = await firebaseMessaging.getToken();
      if (token != null) await firestoreManager.addToken(uid, token);
      return personModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PersonModel> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"],
      );

      if (loginResult.accessToken == null) {
        throw FirebaseAuthException(code: ErrorCodes.unexpectedError);
      }
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(facebookAuthCredential);

      String? token = await firebaseMessaging.getToken();
      if (token != null) {
        await firestoreManager.addToken(userCredential.user!.uid, token);
      }

      return await _getFacebookUser(userCredential);
    } catch (e) {
      rethrow;
    }
  }

  Future<PersonModel> _getFacebookUser(UserCredential userCredential) async {
    late final PersonModel personModel;
    final facebookUser = userCredential.user!;
    bool isExist = await firestoreManager.checkIfPersonExist(facebookUser.uid);
    if (isExist) {
      personModel = await firestoreManager.getPerson(facebookUser.uid);
    } else {
      final imageUrl =
          facebookUser.photoURL ?? await firestoreManager.getDefaultImage();
      final imagePath = await CashManager.saveFile(imageUrl, facebookUser.uid);
      personModel = PersonModel(
        personInfo: PersonInfo(
          email: facebookUser.email ?? facebookUser.phoneNumber ?? "",
          name: facebookUser.displayName ?? "",
          imageUrl: imageUrl,
          uid: facebookUser.uid,
          localImagePath: imagePath,
          username: facebookUser.uid,
          isVerified: true,
          gender: AppStrings.preferNotSay,
        ),
      );
      await firestoreManager.addPerson(personModel);
    }
    return personModel;
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
