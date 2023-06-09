import 'package:flutter/material.dart';

import '../../utils/app_strings.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController usernameController;
  const UsernameField({super.key, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.name,
      validator: (String? value) {
        if (value!.isEmpty) return AppStrings.usernameIsRequired;
        return null;
      },
      decoration: const InputDecoration(
        labelText: AppStrings.username,
      ),
    );
  }
}
