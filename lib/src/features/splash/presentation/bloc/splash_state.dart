part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashGetUserSuccessfully extends SplashState {
  final Person? person;

  const SplashGetUserSuccessfully(this.person);
}

class SplashGetUserFailed extends SplashState {}
