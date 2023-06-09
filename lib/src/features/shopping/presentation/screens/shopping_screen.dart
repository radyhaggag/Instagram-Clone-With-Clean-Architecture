import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/shopping_screen_appbar.dart';

import '../../../../config/container_injector.dart';
import '../bloc/shopping_bloc.dart';
import '../widgets/shopping_screen_body.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoppingBloc>(
      create: (context) => sl<ShoppingBloc>()..add(GetShoppingItems()),
      child: const Scaffold(
        appBar: ShoppingScreenAppBar(),
        body: ShoppingScreenBody(),
      ),
    );
  }
}
