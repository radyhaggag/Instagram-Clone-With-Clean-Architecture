import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../widgets/comment_widget.dart';

import '../../../../config/screens_args.dart';
import '../../../../core/utils/app_size.dart';

class ViewRepliesScreen extends StatelessWidget {
  final PostScreensArgs screenArgs;

  const ViewRepliesScreen({
    Key? key,
    required this.screenArgs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${screenArgs.comment!.replies.length} ${AppStrings.replies} on ${screenArgs.comment!.commenterInfo.name.split(' ').first}'s ${AppStrings.comment}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s10),
        child: ListView(
          children: [
            CommentWidget(
              screenArgs: screenArgs,
              isReply: false,
              viewRepliesIsEnable: false,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppSize.s40,
                top: AppSize.s10,
              ),
              child: Column(
                children: List.generate(
                  screenArgs.comment!.replies.length,
                  (index) {
                    return CommentWidget(
                      screenArgs: screenArgs.copyWith(
                        reply: screenArgs.comment!.replies[index],
                      ),
                      isReply: true,
                      viewRepliesIsEnable: false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
