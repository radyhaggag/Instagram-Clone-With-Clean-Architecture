import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_instead_of.dart';
import '../widgets/login_form.dart';
import '../widgets/or_separator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is AuthLoginSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.loggedInnSuccessfully,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (Route<dynamic> route) => false,
              arguments: state.user,
            );
          }
          if (state is LoginResetPasswordSuccess) {
            buildToast(toastType: ToastType.success, msg: state.message);
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
            width: context.width,
            height: context.mainHeight,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  Image(
                    image: AssetImage(AppImages.appName),
                    height: AppSize.s100,
                  ),
                  SizedBox(height: AppSize.s40),
                  LoginForm(),
                  SizedBox(height: AppSize.s30),
                  OrSeparator(),
                  SizedBox(height: AppSize.s30),
                  AuthInsteadOf(
                    authRoute: Routes.signUp,
                    authMessage: AppStrings.notHavingAccount,
                    authMethod: AppStrings.signUp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
