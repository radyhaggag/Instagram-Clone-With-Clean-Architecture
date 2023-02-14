part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchPostsLoading extends SearchState {}

class SearchPostsLoadingSuccess extends SearchState {
  final List<Post> posts;

  const SearchPostsLoadingSuccess(this.posts);
}

class SearchPostsLoadingFailed extends SearchState {
  final String message;

  const SearchPostsLoadingFailed(this.message);
}

class SearchResultsLoading extends SearchState {}

class SearchResultsLoadingSuccess extends SearchState {
  final List<Person> persons;
  final String searchValue;

  const SearchResultsLoadingSuccess({
    required this.persons,
    required this.searchValue,
  });
}

class SearchResultsLoadingFailed extends SearchState {
  final String message;

  const SearchResultsLoadingFailed(this.message);
}
