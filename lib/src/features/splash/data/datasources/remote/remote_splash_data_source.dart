import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/firebase/firestore_manager.dart';
import '../../../../../core/models/person/person_model.dart';
import 'base_remote_splash_data_source.dart';

class RemoteSplashDataSource implements BaseRemoteSplashDataSource {
  final FirebaseAuth firebaseAuth;
  final FirestoreManager firestoreManager;

  RemoteSplashDataSource({
    required this.firebaseAuth,
    required this.firestoreManager,
  });

  @override
  Future<PersonModel?> getCurrentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        final personModel = await firestoreManager.getPerson(currentUser.uid);
        return personModel;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
