import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

import '../../../../config/container_injector.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../reels/presentation/bloc/reels_bloc.dart';
import '../../../reels/presentation/screens/reels_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../../shopping/presentation/screens/shopping_screen.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/home_body.dart';
import '../widgets/home/home_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.person});

  final Person person;

  Widget _getHomeBodyModule(int index) {
    switch (index) {
      case 0:
        return HomeBody(person: person);
      case 1:
        return SearchScreen(currentPersonInfo: person.personInfo);
      case 2:
        return BlocProvider<ReelsBloc>(
          create: (context) => sl<ReelsBloc>()..add(LoadReels()),
          child: const ReelsScreen(),
        );
      case 3:
        return const ShoppingScreen();
      case 4:
        return ProfileScreen(personInfo: person.personInfo);
      default:
        return HomeBody(person: person);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return current is ScreenModuleChanged;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: state is ScreenModuleChanged && state.index != 0
              ? null
              : const HomeScreenAppBar(),
          body: state is! ScreenModuleChanged
              ? HomeBody(person: person)
              : _getHomeBodyModule(state.index),
          bottomNavigationBar: HomeBottomNavBar(person: person),
        );
      },
    );
  }
}
