part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeStoriesLoading extends HomeState {}

class HomeStoriesLoadingSuccess extends HomeState {
  final List<Stories> stories;

  const HomeStoriesLoadingSuccess(this.stories);

  @override
  List<Object> get props => [stories];
}

class HomeStoriesLoadingFailed extends HomeState {
  final String message;

  const HomeStoriesLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class HomePostsLoading extends HomeState {}

class HomePostsLoadingSuccess extends HomeState {
  final List<Post> posts;

  const HomePostsLoadingSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class HomePostsLoadingFailed extends HomeState {
  final String message;

  const HomePostsLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class ScreenModuleChanged extends HomeState {
  final int index;
  const ScreenModuleChanged(this.index);

  @override
  List<Object> get props => [index];
}
