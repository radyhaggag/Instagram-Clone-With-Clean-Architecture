import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class AuthInsteadOf extends StatelessWidget {
  final String authRoute;
  final String authMethod;
  final String authMessage;
  const AuthInsteadOf({
    Key? key,
    required this.authRoute,
    required this.authMethod,
    required this.authMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          authMessage,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.blackWith40Opacity,
              ),
        ),
        const SizedBox(width: AppSize.s5),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(authRoute, (route) => true);
          },
          child: Text(
            authMethod,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.blue),
          ),
        )
      ],
    );
  }
}
