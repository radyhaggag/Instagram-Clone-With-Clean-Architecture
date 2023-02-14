import 'presentation/bloc/splash_bloc.dart';
import '../../config/container_injector.dart';
import 'data/datasources/local/base_local_splash_data_source.dart';
import 'data/datasources/local/local_splash_data_source.dart';
import 'data/datasources/remote/base_remote_splash_data_source.dart';
import 'data/datasources/remote/remote_splash_data_source.dart';
import 'data/repositories/splash_repository.dart';
import 'domain/repositories/base_splash_repository.dart';
import 'domain/usecases/splash_get_current_user_usecase.dart';

void initSplash() {
  // add remote data source
  sl.registerLazySingleton<BaseRemoteSplashDataSource>(
    () => RemoteSplashDataSource(firebaseAuth: sl(), firestoreManager: sl()),
  );
  // add local data source
  sl.registerLazySingleton<BaseLocalSplashDataSource>(
    () => LocalSplashDataSource(),
  );

  // add splash repo source
  sl.registerLazySingleton<BaseSplashRepository>(
    () => SplashRepository(
      baseLocalSplashDataSource: sl(),
      baseRemoteSplashDataSource: sl(),
      checkInternetConnectivity: sl(),
    ),
  );
  // add splash usecase source
  sl.registerLazySingleton<SplashGetCurrentUserUseCase>(
    () => SplashGetCurrentUserUseCase(baseSplashRepository: sl()),
  );
  // add splash bloc source
  sl.registerFactory<SplashBloc>(
    () => SplashBloc(splashGetCurrentUserUseCase: sl()),
  );
}
