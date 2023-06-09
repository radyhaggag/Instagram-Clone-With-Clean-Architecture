import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get statusBarSize => MediaQuery.of(this).padding.top;
  double get appBarSize => statusBarSize + kToolbarHeight;
  double get mainHeight => height - statusBarSize;
  double get heightOfScreenOnly => height - appBarSize;
}
