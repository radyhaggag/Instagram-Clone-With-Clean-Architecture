import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/person/person_info.dart';
import '../widgets/search_screen_appbar.dart';
import '../widgets/search_screen_body.dart';

import '../../../../config/container_injector.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  final PersonInfo currentPersonInfo;
  const SearchScreen({super.key, required this.currentPersonInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => sl<SearchBloc>(),
      child: Scaffold(
        appBar: const SearchScreenAppBar(),
        body: SearchScreenBody(currentPersonInfo: currentPersonInfo),
      ),
    );
  }
}
