part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchPosts extends SearchEvent {}

class Search extends SearchEvent {
  final String name;

  const Search(this.name);
}
