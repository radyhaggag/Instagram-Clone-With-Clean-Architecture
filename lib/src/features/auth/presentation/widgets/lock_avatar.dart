import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class LockAvatar extends StatelessWidget {
  const LockAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: AppSize.s2,
          color: AppColors.black,
        ),
      ),
      child: Image.asset(
        AppImages.lock,
        width: AppSize.s80,
        height: AppSize.s80,
      ),
    );
  }
}
