import 'package:flutter/material.dart';
import '../../../../config/app_route.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/image_builder.dart';

class StoryHeader extends StatelessWidget {
  final PersonInfo publisher;
  final String storyDate;
  const StoryHeader(
      {super.key, required this.publisher, required this.storyDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.s10),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.s10,
                  horizontal: AppSize.s10,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          Routes.profileScreen,
                          arguments: publisher,
                        );
                      },
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(AppSize.s20),
                          child: ImageBuilder(
                            imageUrl: publisher.imageUrl,
                            imagePath: publisher.localImagePath,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ViewPublisherNameWidget(
                          personInfo: publisher,
                          name: publisher.name,
                          textColor: AppColors.white,
                          addPadding: false,
                        ),
                        Text(
                          getLongestSuitableDate(DateTime.parse(storyDate)),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(AppSize.s10),
            alignment: Alignment.topRight,
            child: const CircleAvatar(
              backgroundColor: AppColors.blackWith40Opacity,
              child: CloseButton(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
