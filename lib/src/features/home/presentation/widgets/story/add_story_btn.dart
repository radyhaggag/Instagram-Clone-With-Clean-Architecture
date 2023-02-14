import 'package:flutter/material.dart';

import '../../../../../config/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_size.dart';

class AddStoryBtn extends StatelessWidget {
  const AddStoryBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(Routes.addStory),
        child: const CircleAvatar(
          radius: AppSize.s13,
          backgroundColor: AppColors.blue,
          child: Icon(Icons.add, color: AppColors.white, size: AppSize.s20),
        ),
      ),
    );
  }
}
