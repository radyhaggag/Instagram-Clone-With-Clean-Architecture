import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/login_with_facebook_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase signupUsecase;
  final LoginUseCase loginUsecase;
  final LoginWithFacebookUseCase loginWithFacebookUseCase;
  final ResetPasswordUseCase resetPasswordUsecase;

  AuthBloc({
    required this.signupUsecase,
    required this.loginUsecase,
    required this.loginWithFacebookUseCase,
    required this.resetPasswordUsecase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthSignupUser) {
        await _signup(event, emit);
      }

      if (event is AuthLoginUser) {
        await _login(event, emit);
      }
      if (event is AuthLoginUserWithFacebook) {
        await _loginWithFacebook(event, emit);
      }
      if (event is AuthLoginResetUserPassword) {
        await _resetPassword(event, emit);
      }
    });
  }

  Future<void> _signup(AuthSignupUser event, Emitter<AuthState> emit) async {
    emit(const AuthSignupLoading());
    final result = await signupUsecase(event.signupParams);
    result.fold(
      (failure) => emit(AuthSignupError(failure.message)),
      (success) => emit(AuthSignupSuccess(success)),
    );
  }

  Future<void> _login(AuthLoginUser event, Emitter<AuthState> emit) async {
    emit(const AuthLoginLoading());
    final result = await loginUsecase(event.loginParams);
    result.fold(
      (failure) => emit(AuthLoginError(failure.message)),
      (success) => emit(AuthLoginSuccess(success)),
    );
  }

  Future<void> _loginWithFacebook(
      AuthLoginUserWithFacebook event, Emitter<AuthState> emit) async {
    emit(const AuthLoginLoading());
    final result = await loginWithFacebookUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthLoginError(failure.message)),
      (success) => emit(AuthLoginSuccess(success)),
    );
  }

  Future<void> _resetPassword(
      AuthLoginResetUserPassword event, Emitter<AuthState> emit) async {
    emit(const LoginResetPasswordLoading());
    final result = await resetPasswordUsecase(event.email);
    result.fold(
      (failure) => emit(LoginResetPasswordError(failure.message)),
      (success) {
        final String message =
            "${AppStrings.emailRecoveryMessage} ${event.email}";
        emit(LoginResetPasswordSuccess(message));
      },
    );
  }
}
