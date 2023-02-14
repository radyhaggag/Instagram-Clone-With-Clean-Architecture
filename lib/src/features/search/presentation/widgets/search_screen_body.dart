import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../../../../core/widgets/person_info_btn.dart';
import '../../../../core/widgets/posts_grid_view_builder.dart';
import '../bloc/search_bloc.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key, required this.currentPersonInfo});

  final PersonInfo currentPersonInfo;

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(LoadSearchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchResultsLoadingSuccess && state.searchValue.isEmpty) {
          context.read<SearchBloc>().add(LoadSearchPosts());
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s15),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchPostsLoadingSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SearchBloc>().add(LoadSearchPosts());
                },
                child: ListView(
                  children: [
                    PostsGridViewBuilder(
                      posts: state.posts,
                      personInfo: widget.currentPersonInfo,
                    ),
                  ],
                ),
              );
            } else if (state is SearchPostsLoading) {
              return const PostsShimmerBuilder(postsCount: 15);
            } else if (state is SearchPostsLoadingFailed) {
              return CenterMessage(message: state.message);
            } else if (state is SearchResultsLoading) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    children: const [
                      CircleShimmer(radius: AppSize.s25),
                      SizedBox(width: AppSize.s20),
                      LightShimmer(
                        width: AppSize.s100,
                        height: AppSize.s15,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s10,
                ),
                itemCount: 10,
              );
            } else if (state is SearchResultsLoadingSuccess &&
                state.persons.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return PersonInfoBtn(
                    personInfo: state.persons[index].personInfo,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s10,
                ),
                itemCount: state.persons.length,
              );
            } else if (state is SearchResultsLoadingSuccess &&
                state.persons.isEmpty) {
              return const Center(
                child: CenterMessage(message: AppStrings.noResultsFound),
              );
            } else if (state is SearchResultsLoadingFailed) {
              return CenterMessage(message: state.message);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class CenterMessage extends StatelessWidget {
  const CenterMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
