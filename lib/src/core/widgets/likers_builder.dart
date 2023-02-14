import 'package:flutter/material.dart';
import '../media_query.dart';

import '../domain/entities/person/person_info.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import 'person_info_btn.dart';

class LikersBuilder extends StatelessWidget {
  final List<PersonInfo> likers;
  const LikersBuilder({super.key, required this.likers});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: context.height / 2,
      width: context.width - AppSize.s50,
      padding: const EdgeInsets.all(AppSize.s10),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final liker = likers[index];
          return PersonInfoBtn(personInfo: liker);
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: likers.length,
      ),
    );
  }
}
