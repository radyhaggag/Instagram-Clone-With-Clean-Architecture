import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../widgets/profile_screen_appbar.dart';
import '../widgets/profile_screen_body.dart';

import '../../../../config/container_injector.dart';
import '../../../../core/domain/entities/person/person_info.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final PersonInfo personInfo;

  const ProfileScreen({super.key, required this.personInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => sl<ProfileBloc>(),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignOutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.welcome,
              (route) => false,
            );
          }
          if (state is ProfileSignOutFailed) {
            buildToast(
              toastType: ToastType.error,
              msg: state.message,
            );
          }
        },
        child: Scaffold(
          appBar: ProfileScreenAppBar(personInfo: personInfo),
          body: ProfileScreenBody(personInfo: personInfo),
        ),
      ),
    );
  }
}
