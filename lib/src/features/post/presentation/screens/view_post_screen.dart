import 'package:flutter/material.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/post_view.dart';

class ViewPostScreen extends StatelessWidget {
  const ViewPostScreen({super.key, required this.screensArgs});

  final PostScreensArgs screensArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${screensArgs.post.publisher.name}'s ${AppStrings.post}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s10),
        child: PostView(screenArgs: screensArgs),
      ),
    );
  }
}
