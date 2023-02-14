import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../domain/usecases/send_like_for_comment_usecase.dart';
import '../../domain/usecases/send_like_for_reply_usecase.dart';
import '../bloc/post_bloc.dart';
import '../widgets/reply_button.dart';
import '../../../../core/widgets/likers_builder.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.screenArgs,
    required this.isReply,
    required this.viewRepliesIsEnable,
  });

  final bool isReply;
  final PostScreensArgs screenArgs;
  final bool viewRepliesIsEnable;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late Comment comment;
  List<String> likersUid = [];
  List<Comment> replies = [];

  @override
  void initState() {
    super.initState();
    if (!widget.isReply) {
      comment = widget.screenArgs.comment!;
      likersUid = comment.likes.map((e) => e.uid).toList();
      replies = comment.replies.map((e) => e).toList();
    } else {
      comment = widget.screenArgs.reply!;
      likersUid = comment.likes.map((e) => e.uid).toList();
      replies = comment.replies.map((e) => e).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is CommentLikedSuccess && state.comment.id == comment.id) {
          likersUid = state.comment.likes.map((e) => e.uid).toList();
          comment = state.comment;
        }
        if (state is CommentRepliedSuccess && state.comment.id == comment.id) {
          replies = state.comment.replies;
          comment = state.comment;
        }
        if (state is CommentRepliedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is CommentLikedFailed) {
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
              BlocBuilder<PostBloc, PostState>(
                buildWhen: (previous, current) {
                  const states = [
                    "Instance of 'CommentSendingLike'",
                    "Instance of 'CommentLikedSuccess'",
                    "Instance of 'CommentLikedFailed'",
                  ];
                  return states.contains(current.toString());
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      if (!widget.isReply) {
                        LikeForCommentParams likeParams = LikeForCommentParams(
                          postId: widget.screenArgs.post.id,
                          publisherUid: widget.screenArgs.post.publisher.uid,
                          commentId: comment.id,
                        );
                        context
                            .read<PostBloc>()
                            .add(SendLikeForComment(likeParams));
                      } else {
                        LikeForReplyParams likeParams = LikeForReplyParams(
                          postId: widget.screenArgs.post.id,
                          publisherUid: widget.screenArgs.post.publisher.uid,
                          commentId: widget.screenArgs.comment!.id,
                          replyId: comment.id,
                        );
                        context
                            .read<PostBloc>()
                            .add(SendLikeForReply(likeParams));
                      }
                    },
                    icon: state is! CommentSendingLike
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
              BlocBuilder<PostBloc, PostState>(
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
              BlocBuilder<PostBloc, PostState>(
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
              if (!widget.isReply)
                ReplyButton(
                  screenArgs: widget.screenArgs.copyWith(comment: comment),
                ),
            ],
          ),
          const SizedBox(height: AppSize.s10),
          if (widget.viewRepliesIsEnable && comment.replies.isNotEmpty)
            BlocBuilder<PostBloc, PostState>(
              buildWhen: (previous, current) {
                const states = [
                  "Instance of 'CommentAddingReply'",
                  "Instance of 'CommentRepliedSuccess'",
                  "Instance of 'CommentRepliedFailed'",
                ];
                return states.contains(current.toString());
              },
              builder: (context, state) {
                return InkWell(
                  child: Text(
                    '${AppStrings.viewAll} ${replies.length.toString()} ${AppStrings.reply}',
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.viewReplies,
                      arguments: widget.screenArgs.copyWith(comment: comment),
                    );
                  },
                );
              },
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
