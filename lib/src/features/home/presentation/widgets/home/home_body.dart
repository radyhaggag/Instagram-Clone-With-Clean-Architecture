import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../story/presentation/bloc/story_bloc.dart';
import '../../../../../core/domain/entities/person/person.dart';
import '../../../../post/presentation/bloc/post_bloc.dart';
import '../post/posts_builder.dart';
import '../../../../../core/utils/app_size.dart';
import '../../bloc/home_bloc.dart';
import '../story/stories_builder.dart';

class HomeBody extends StatelessWidget {
  final Person person;
  const HomeBody({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostUploadingSuccess) {
              context.read<HomeBloc>().add(HomeLoadPosts());
            }
          },
        ),
        BlocListener<StoryBloc, StoryState>(
          listener: (context, state) {
            if (state is StoryUploadingSuccess) {
              context.read<HomeBloc>().add(HomeLoadStories());
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.s10,
          horizontal: AppSize.s10,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeLoadStories());
            context.read<HomeBloc>().add(HomeLoadPosts());
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: StoriesBuilder(person: person),
              ),
              const Divider(height: AppSize.s30),
              PostsBuilder(currentPersonInfo: person.personInfo),
            ],
          ),
        ),
      ),
    );
  }
}
