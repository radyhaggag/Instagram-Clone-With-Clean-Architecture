import '../../config/container_injector.dart';
import 'data/datasources/remote/remote_search_datasource.dart';
import 'data/repositories/search_repo.dart';
import 'domain/usecases/load_search_posts_usecase.dart';
import 'domain/usecases/search_usecase.dart';
import 'presentation/bloc/search_bloc.dart';

import 'data/datasources/local/base_local_search_datasource.dart';
import 'data/datasources/local/local_search_datasource.dart';
import 'data/datasources/remote/base_remote_search_datasource.dart';
import 'domain/repositories/base_search_repo.dart';

void initSearch() {
  // data sources
  sl.registerLazySingleton<BaseRemoteSearchDatasource>(
    () => RemoteSearchDatasource(
      firebaseFirestore: sl(),
      firestoreManager: sl(),
      auth: sl(),
    ),
  );
  sl.registerLazySingleton<BaseLocalSearchDatasource>(
    () => LocalSearchDatasource(),
  );

  // repos
  sl.registerLazySingleton<BaseSearchRepo>(
    () => SearchRepo(
      baseRemoteSearchDatasource: sl(),
      baseLocalSearchDatasource: sl(),
      checkConnection: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton<LoadSearchPostsUseCase>(
    () => LoadSearchPostsUseCase(sl()),
  );
  sl.registerLazySingleton<SearchUseCase>(
    () => SearchUseCase(sl()),
  );

  // bloc
  sl.registerFactory<SearchBloc>(
    () => SearchBloc(
      loadSearchPostsUseCase: sl(),
      searchUseCase: sl(),
    ),
  );
}
