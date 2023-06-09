import 'package:flutter/material.dart';

import '../utils/app_size.dart';
import '../utils/app_strings.dart';

class ShareToWidgets extends StatefulWidget {
  const ShareToWidgets({super.key});

  @override
  State<ShareToWidgets> createState() => _ShareToWidgetsState();
}

class _ShareToWidgetsState extends State<ShareToWidgets> {
  bool facebookValue = false;

  bool twitterValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s15),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: Text(AppStrings.facebook)),
              Switch(
                value: facebookValue,
                onChanged: (newVal) {
                  setState(() => facebookValue = newVal);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text(AppStrings.twitter)),
              Switch(
                value: twitterValue,
                onChanged: (newVal) {
                  setState(() => twitterValue = newVal);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
