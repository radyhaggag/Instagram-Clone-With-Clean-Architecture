part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthSignupUser extends AuthEvent {
  final SignupParams signupParams;

  const AuthSignupUser({required this.signupParams});

  @override
  List<Object> get props => [signupParams];
}

class AuthLoginUser extends AuthEvent {
  final LoginParams loginParams;

  const AuthLoginUser({required this.loginParams});

  @override
  List<Object> get props => [loginParams];
}

class AuthLoginUserWithFacebook extends AuthEvent {
  const AuthLoginUserWithFacebook();

  @override
  List<Object> get props => [];
}

class AuthLoginResetUserPassword extends AuthEvent {
  final String email;

  const AuthLoginResetUserPassword({required this.email});

  @override
  List<Object> get props => [email];
}
