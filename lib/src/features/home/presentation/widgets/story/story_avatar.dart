import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_size.dart';

class StoryAvatar extends StatelessWidget {
  final String imageUrl;
  const StoryAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s70,
      height: AppSize.s70,
      padding: const EdgeInsets.all(AppSize.s3),
      margin: const EdgeInsets.only(right: AppSize.s10),
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
