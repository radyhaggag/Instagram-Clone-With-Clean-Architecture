import 'domain/usecases/load_reels_usecase.dart';

import '../../config/container_injector.dart';
import 'data/datasources/base_remote_reels_datasource.dart';
import 'data/datasources/remote_reels_datasource.dart';
import 'data/repositories/reels_repo.dart';
import 'domain/repositories/base_reels_repo.dart';
import 'domain/usecases/add_comment_usecase.dart';
import 'domain/usecases/add_reel_usecase.dart';
import 'domain/usecases/delete_reel_usecase.dart';
import 'domain/usecases/get_reel_usecase.dart';
import 'domain/usecases/send_like_for_comment_usecase.dart';
import 'domain/usecases/send_like_usecase.dart';
import 'presentation/bloc/reels_bloc.dart';

void initReels() {
  // add Reels data source
  sl.registerLazySingleton<BaseRemoteReelsDatasource>(
    () => RemoteReelsDatasource(
      auth: sl(),
      firestore: sl(),
      storage: sl(),
      firestoreManager: sl(),
    ),
  );

  // add Reels repo
  sl.registerLazySingleton<BaseReelsRepo>(() => ReelsRepo(sl()));

  // add Reels use cases
  sl.registerLazySingleton<AddReelUsecase>(() => AddReelUsecase(sl()));
  sl.registerLazySingleton<SendReelLikeUseCase>(
      () => SendReelLikeUseCase(sl()));
  sl.registerLazySingleton<AddReelCommentUseCase>(
      () => AddReelCommentUseCase(sl()));
  sl.registerLazySingleton<SendLikeForReelCommentUseCase>(
      () => SendLikeForReelCommentUseCase(sl()));
  sl.registerLazySingleton<GetReelUseCase>(() => GetReelUseCase(sl()));
  sl.registerLazySingleton<DeleteReelUseCase>(() => DeleteReelUseCase(sl()));
  sl.registerLazySingleton<LoadReelsUseCase>(() => LoadReelsUseCase(sl()));

  // add Reels bloc
  sl.registerFactory(() => ReelsBloc(
        sendLikeUseCase: sl(),
        addCommentUseCase: sl(),
        sendLikeForCommentUseCase: sl(),
        addReelUseCase: sl(),
        deleteReelUseCase: sl(),
        getReelUseCase: sl(),
        loadReelsUseCase: sl(),
      ));
}
