import 'package:flutter/material.dart';
import '../../../../core/media_query.dart';

import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/custom_shimmers.dart';

class ReelShimmer extends StatelessWidget {
  const ReelShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LightShimmer(
          width: context.width,
          height: context.height,
        ),
        const Padding(
          padding: EdgeInsets.all(AppSize.s10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleShimmer(radius: AppSize.s20),
                SizedBox(height: AppSize.s15),
                CircleShimmer(radius: AppSize.s20),
                SizedBox(height: AppSize.s15),
                CircleShimmer(radius: AppSize.s20),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(AppSize.s10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleShimmer(radius: AppSize.s25),
                    SizedBox(width: AppSize.s10),
                    LightShimmer(width: AppSize.s100, height: AppSize.s15),
                  ],
                ),
                SizedBox(height: AppSize.s10),
                LightShimmer(width: AppSize.s200, height: AppSize.s15),
              ],
            ),
          ),
        )
      ],
    );
  }
}
