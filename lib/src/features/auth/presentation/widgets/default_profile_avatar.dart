import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class DefaultProfileAvatar extends StatelessWidget {
  const DefaultProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s30),
      decoration: BoxDecoration(
        color: AppColors.light,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.black,
          width: AppSize.s2,
        ),
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(AppSize.s50), // Image radius
          child: Image.asset(
            AppImages.defaultProfileImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
