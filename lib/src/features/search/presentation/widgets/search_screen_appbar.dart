import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/utils/app_size.dart';
import '../bloc/search_bloc.dart';

class SearchScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        onChanged: (value) {
          context.read<SearchBloc>().add(Search(value));
        },
        decoration: const InputDecoration(
          hintText: AppStrings.searchAboutSomeone,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s44);
}
