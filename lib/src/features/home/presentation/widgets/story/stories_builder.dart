import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/config/screens_args.dart';
import '../../../../../core/widgets/custom_shimmers.dart';

import '../../../../../config/app_route.dart';
import '../../../../../core/domain/entities/person/person.dart';
import '../../../../../core/functions/build_toast.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_enums.dart';
import '../../../../../core/utils/app_size.dart';
import '../../bloc/home_bloc.dart';
import '../home/profile_avatar.dart';
import 'story_avatar.dart';

class StoriesBuilder extends StatelessWidget {
  const StoriesBuilder({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    bool youHaveStories = false;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomePostsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is HomeStoriesLoadingSuccess) {
          for (var element in state.stories) {
            for (var story in element.stories) {
              if (story.publisher.uid == person.personInfo.uid) {
                youHaveStories = true;
              }
            }
          }
        }
      },
      buildWhen: (previous, current) {
        return current is HomeStoriesLoadingSuccess ||
            current is HomeStoriesLoading;
      },
      builder: (context, state) {
        if (state is HomeStoriesLoading) {
          return SizedBox(
            height: AppSize.s70,
            child: ListView.builder(
              itemBuilder: (context, index) => const CircleShimmer(
                radius: AppSize.s40,
              ),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
        if (context.read<HomeBloc>().stories.isNotEmpty) {
          return SizedBox(
            height: AppSize.s70,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.viewStories,
                      arguments: ViewStoriesScreenArgs(
                        stories: context.read<HomeBloc>().stories,
                        arrangement: 0,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: youHaveStories
                          ? Border.all(color: AppColors.red)
                          : null,
                      shape: BoxShape.circle,
                    ),
                    child: ProfileAvatar(
                      person: person,
                      showAddBtn: true,
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: AppSize.s10,
                    ),
                    itemBuilder: (context, index) {
                      final stories =
                          context.read<HomeBloc>().stories[index].stories;

                      if (stories.isNotEmpty &&
                          stories[index].publisher.uid ==
                              person.personInfo.uid) {
                        return const SizedBox();
                      } else if (stories.isNotEmpty &&
                          stories.first.publisher.uid !=
                              person.personInfo.uid) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Routes.viewStories,
                              arguments: ViewStoriesScreenArgs(
                                stories: context.read<HomeBloc>().stories,
                                arrangement: index,
                              ),
                            );
                          },
                          child: StoryAvatar(
                            imageUrl: stories.first.publisher.imageUrl,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    itemCount: context.read<HomeBloc>().stories.length,
                  ),
                ),
              ],
            ),
          );
        } else {
          return ProfileAvatar(
            person: person,
            showAddBtn: true,
          );
        }
      },
    );
  }
}
