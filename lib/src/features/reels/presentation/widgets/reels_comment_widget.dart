import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/likers_builder.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../bloc/reels_bloc.dart';

class ReelsCommentWidget extends StatefulWidget {
  const ReelsCommentWidget({
    super.key,
    required this.screenArgs,
  });

  final ReelsScreensArgs screenArgs;

  @override
  State<ReelsCommentWidget> createState() => _ReelsCommentWidgetState();
}

class _ReelsCommentWidgetState extends State<ReelsCommentWidget> {
  late Comment comment;
  List<String> likersUid = [];

  @override
  void initState() {
    super.initState();
    if (widget.screenArgs.comment != null) {
      comment = widget.screenArgs.comment!;
      likersUid = comment.likes.map((e) => e.uid).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReelsBloc, ReelsState>(
      listener: (context, state) {
        if (state is ReelCommentLikedSuccess &&
            state.comment.id == comment.id) {
          likersUid = state.comment.likes.map((e) => e.uid).toList();
          comment = state.comment;
        }
        if (state is ReelCommentLikedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleImageAvatar(personInfo: comment.commenterInfo),
              const SizedBox(width: AppSize.s10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: ViewPublisherNameWidget(
                          personInfo: comment.commenterInfo,
                          name: comment.commenterInfo.name,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: AppSize.s3),
                          child: Text(
                            comment.commentText,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.black.withOpacity(.8),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s10),
              BlocBuilder<ReelsBloc, ReelsState>(
                buildWhen: (previous, current) {
                  const states = [
                    "Instance of 'ReelCommentSendingLike'",
                    "Instance of 'ReelCommentLikedSuccess'",
                    "Instance of 'ReelCommentLikedFailed'",
                  ];
                  return states.contains(current.toString());
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      LikeForReelCommentParams likeParams =
                          LikeForReelCommentParams(
                        reelId: widget.screenArgs.reel.id,
                        publisherUid: widget.screenArgs.reel.publisher.uid,
                        commentId: comment.id,
                      );
                      context
                          .read<ReelsBloc>()
                          .add(SendLikeForReelComment(likeParams));
                    },
                    icon: state is! ReelCommentSendingLike
                        ? getIcon(likersUid)
                        : state.commentId == comment.id
                            ? const CenterProgressIndicator()
                            : getIcon(likersUid),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<ReelsBloc, ReelsState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {},
                    child: Text(
                      getShortestSuitableDate(
                          DateTime.parse(comment.commentDate)),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.black.withOpacity(.6)),
                    ),
                  );
                },
              ),
              BlocBuilder<ReelsBloc, ReelsState>(
                buildWhen: (previous, current) {
                  const states = [
                    "Instance of 'CommentSendingLike'",
                    "Instance of 'CommentLikedSuccess'",
                    "Instance of 'CommentLikedFailed'",
                  ];
                  return states.contains(current.toString());
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (comment.likes.isEmpty) return;
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: LikersBuilder(likers: comment.likes),
                        ),
                      );
                    },
                    child: Text(
                      '${likersUid.length} like',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.black.withOpacity(.6)),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget getIcon(List<String> likersUid) {
  bool isReacted = likersUid.contains(FirebaseAuth.instance.currentUser?.uid);
  return ImageIcon(
    size: 50,
    color: isReacted ? AppColors.red : AppColors.black,
    AssetImage(
      isReacted ? AppIcons.like : AppIcons.likeOutline,
    ),
  );
}
