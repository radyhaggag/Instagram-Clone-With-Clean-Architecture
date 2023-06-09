import '../../config/container_injector.dart';
import 'data/datasources/remote/auth_remote_datasource.dart';
import 'data/datasources/remote/base_remote_auth_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/base_auth_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/login_with_facebook_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/signup_usecase.dart';
import 'presentation/bloc/auth_bloc.dart';

void initAuth() {
  // add remote auth datasource
  sl.registerLazySingleton<BaseRemoteAuthDataSource>(
    () => RemoteAuthDataSource(
      firebaseAuth: sl(),
      firestoreManager: sl(),
      firebaseMessaging: sl(),
    ),
  );
  // add remote auth repository
  sl.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(baseRemoteAuthDataSource: sl()),
  );
  // add remote auth usecases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(baseAuthRepository: sl()),
  );
  sl.registerLazySingleton<SignupUseCase>(
    () => SignupUseCase(baseAuthRepository: sl()),
  );
  sl.registerLazySingleton<LoginWithFacebookUseCase>(
    () => LoginWithFacebookUseCase(baseAuthRepository: sl()),
  );
  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(baseAuthRepository: sl()),
  );
  // add auth bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signupUsecase: sl(),
      loginUsecase: sl(),
      loginWithFacebookUseCase: sl(),
      resetPasswordUsecase: sl(),
    ),
  );
}
