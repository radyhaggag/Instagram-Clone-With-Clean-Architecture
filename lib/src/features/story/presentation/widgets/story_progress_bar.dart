import 'package:flutter/material.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_size.dart';

class StoryProgressBar extends StatelessWidget {
  final int storiesLength;
  final int currentStoryIndex;
  final int progressPercent;
  const StoryProgressBar({
    super.key,
    required this.storiesLength,
    required this.currentStoryIndex,
    required this.progressPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.s10),
      child: Row(
        children: List.generate(
          storiesLength,
          (progIndex) {
            if (progIndex == currentStoryIndex) {
              return StoryProgressItem(
                storiesLength: storiesLength,
                value: progressPercent.toDouble() / AppConstants.storyTime,
              );
            } else if (progIndex < currentStoryIndex) {
              return StoryProgressItem(
                storiesLength: storiesLength,
                value: 1.0,
              );
            } else {
              return StoryProgressItem(
                storiesLength: storiesLength,
                value: 0.0,
              );
            }
          },
        ),
      ),
    );
  }
}

class StoryProgressItem extends StatelessWidget {
  final double value;
  final int storiesLength;
  const StoryProgressItem(
      {super.key, required this.value, required this.storiesLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppSize.s10),
      width: context.width / storiesLength - 20,
      child: LinearProgressIndicator(
        color: AppColors.vividCerise,
        value: value,
      ),
    );
  }
}
