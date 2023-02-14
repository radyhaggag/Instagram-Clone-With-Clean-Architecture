import 'package:flutter/material.dart';
import '../../../../core/media_query.dart';

import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../../../../core/widgets/posts_grid_view_builder.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s10),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Column(
                children: const [
                  CircleShimmer(radius: AppSize.s40),
                  SizedBox(height: AppSize.s10),
                  LightShimmer(
                    height: AppSize.s15,
                    width: AppSize.s100,
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => Column(
                      children: const [
                        LightShimmer(
                          height: AppSize.s15,
                          width: AppSize.s30,
                        ),
                        SizedBox(height: AppSize.s10),
                        LightShimmer(
                          height: AppSize.s15,
                          width: AppSize.s60,
                        ),
                      ],
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          LightShimmer(
            width: context.width,
            height: AppSize.s30,
          ),
          const SizedBox(height: AppSize.s20),
          Row(
            children: const [
              Expanded(child: LightShimmer(height: AppSize.s30)),
              SizedBox(width: AppSize.s10),
              Expanded(child: LightShimmer(height: AppSize.s30)),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          const PostsShimmerBuilder(postsCount: 9),
        ],
      ),
    );
  }
}
