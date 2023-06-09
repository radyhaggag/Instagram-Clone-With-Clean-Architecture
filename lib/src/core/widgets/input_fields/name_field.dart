import 'package:flutter/material.dart';

import '../../utils/app_strings.dart';

class NameField extends StatelessWidget {
  final TextEditingController nameController;
  const NameField({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (String? value) {
        if (value!.isEmpty) return AppStrings.nameIsRequired;
        return null;
      },
      decoration: const InputDecoration(
        labelText: AppStrings.name,
      ),
    );
  }
}
