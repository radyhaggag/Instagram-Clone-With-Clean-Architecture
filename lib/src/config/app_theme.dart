import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/text_styles.dart';
import '../core/utils/app_colors.dart';

getAppTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    textTheme: TextTheme(
      bodySmall: AppTextStyles.lightStyle(color: AppColors.blue),
      bodyMedium: AppTextStyles.regularStyle(color: AppColors.black),
      bodyLarge: AppTextStyles.semiBoldStyle(color: AppColors.white),
      titleMedium: AppTextStyles.mediumStyle(color: AppColors.black),
      titleLarge: AppTextStyles.boldStyle(color: AppColors.black),
      headlineMedium: AppTextStyles.blackStyle(color: AppColors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.light,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.black.withOpacity(.1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.black.withOpacity(.5),
        ),
      ),
      labelStyle:
          AppTextStyles.regularStyle(color: AppColors.blackWith40Opacity),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.blue,
    ),
  );
}
