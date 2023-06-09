import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'my_app.dart';
import 'src/config/container_injector.dart';
import 'src/config/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  await initApp();
  await LocalStorage.init();

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
