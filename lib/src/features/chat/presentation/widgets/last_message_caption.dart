import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class LastMessageCaption extends StatelessWidget {
  const LastMessageCaption({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    String senderName = message.sender.name;
    if (FirebaseAuth.instance.currentUser?.uid == message.sender.uid) {
      senderName = "Me";
    }
    if (message.text != null) {
      return _getText(
        context: context,
        message: message.text!,
        senderName: senderName,
      );
    } else if (message.videoUrl != null) {
      return _getText(
        context: context,
        message: AppStrings.sentVideo,
        senderName: senderName,
      );
    } else {
      return _getText(
        context: context,
        message: AppStrings.sentImage,
        senderName: senderName,
      );
    }
  }
}

RichText _getText({
  required String senderName,
  required BuildContext context,
  required String message,
}) {
  TextStyle? style = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.black,
      );

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: senderName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextSpan(text: "\t $message", style: style),
      ],
    ),
  );
}
