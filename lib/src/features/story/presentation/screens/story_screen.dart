import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../bloc/story_bloc.dart';
import '../widgets/add_text_to_story.dart';
import '../widgets/story_options.dart';
import '../widgets/view_story_image.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<StoryBloc, StoryState>(
        listener: (context, state) {
          if (state is StoryUploading) {
            showDialog(
              context: context,
              builder: (context) => const CenterProgressIndicator(),
            );
          }
          if (state is StoryUploadingFailed) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is StoryUploadingSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.storyUploadingSuccessMsg,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SizedBox(
              width: context.width,
              height: context.height,
              child: Stack(
                children: [
                  _buildBody(context),
                  StoryOptions(storyBloc: context.read<StoryBloc>()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final storyBloc = context.read<StoryBloc>();
    if (storyBloc.imagePath != null) {
      return ViewStoryImage(storyBloc: storyBloc);
    } else if (storyBloc.videoPath != null) {
      return VideoPlayerWidget(
        videoPath: storyBloc.videoPath!,
        autoPlay: true,
      );
    } else {
      return Container(
        decoration: BoxDecoration(gradient: AppColors.gradient),
        child: AddTextToStory(storyBloc: storyBloc),
      );
    }
  }
}
