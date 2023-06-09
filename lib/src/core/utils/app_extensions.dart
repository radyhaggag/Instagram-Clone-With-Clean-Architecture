import 'package:flutter/material.dart';
import 'app_strings.dart';

import 'app_colors.dart';
import 'app_enums.dart';

extension ToastEnumsExtension on ToastType {
  Color getColor() {
    switch (this) {
      case ToastType.error:
        return AppColors.red;
      case ToastType.success:
        return AppColors.blue;
    }
  }
}

extension GenderExtension on Gender {
  String getValue() {
    switch (this) {
      case Gender.male:
        return AppStrings.male;
      case Gender.female:
        return AppStrings.female;
      case Gender.preferNotSay:
        return AppStrings.preferNotSay;
    }
  }
}
