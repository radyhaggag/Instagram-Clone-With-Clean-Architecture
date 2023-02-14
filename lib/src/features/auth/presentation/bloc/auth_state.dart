part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSignupLoading extends AuthState {
  const AuthSignupLoading();

  @override
  List<Object?> get props => [];
}

class AuthSignupSuccess extends AuthState {
  final Person person;

  const AuthSignupSuccess(this.person);

  @override
  List<Object?> get props => [person];
}

class AuthSignupError extends AuthState {
  final String message;

  const AuthSignupError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoginLoading extends AuthState {
  const AuthLoginLoading();

  @override
  List<Object?> get props => [];
}

class AuthLoginSuccess extends AuthState {
  final Person user;

  const AuthLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthLoginError extends AuthState {
  final String message;

  const AuthLoginError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginResetPasswordLoading extends AuthState {
  const LoginResetPasswordLoading();

  @override
  List<Object?> get props => [];
}

class LoginResetPasswordSuccess extends AuthState {
  final String message;

  const LoginResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginResetPasswordError extends AuthState {
  final String message;

  const LoginResetPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
