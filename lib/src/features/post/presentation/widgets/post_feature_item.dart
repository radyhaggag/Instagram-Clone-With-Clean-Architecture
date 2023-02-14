import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class PostFeatureItem extends StatelessWidget {
  final String title;
  final String? route;
  const PostFeatureItem({super.key, required this.title, this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (route != null) Navigator.of(context).pushNamed(route!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s15,
          vertical: AppSize.s10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSize.s20,
              color: AppColors.blackWith40Opacity,
            ),
          ],
        ),
      ),
    );
  }
}
