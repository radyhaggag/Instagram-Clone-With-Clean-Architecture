import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/build_email_sended_dialog.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/input_fields/email_field.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/lock_avatar.dart';
import '../widgets/login_with_facebook.dart';
import '../widgets/or_separator.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginResetPasswordError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is LoginResetPasswordSuccess) {
            buildEmailSendedDialog(context: context, message: state.message);
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
              width: context.width,
              height: context.heightOfScreenOnly,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LockAvatar(),
                    const SizedBox(height: AppSize.s20),
                    Text(
                      AppStrings.troubleOnLoggingIn,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSize.s20),
                    Text(
                      AppStrings.resetPasswordMessage,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSize.s20),
                    EmailField(emailController: _emailController),
                    const SizedBox(height: AppSize.s20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is LoginResetPasswordLoading) {
                          return const CenterProgressIndicator();
                        } else {
                          return CustomButton(
                            label: AppStrings.resetPassword,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthLoginResetUserPassword(
                                        email: _emailController.text,
                                      ),
                                    );
                              }
                            },
                            radius: AppSize.s5,
                            width: context.width,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppSize.s40),
                    const OrSeparator(),
                    const SizedBox(height: AppSize.s20),
                    const LoginWithFacebook(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
