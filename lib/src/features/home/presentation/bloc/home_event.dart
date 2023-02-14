part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadStories extends HomeEvent {}

class HomeLoadPosts extends HomeEvent {}

class ChangeScreenModule extends HomeEvent {
  final int index;

  const ChangeScreenModule(this.index);
}
