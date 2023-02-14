import '../../config/container_injector.dart';
import 'data/datasources/remote/base_remote_story_datasource.dart';
import 'data/datasources/remote/remote_story_datasource.dart';
import 'data/repositories/story_repo.dart';
import 'domain/repositories/base_story_repo.dart';
import 'domain/usecases/upload_story_usecase.dart';
import 'domain/usecases/view_story_usecase.dart';
import 'presentation/bloc/story_bloc.dart';

void initStory() {
  // add story data source
  sl.registerLazySingleton<BaseRemoteStoryDatasource>(
    () => RemoteStoryDataSource(
      auth: sl(),
      firestore: sl(),
      storage: sl(),
      firestoreManager: sl(),
    ),
  );

  // add story repo
  sl.registerLazySingleton<BaseStoryRepo>(
    () => StoryRepo(baseRemoteStoryDatasource: sl(), connectivity: sl()),
  );

  // add upload story use case
  sl.registerLazySingleton(() => UploadStoryUseCase(sl()));
  sl.registerLazySingleton(() => ViewStoryUseCase(sl()));

  // add story bloc
  sl.registerFactory(() => StoryBloc(
        uploadStoryUseCase: sl(),
        viewStoryUseCase: sl(),
      ));
}
