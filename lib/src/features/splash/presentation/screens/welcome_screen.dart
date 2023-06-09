import 'package:flutter/material.dart';

import '../../../../config/app_route.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.mainHeight,
        padding: const EdgeInsets.all(AppSize.s20),
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: AppSize.s80,
              image: AssetImage(AppImages.appName),
            ),
            const SizedBox(height: AppSize.s50),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.signUp);
              },
              radius: AppSize.s5,
              width: context.width,
              label: AppStrings.createNewAccount,
            ),
            const SizedBox(height: AppSize.s10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.login);
              },
              child: const Text(AppStrings.login),
            ),
          ],
        ),
      ),
    );
  }
}
