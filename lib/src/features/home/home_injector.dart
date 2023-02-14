import '../../config/container_injector.dart';
import 'data/datasources/local/base_local_home_datasource.dart';
import 'data/datasources/local/local_home_datasource.dart';
import 'data/datasources/remote/base_remote_home_datasource.dart';
import 'data/datasources/remote/remote_home_datasource.dart';
import 'data/repositories/home_repo.dart';
import 'domain/repositories/base_home_repo.dart';
import 'domain/usecases/load_posts_usecase.dart';
import 'domain/usecases/load_stories_usecase.dart';
import 'presentation/bloc/home_bloc.dart';

initHome() {
  // add home datasource
  sl.registerLazySingleton<BaseRemoteHomeDatasource>(
    () => RemoteHomeDatasource(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
      firestoreManager: sl(),
    ),
  );

  sl.registerLazySingleton<BaseLocalHomeDatasource>(
    () => LocalHomeDatasource(),
  );

  // add home repo
  sl.registerLazySingleton<BaseHomeRepo>(
    () => HomeRepo(
      baseCheckInternetConnectivity: sl(),
      baseRemoteHomeDatasource: sl(),
      baseLocalHomeDatasource: sl(),
    ),
  );

  // add usecases
  sl.registerLazySingleton<LoadStoriesUseCase>(
    () => LoadStoriesUseCase(sl()),
  );
  sl.registerLazySingleton<LoadPostsUseCase>(
    () => LoadPostsUseCase(sl()),
  );

  // add home bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(
        loadStoriesUsecase: sl(),
        loadPostsUsecase: sl(),
      ));
}
