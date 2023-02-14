import 'package:flutter/material.dart';

import '../../../../core/domain/entities/story/story_text.dart';

class StoryTextView extends StatelessWidget {
  final StoryText? storyText;
  const StoryTextView({super.key, required this.storyText});

  @override
  Widget build(BuildContext context) {
    if (storyText != null) {
      return Positioned(
        top: storyText?.dy,
        left: storyText?.dx,
        child: Text(
          storyText!.text,
          style: TextStyle(
            color: Color(
              int.parse(storyText!.color, radix: 16),
            ),
            fontSize: storyText!.fontSize,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
