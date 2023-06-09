import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final double? width;
  final double? height;
  final double? radius;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: height ?? AppSize.s50,
      minWidth: width,
      color: AppColors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: radius != null
            ? BorderRadius.circular(radius!)
            : BorderRadius.circular(AppSize.s5),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
