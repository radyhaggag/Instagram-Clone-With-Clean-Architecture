import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class LightShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  const LightShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.black.withOpacity(.1),
      highlightColor: AppColors.black.withOpacity(.13),
      child: Container(
        width: width ?? AppSize.s50,
        height: height ?? AppSize.s10,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.black,
        ),
      ),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  final double radius;
  const CircleShimmer({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.black.withOpacity(.1),
      highlightColor: AppColors.black.withOpacity(.13),
      child: CircleAvatar(radius: radius),
    );
  }
}
