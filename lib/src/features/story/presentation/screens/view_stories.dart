import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/widgets/person_info_btn.dart';

import '../../../../core/domain/entities/story/story.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../bloc/story_bloc.dart';
import '../widgets/story_header.dart';
import '../widgets/story_progress_bar.dart';
import '../widgets/story_text_view.dart';

class ViewStories extends StatefulWidget {
  const ViewStories({super.key, required this.screenArgs});

  final ViewStoriesScreenArgs screenArgs;

  @override
  State<ViewStories> createState() => _ViewStoriesState();
}

class _ViewStoriesState extends State<ViewStories> {
  int arrangement = 0;
  int currentIndex = 0;
  int progressPercent = 1;
  late Story story;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    arrangement = widget.screenArgs.arrangement;
    story = widget.screenArgs.stories[arrangement].stories.first;
    context.read<StoryBloc>().add(GetNextStory(
          storyIndex: currentIndex,
          arrangementBetweenStories: arrangement,
          stories: widget.screenArgs.stories,
        ));
    runTimer();
  }

  void runTimer() {
    if (arrangement >= widget.screenArgs.stories.length) {
      Navigator.pop(context);
    }
    timer?.cancel();
    if (progressPercent == AppConstants.storyTime) progressPercent = 0;
    final storyBloc = context.read<StoryBloc>();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (progressPercent == AppConstants.storyTime) {
        if (arrangement == widget.screenArgs.stories.length - 1 &&
            currentIndex ==
                widget.screenArgs.stories[arrangement].stories.length - 1) {
          timer.cancel();
          Navigator.pop(context);
          return;
        }
        if (arrangement < widget.screenArgs.stories.length - 1 &&
            currentIndex ==
                widget.screenArgs.stories[arrangement].stories.length - 1) {
          currentIndex = 0;
          arrangement++;
          if (widget.screenArgs.stories[arrangement].stories.isNotEmpty) {
            storyBloc.add(GetNextStory(
              storyIndex: currentIndex,
              arrangementBetweenStories: arrangement,
              stories: widget.screenArgs.stories,
            ));
          } else {
            Navigator.pop(context);
          }
        }
        if (arrangement < widget.screenArgs.stories.length &&
            currentIndex <
                widget.screenArgs.stories[arrangement].stories.length) {
          storyBloc.add(GetNextStory(
            storyIndex: ++currentIndex,
            arrangementBetweenStories: arrangement,
            stories: widget.screenArgs.stories,
          ));
        }
        runTimer();
      } else {
        if (mounted) {
          progressPercent = progressPercent + 1;
          storyBloc.add(UpdateStoryProgressBar(second: progressPercent));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<StoryBloc, StoryState>(
          listener: (context, state) {
            if (state is NextStoryReady) {
              story = state.story;
            }
          },
          child: PageView.builder(
            onPageChanged: (index) {
              if (arrangement >= widget.screenArgs.stories.length) {
                Navigator.pop(context);
              }
              currentIndex = 0;
              arrangement = index;
              context.read<StoryBloc>().add(GetNextStory(
                    arrangementBetweenStories: arrangement,
                    storyIndex: currentIndex,
                    stories: widget.screenArgs.stories,
                  ));
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () => timer?.cancel(),
                onLongPressUp: () => runTimer(),
                onTap: () {
                  if (arrangement >= widget.screenArgs.stories.length) {
                    Navigator.pop(context);
                  } else if (currentIndex ==
                      widget.screenArgs.stories[arrangement].stories.length -
                          1) {
                    currentIndex = 0;
                    context.read<StoryBloc>().add(
                          GetNextStory(
                            arrangementBetweenStories: ++arrangement,
                            storyIndex: currentIndex,
                            stories: widget.screenArgs.stories,
                          ),
                        );
                    progressPercent = 0;
                    runTimer();
                  } else if (currentIndex <
                      widget.screenArgs.stories[arrangement].stories.length -
                          1) {
                    context.read<StoryBloc>().add(
                          GetNextStory(
                            arrangementBetweenStories: arrangement,
                            storyIndex: ++currentIndex,
                            stories: widget.screenArgs.stories,
                          ),
                        );
                    progressPercent = 0;
                    runTimer();
                  } else {
                    if (arrangement == widget.screenArgs.stories.length - 1 &&
                        currentIndex ==
                            widget.screenArgs.stories[arrangement].stories
                                    .length -
                                1) {
                      timer?.cancel();
                      Navigator.pop(context);
                    }
                  }
                },
                child: Stack(
                  children: [
                    BlocBuilder<StoryBloc, StoryState>(
                      buildWhen: (previous, current) {
                        if (current is NextStoryReady) {
                          story = current.story;
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        if (story.imageUrl != null) {
                          return ImageBuilder(
                            imageUrl: story.imageUrl!,
                            imagePath: story.imageLocalPath!,
                          );
                        } else if (story.videoUrl != null) {
                          return VideoPlayerWidget(
                            videoUrl: story.videoUrl!,
                            videoPath: story.videoLocalPath!,
                            autoPlay: true,
                          );
                        } else {
                          return Container(
                            width: context.width,
                            height: context.height,
                            decoration: BoxDecoration(
                              gradient: AppColors.gradient,
                            ),
                          );
                        }
                      },
                    ),
                    BlocBuilder<StoryBloc, StoryState>(
                      buildWhen: (previous, current) {
                        if (current is StoryProgressBarValue) {
                          progressPercent = current.value;
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        return StoryProgressBar(
                          storiesLength: widget
                              .screenArgs.stories[arrangement].stories.length,
                          currentStoryIndex: currentIndex,
                          progressPercent: progressPercent,
                        );
                      },
                    ),
                    BlocBuilder<StoryBloc, StoryState>(
                      buildWhen: (previous, current) {
                        return current is! StoryProgressBarValue;
                      },
                      builder: (context, state) {
                        return StoryTextView(storyText: story.storyText);
                      },
                    ),
                    BlocBuilder<StoryBloc, StoryState>(
                      buildWhen: (previous, current) {
                        return current is! StoryProgressBarValue;
                      },
                      builder: (context, state) {
                        return StoryHeader(
                          publisher: story.publisher,
                          storyDate: story.storyDate,
                        );
                      },
                    ),
                    if (story.publisher.uid ==
                        FirebaseAuth.instance.currentUser?.uid)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSize.s10),
                          child: CircleAvatar(
                            backgroundColor: AppColors.blackWith40Opacity,
                            radius: AppSize.s30,
                            child: IconButton(
                              onPressed: () {
                                timer?.cancel();
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: context.height / 4,
                                      color: AppColors.light,
                                      padding: const EdgeInsets.only(
                                        top: AppSize.s20,
                                        left: AppSize.s20,
                                        right: AppSize.s20,
                                      ),
                                      child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return PersonInfoBtn(
                                            personInfo: story.viewers[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: AppSize.s10,
                                          );
                                        },
                                        itemCount: story.viewers.length,
                                      ),
                                    );
                                  },
                                ).whenComplete(() => runTimer());
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                size: AppSize.s30,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            itemCount: widget.screenArgs.stories.length,
          ),
        ),
      ),
    );
  }
}
