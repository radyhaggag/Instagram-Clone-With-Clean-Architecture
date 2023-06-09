import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/select_stories_menus.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../bloc/story_bloc.dart';

class StoryOptions extends StatelessWidget {
  final StoryBloc storyBloc;
  const StoryOptions({super.key, required this.storyBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s5),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(AppSize.s5),
            decoration: const BoxDecoration(
              color: AppColors.blackWith40Opacity,
              shape: BoxShape.circle,
            ),
            child: const CloseButton(color: AppColors.white),
          ),
          const SizedBox(height: AppSize.s10),
          OptionBtn(
            icon: Icons.perm_media_rounded,
            onTap: () => selectFromGallery(context),
          ),
          const SizedBox(height: AppSize.s10),
          OptionBtn(
            icon: Icons.camera,
            onTap: () => selectFromCamera(context),
          ),
          const SizedBox(height: AppSize.s10),
          if (isReadyToUpload(context.read<StoryBloc>()))
            OptionBtn(
              icon: Icons.upload,
              onTap: () {
                context.read<StoryBloc>().add(const UploadStory());
              },
            ),
        ],
      ),
    );
  }

  bool isReadyToUpload(StoryBloc storyBloc) {
    if (storyBloc.imagePath != null || storyBloc.videoPath != null) {
      return true;
    } else if (storyBloc.storyText != null &&
        storyBloc.storyText!.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

class OptionBtn extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  const OptionBtn({Key? key, this.onTap, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: AppSize.s25,
        backgroundColor: AppColors.blackWith40Opacity,
        child: Icon(icon, size: AppSize.s40, color: AppColors.white),
      ),
    );
  }
}
