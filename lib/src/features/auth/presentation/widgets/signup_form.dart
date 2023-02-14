import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/input_fields/email_field.dart';
import '../../../../core/widgets/input_fields/name_field.dart';
import '../../../../core/widgets/input_fields/password_field.dart';
import '../../../../core/widgets/input_fields/user_name_field.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../bloc/auth_bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(emailController: _emailController),
          const SizedBox(height: AppSize.s10),
          NameField(nameController: _nameController),
          const SizedBox(height: AppSize.s10),
          UsernameField(usernameController: _usernameController),
          const SizedBox(height: AppSize.s10),
          PasswordField(passwordController: _passwordController),
          const SizedBox(height: AppSize.s20),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSignupLoading) {
                return const CircularProgressIndicator();
              } else {
                return CustomButton(
                  label: AppStrings.signUp,
                  width: context.width,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignupParams signupParams = SignupParams(
                        email: _emailController.text,
                        password: _passwordController.text,
                        fullName: _nameController.text,
                        username: _usernameController.text,
                      );
                      context.read<AuthBloc>().add(
                            AuthSignupUser(signupParams: signupParams),
                          );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
