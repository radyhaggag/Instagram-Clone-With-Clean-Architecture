import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_instead_of.dart';
import '../widgets/login_with_facebook.dart';
import '../widgets/or_separator.dart';
import '../widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignupError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is AuthSignupSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.userCreatedSuccessfully,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (route) => false,
              arguments: state.person,
            );
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(AppSize.s30),
            width: context.width,
            height: context.mainHeight,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Image(
                    image: AssetImage(AppImages.appName),
                    height: AppSize.s100,
                  ),
                  const SizedBox(height: AppSize.s5),
                  _buildSignupMessage(context),
                  const SizedBox(height: AppSize.s20),
                  const LoginWithFacebook(
                    backgroundColor: AppColors.blue,
                    iconAndTextColor: AppColors.white,
                  ),
                  const SizedBox(height: AppSize.s20),
                  const OrSeparator(),
                  const SizedBox(height: AppSize.s20),
                  const SignupForm(),
                  const Divider(height: AppSize.s50, thickness: AppSize.s2),
                  const AuthInsteadOf(
                    authRoute: Routes.login,
                    authMessage: AppStrings.havingAccount,
                    authMethod: AppStrings.login,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildSignupMessage(BuildContext context) {
    return Text(
      AppStrings.signupMessage,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: AppColors.blackWith40Opacity),
    );
  }
}
