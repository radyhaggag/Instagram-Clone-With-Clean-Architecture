import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_route.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/input_fields/email_field.dart';
import '../../../../core/widgets/input_fields/password_field.dart';
import '../../domain/usecases/login_usecase.dart';
import '../bloc/auth_bloc.dart';
import 'login_with_facebook.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(emailController: _emailController),
          const SizedBox(height: AppSize.s12),
          PasswordField(passwordController: _passwordController),
          const SizedBox(height: AppSize.s12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.resetPassword);
              },
              child: Text(
                AppStrings.forgotPassword,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontThickness.medium,
                    ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s20),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoginLoading) {
                return const CenterProgressIndicator();
              } else {
                return CustomButton(
                  label: AppStrings.login,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      LoginParams loginParams = LoginParams(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      context.read<AuthBloc>().add(
                            AuthLoginUser(loginParams: loginParams),
                          );
                    }
                  },
                  width: context.width,
                );
              }
            },
          ),
          const SizedBox(height: AppSize.s20),
          const LoginWithFacebook(),
        ],
      ),
    );
  }
}
