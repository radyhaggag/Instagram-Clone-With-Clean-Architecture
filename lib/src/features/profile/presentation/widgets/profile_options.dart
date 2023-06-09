import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import 'follow_button.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/utils/app_size.dart';
import '../bloc/profile_bloc.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({
    Key? key,
    required this.person,
    required this.yourFollowings,
  }) : super(key: key);

  final Person person;
  final List yourFollowings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (FirebaseAuth.instance.currentUser?.uid == person.personInfo.uid)
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                final res = await Navigator.of(context).pushNamed(
                  Routes.editProfile,
                  arguments: person,
                );
                if (res == 'closed' && context.mounted) {
                  context.read<ProfileBloc>().add(
                        GetProfile(person.personInfo.uid),
                      );
                }
              },
              style: getButtonStyle(context, AppColors.light),
              child: const Text(AppStrings.editProfile),
            ),
          ),
        if (FirebaseAuth.instance.currentUser?.uid != person.personInfo.uid)
          Expanded(
            child: FollowButton(
                yourFollowings: yourFollowings,
                personUid: person.personInfo.uid),
          ),
        const SizedBox(width: AppSize.s10),
        (FirebaseAuth.instance.currentUser?.uid != person.personInfo.uid)
            ? Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Routes.chatWithScreen,
                      arguments: person.personInfo,
                    );
                  },
                  style: getButtonStyle(context, AppColors.blue),
                  child: const Text(AppStrings.message),
                ),
              )
            : Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: getButtonStyle(context, AppColors.light),
                  child: const Text(AppStrings.shareProfile),
                ),
              ),
      ],
    );
  }
}

ButtonStyle? getButtonStyle(context, Color color) => ElevatedButton.styleFrom(
      backgroundColor: color,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      foregroundColor: AppColors.black,
      elevation: 0.2,
    );

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.label,
    required this.number,
    this.onTap,
  });

  final void Function()? onTap;
  final String label;
  final int number;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            number.toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class BioWidget extends StatelessWidget {
  const BioWidget({super.key, this.bio});

  final String? bio;

  @override
  Widget build(BuildContext context) {
    if (bio != null && bio!.isNotEmpty) {
      return Text.rich(
        TextSpan(text: bio),
        style: Theme.of(context).textTheme.titleMedium,
      );
    } else {
      return const SizedBox();
    }
  }
}
