import 'data/datasources/local/local_profile_datasource.dart';
import 'data/datasources/remote/base_remote_profile_datasource.dart';
import 'data/repositories/profile_repo.dart';
import 'domain/repositories/base_profile_repo.dart';
import 'domain/usecases/follow_profile_usecase.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'presentation/bloc/profile_bloc.dart';

import '../../config/container_injector.dart';
import 'data/datasources/local/base_local_profile_datasource.dart';
import 'data/datasources/remote/remote_profile_datasource.dart';
import 'domain/usecases/get_profile_followers_usecase.dart';
import 'domain/usecases/get_profile_followings_usecase.dart';
import 'domain/usecases/un_follow_profile_usecase.dart';

void initProfile() {
  // add profile datasource
  sl.registerLazySingleton<BaseRemoteProfileDatasource>(
    () => RemoteProfileDatasource(
      firebaseFirestore: sl(),
      firestoreManager: sl(),
      auth: sl(),
      storage: sl(),
    ),
  );

  // add profile datasource
  sl.registerLazySingleton<BaseLocalProfileDatasource>(
    () => LocalProfileDatasource(),
  );

  // add profile repo
  sl.registerLazySingleton<BaseProfileRepo>(
    () => ProfileRepo(
      baseCheckInternetConnectivity: sl(),
      baseLocalProfileDatasource: sl(),
      baseRemoteProfileDatasource: sl(),
    ),
  );

  // add usecases
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl()),
  );
  sl.registerLazySingleton<GetProfileFollowingsUseCase>(
    () => GetProfileFollowingsUseCase(sl()),
  );
  sl.registerLazySingleton<GetProfileFollowersUseCase>(
    () => GetProfileFollowersUseCase(sl()),
  );
  sl.registerLazySingleton<FollowProfileUseCase>(
    () => FollowProfileUseCase(sl()),
  );
  sl.registerLazySingleton<UnFollowProfileUseCase>(
    () => UnFollowProfileUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(sl()),
  );

  // add profile bloc
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(
        getProfileUseCase: sl(),
        getProfileFollowersUseCase: sl(),
        getProfileFollowingsUseCase: sl(),
        followProfileUseCase: sl(),
        unFollowProfileUseCase: sl(),
        updateProfileUseCase: sl(),
        signOutUseCase: sl(),
      ));
}
