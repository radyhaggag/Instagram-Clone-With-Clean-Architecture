import 'package:flutter/widgets.dart';

import 'utils/app_fonts.dart';

class AppTextStyles {
  static TextStyle _setStyle({
    Color? color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  static TextStyle lightStyle({Color? color}) {
    return _setStyle(
      color: color,
      fontSize: FontSize.light,
      fontWeight: FontThickness.light,
    );
  }

  static TextStyle regularStyle({Color? color}) {
    return _setStyle(
      color: color,
      fontSize: FontSize.details,
      fontWeight: FontThickness.regular,
    );
  }

  static TextStyle mediumStyle({Color? color}) {
    return _setStyle(
      color: color,
      fontSize: FontSize.body,
      fontWeight: FontThickness.medium,
    );
  }

  static TextStyle semiBoldStyle({Color? color}) {
    return _setStyle(
      color: color,
      fontSize: FontSize.subTitle,
      fontWeight: FontThickness.semiBold,
    );
  }

  static TextStyle boldStyle({Color? color}) {
    return _setStyle(
      color: color,
      fontSize: FontSize.subTitle,
      fontWeight: FontThickness.black,
    );
  }

  static TextStyle blackStyle({Color? color}) {
    return _setStyle(
      color: color,
      fontSize: FontSize.title,
      fontWeight: FontThickness.black,
    );
  }
}
