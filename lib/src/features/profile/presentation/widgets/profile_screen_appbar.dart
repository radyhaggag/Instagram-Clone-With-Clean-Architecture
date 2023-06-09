import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/person/person_info.dart';

import '../../../../core/utils/app_size.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileScreenAppBar({super.key, required this.personInfo});

  final PersonInfo personInfo;

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s44);

  @override
  Widget build(BuildContext context) {
    if (personInfo.uid == FirebaseAuth.instance.currentUser?.uid) {
      return AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                personInfo.username,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(AppSize.s5),
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(AppSize.s5),
                child: Icon(
                  Icons.menu,
                  size: AppSize.s30,
                ),
              ),
            ),
            InkWell(
              onTap: () => context.read<ProfileBloc>().add(SignOut()),
              child: const Padding(
                padding: EdgeInsets.all(AppSize.s5),
                child: Icon(Icons.logout, size: AppSize.s30),
              ),
            ),
          ],
        ),
      );
    } else {
      return AppBar(
        leading: const BackButton(),
        title: Row(
          children: [
            Text(
              personInfo.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(AppSize.s5),
                child: Icon(
                  Icons.menu,
                  size: AppSize.s30,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
