import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/entities/story/stories.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../domain/usecases/load_posts_usecase.dart';
import '../../domain/usecases/load_stories_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadStoriesUseCase loadStoriesUsecase;
  final LoadPostsUseCase loadPostsUsecase;
  HomeBloc({required this.loadStoriesUsecase, required this.loadPostsUsecase})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoadStories) {
        await _loadStories(event, emit);
      }
      if (event is HomeLoadPosts) {
        await _loadPosts(event, emit);
      }
      if (event is ChangeScreenModule) {
        _changeScreenModule(event, emit);
      }
    });
  }

  List<Stories> _stories = [];
  List<Stories> get stories => _stories;

  Future<void> _loadStories(
      HomeLoadStories event, Emitter<HomeState> emit) async {
    emit(HomeStoriesLoading());
    final result = await loadStoriesUsecase(NoParams());
    result.fold(
      (failure) => emit(HomeStoriesLoadingFailed(failure.message)),
      (data) {
        _stories = data;
        emit(HomeStoriesLoadingSuccess(data));
      },
    );
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> _loadPosts(
    HomeLoadPosts event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomePostsLoading());
    final result = await loadPostsUsecase(NoParams());
    result.fold(
      (failure) => emit(HomePostsLoadingFailed(failure.message)),
      (data) {
        _posts = data;
        _posts.sort(
          (a, b) {
            final aTime = DateTime.parse(a.postDate);
            final bTime = DateTime.parse(b.postDate);
            return bTime.compareTo(aTime);
          },
        );
        emit(HomePostsLoadingSuccess(_posts));
      },
    );
  }

  void _changeScreenModule(ChangeScreenModule event, Emitter<HomeState> emit) {
    emit(ScreenModuleChanged(event.index));
  }
}
