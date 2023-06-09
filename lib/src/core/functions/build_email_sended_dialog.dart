import 'package:flutter/material.dart';

import '../../config/app_route.dart';
import '../utils/app_strings.dart';

Future<void> buildEmailSendedDialog(
    {required BuildContext context, required String message}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Text(message, textAlign: TextAlign.center),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          },
          child: const Text(AppStrings.done),
        )
      ],
    ),
  );
}
