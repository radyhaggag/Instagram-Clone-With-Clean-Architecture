import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../domain/usecases/load_search_posts_usecase.dart';
import '../../domain/usecases/search_usecase.dart';

import '../../../../core/domain/entities/post/post.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final LoadSearchPostsUseCase loadSearchPostsUseCase;
  final SearchUseCase searchUseCase;
  SearchBloc({
    required this.loadSearchPostsUseCase,
    required this.searchUseCase,
  }) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is LoadSearchPosts) await _loadSearchPosts(event, emit);
      if (event is Search) await _search(event, emit);
    });
  }

  Future<void> _loadSearchPosts(
    LoadSearchPosts event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchPostsLoading());
    final result = await loadSearchPostsUseCase('');

    result.fold(
      (l) => emit(SearchPostsLoadingFailed(l.message)),
      (posts) {
        posts.sort(
          (a, b) {
            final aTime = DateTime.parse(a.postDate);
            final bTime = DateTime.parse(b.postDate);
            return aTime.compareTo(bTime);
          },
        );

        emit(SearchPostsLoadingSuccess(posts));
      },
    );
  }

  Future<void> _search(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchResultsLoading());
    final result = await searchUseCase(event.name);

    result.fold(
      (l) => emit(SearchResultsLoadingFailed(l.message)),
      (r) => emit(SearchResultsLoadingSuccess(
        persons: r,
        searchValue: event.name,
      )),
    );
  }
}
