import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

class OrSeparator extends StatelessWidget {
  const OrSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: AppColors.black.withOpacity(.2),
            height: AppSize.s1,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSize.s30),
          child: Text(
            AppStrings.or,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.blackWith40Opacity,
                  fontSize: FontSize.light,
                ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.black.withOpacity(.2),
            height: AppSize.s1,
          ),
        ),
      ],
    );
  }
}
