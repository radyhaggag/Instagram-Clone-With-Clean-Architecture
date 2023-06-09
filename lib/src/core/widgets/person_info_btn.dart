import 'package:flutter/material.dart';
import 'view_publisher_name_widget.dart';

import '../../config/app_route.dart';
import '../domain/entities/person/person_info.dart';
import '../utils/app_size.dart';
import 'image_builder.dart';

class PersonInfoBtn extends StatelessWidget {
  const PersonInfoBtn({
    super.key,
    required this.personInfo,
  });
  final PersonInfo personInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.profileScreen,
          arguments: personInfo,
        );
      },
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(AppSize.s20),
              child: ImageBuilder(
                imageUrl: personInfo.imageUrl,
                imagePath: personInfo.localImagePath,
              ),
            ),
          ),
          const SizedBox(width: AppSize.s20),
          ViewPublisherNameWidget(
            personInfo: personInfo,
            name: personInfo.name,
            disableNavigate: true,
          ),
        ],
      ),
    );
  }
}
