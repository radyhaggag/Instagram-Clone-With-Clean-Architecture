import 'package:flutter/material.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_size.dart';

class PostItemBtn extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const PostItemBtn({super.key, this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s10,
          vertical: AppSize.s5,
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontThickness.bold),
        ),
      ),
    );
  }
}
