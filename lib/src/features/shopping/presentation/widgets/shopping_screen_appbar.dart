import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/utils/app_size.dart';

class ShoppingScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ShoppingScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.shopping,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s44);
}
