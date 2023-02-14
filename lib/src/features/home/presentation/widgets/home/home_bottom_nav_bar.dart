import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/entities/person/person.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../bloc/home_bloc.dart';
import 'profile_avatar.dart';

class HomeBottomNavBar extends StatelessWidget {
  final Person person;
  const HomeBottomNavBar({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.black,
          onTap: (index) {
            context.read<HomeBloc>().add(ChangeScreenModule(index));
          },
          items: [
            _bottomNavIcon(AppIcons.home, AppStrings.home),
            _bottomNavIcon(AppIcons.searchOutline, AppStrings.search),
            _bottomNavIcon(AppIcons.videoOutline, AppStrings.reels),
            _bottomNavIcon(AppIcons.shoppingBagOutline, AppStrings.store),
            BottomNavigationBarItem(
              icon: ProfileAvatar(
                person: person,
                showAddBtn: false,
                width: AppSize.s25,
                height: AppSize.s25,
              ),
              label: AppStrings.profile,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavIcon(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(iconPath),
        size: AppSize.s20,
        color: AppColors.black,
      ),
      label: label,
    );
  }
}
