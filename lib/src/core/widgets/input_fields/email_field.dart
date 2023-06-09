import 'package:flutter/material.dart';

import '../../utils/app_strings.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) return AppStrings.emailIsRequired;
        return null;
      },
      decoration: const InputDecoration(
        labelText: AppStrings.email,
      ),
    );
  }
}
