import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import '../features/chat/chat_injector.dart';

import '../core/firebase/firestore_manager.dart';
import '../core/network/connectivity_checker.dart';
import '../features/auth/auth_injector.dart';
import '../features/home/home_injector.dart';
import '../features/post/post_injector.dart';
import '../features/profile/profile_injector.dart';
import '../features/reels/reels_injector.dart';
import '../features/search/search_injector.dart';
import '../features/shopping/shopping_injector.dart';
import '../features/splash/splash_injector.dart';
import '../features/story/story_injector.dart';

final sl = GetIt.instance;

Future<void> initApp() async {
  _initCore();
  initSplash();
  _initFirebase();
  initAuth();
  initHome();
  initStory();
  initPost();
  initProfile();
  initSearch();
  initReels();
  initShopping();
  initChat();
}

void _initCore() {
  // add connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // add checkInternetConnectivity
  sl.registerLazySingleton<BaseCheckInternetConnectivity>(
    () => CheckInternetConnectivity(connectivity: sl()),
  );
  // add user manager
  sl.registerLazySingleton<FirestoreManager>(
    () => FirestoreManager(firestore: sl(), storage: sl()),
  );
}

void _initFirebase() {
  // add firebase auth instance
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // add firebase firestore instance
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // add firebase firestore instance
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  // add firebase firestore messaging
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
}
