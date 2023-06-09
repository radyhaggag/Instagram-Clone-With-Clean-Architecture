import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../bloc/story_bloc.dart';
import 'add_text_to_story.dart';

class ViewStoryImage extends StatefulWidget {
  final StoryBloc storyBloc;
  const ViewStoryImage({super.key, required this.storyBloc});

  @override
  State<ViewStoryImage> createState() => _ViewStoryImageState();
}

class _ViewStoryImageState extends State<ViewStoryImage> {
  late final TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  bool withText = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          File(widget.storyBloc.imagePath!),
          width: context.width,
          height: context.height,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.text_increase_outlined, size: AppSize.s30),
              color: AppColors.white,
              onPressed: () => setState(() => withText = !withText),
            ),
            IconButton(
              icon: const Icon(Icons.text_fields_rounded, size: AppSize.s30),
              color: AppColors.white,
              onPressed: () {
                widget.storyBloc.add(const StoryReplaceToText());
              },
            ),
          ],
        ),
        if (withText) AddTextToStory(storyBloc: widget.storyBloc),
      ],
    );
  }
}
