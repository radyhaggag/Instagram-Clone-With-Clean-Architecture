import 'package:flutter/material.dart';
import '../../config/app_route.dart';
import '../domain/entities/person/person_info.dart';

import '../utils/app_size.dart';
import 'image_builder.dart';

class CircleImageAvatar extends StatelessWidget {
  final double? radius;
  final bool? enableNavigate;
  const CircleImageAvatar({
    super.key,
    required this.personInfo,
    this.radius,
    this.enableNavigate,
  });

  final PersonInfo personInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enableNavigate != null && !enableNavigate!
          ? null
          : () {
              Navigator.of(context).pushNamed(
                Routes.profileScreen,
                arguments: personInfo,
              );
            },
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(radius ?? AppSize.s20),
          child: ImageBuilder(
            imageUrl: personInfo.imageUrl,
            imagePath: personInfo.localImagePath,
          ),
        ),
      ),
    );
  }
}
