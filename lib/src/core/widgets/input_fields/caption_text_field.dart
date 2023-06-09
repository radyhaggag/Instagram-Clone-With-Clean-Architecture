import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';

class CaptionTextField extends StatelessWidget {
  const CaptionTextField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLines: 3,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: AppStrings.writeCaption,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.blackWith40Opacity,
            ),
      ),
    );
  }
}
