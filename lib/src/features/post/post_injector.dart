import 'domain/usecases/get_post_usecase.dart';

import 'domain/usecases/add_comment_usecase.dart';
import 'domain/usecases/add_reply_usecase.dart';
import 'domain/usecases/delete_post_usecase.dart';
import 'domain/usecases/edit_post_usecase.dart';
import 'domain/usecases/get_followings_usecase.dart';
import 'domain/usecases/send_like_for_comment_usecase.dart';
import 'domain/usecases/send_like_for_reply_usecase.dart';
import 'domain/usecases/send_like_usecase.dart';

import '../../config/container_injector.dart';
import 'data/datasources/base_remote_post_datasource.dart';
import 'data/datasources/remote_post_datasource.dart';
import 'data/repositories/post_repo.dart';
import 'domain/repositories/base_post_repo.dart';
import 'domain/usecases/add_post_usecase.dart';
import 'presentation/bloc/post_bloc.dart';

void initPost() {
  // add post data source
  sl.registerLazySingleton<BaseRemotePostDatasource>(
    () => RemotePostDatasource(
      auth: sl(),
      firestore: sl(),
      storage: sl(),
      firestoreManager: sl(),
    ),
  );

  // add post repo
  sl.registerLazySingleton<BasePostRepo>(() => PostRepo(sl()));

  // add post use cases
  sl.registerLazySingleton<AddPostUseCase>(() => AddPostUseCase(sl()));
  sl.registerLazySingleton<GetFollowingsUseCase>(
      () => GetFollowingsUseCase(sl()));
  sl.registerLazySingleton<SendLikeUseCase>(() => SendLikeUseCase(sl()));
  sl.registerLazySingleton<AddCommentUseCase>(() => AddCommentUseCase(sl()));
  sl.registerLazySingleton<AddReplyUseCase>(() => AddReplyUseCase(sl()));
  sl.registerLazySingleton<SendLikeForCommentUseCase>(
      () => SendLikeForCommentUseCase(sl()));
  sl.registerLazySingleton<SendLikeForReplyUseCase>(
      () => SendLikeForReplyUseCase(sl()));
  sl.registerLazySingleton<GetPostUseCase>(() => GetPostUseCase(sl()));
  sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton<EditPostUseCase>(() => EditPostUseCase(sl()));

  // add post bloc
  sl.registerFactory(() => PostBloc(
        addPostUsecase: sl(),
        getFollowingsUsecase: sl(),
        sendLikeUseCase: sl(),
        addCommentUseCase: sl(),
        addReplyUseCase: sl(),
        sendLikeForCommentUseCase: sl(),
        getPostUsecase: sl(),
        sendLikeForReplyUseCase: sl(),
        deletePostUsecase: sl(),
        editPostUsecase: sl(),
      ));
}
