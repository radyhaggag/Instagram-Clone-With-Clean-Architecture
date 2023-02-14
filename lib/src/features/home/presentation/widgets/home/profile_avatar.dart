import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../config/container_injector.dart';
import '../../../../../core/domain/entities/person/person.dart';
import '../../../../../core/network/connectivity_checker.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_size.dart';
import '../story/add_story_btn.dart';

class ProfileAvatar extends StatelessWidget {
  final Person person;
  final double? width;
  final double? height;
  final bool showAddBtn;
  const ProfileAvatar(
      {super.key,
      this.width,
      this.height,
      required this.showAddBtn,
      required this.person});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl<BaseCheckInternetConnectivity>().isConnected(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return _buildImage(NetworkImage(person.personInfo.imageUrl));
        } else {
          File file = File(person.personInfo.localImagePath);
          bool isExist = file.existsSync();
          if (isExist) {
            return _buildImage(FileImage(file));
          } else {
            return _buildImage(const AssetImage(AppImages.defaultProfileImage));
          }
        }
      },
    );
  }

  Container _buildImage(ImageProvider image) {
    return Container(
      height: height ?? AppSize.s70,
      width: width ?? AppSize.s70,
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
      child: showAddBtn ? const AddStoryBtn() : null,
    );
  }
}
