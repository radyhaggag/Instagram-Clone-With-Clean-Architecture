import 'package:flutter/material.dart';

import '../utils/app_size.dart';
import '../widgets/center_progress_indicator.dart';

Future<void> showProgressDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        contentPadding: EdgeInsets.all(AppSize.s50),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CenterProgressIndicator(),
          ],
        ),
      ),
    );
