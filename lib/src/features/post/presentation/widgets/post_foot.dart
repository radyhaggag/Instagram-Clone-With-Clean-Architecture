import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/widgets/likers_builder.dart';
import '../../../../config/app_route.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';

import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../bloc/post_bloc.dart';
import 'post_item_btn.dart';

class PostFoot extends StatefulWidget {
  final PostScreensArgs screenArgs;
  const PostFoot({Key? key, required this.screenArgs}) : super(key: key);

  @override
  State<PostFoot> createState() => _PostFootState();
}

class _PostFootState extends State<PostFoot> {
  late final TextEditingController controller;
  List<String> likersUid = [];
  List<Comment> comments = [];
  late Post post;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    post = widget.screenArgs.post;
    likersUid = post.likes.map((e) => e.uid).toList();
    comments = post.comments.map((e) => e).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) async {
        if (state is PostLikedSuccess) {
          if (post.id == state.post.id) {
            post = state.post;
            likersUid = state.post.likes.map((e) => e.uid).toList();
          }
        }
        if (state is PostCommentedSuccess) {
          if (post.id == state.post.id) {
            comments = state.post.comments.map((e) => e).toList();
          }
        }
        if (state is PostCommentedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is PostLikedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        // if (state is PostFollowingsLoadedSuccess && state.post?.id == post.id) {
        //   showDialog(
        //     context: context,
        //     builder: (context) => Dialog(
        //       child: LikersBuilder(likers: post.likes),
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        LikeParams likeParams = LikeParams(
                          postId: post.id,
                          publisherUid: post.publisher.uid,
                        );
                        context.read<PostBloc>().add(SendLike(likeParams));
                      },
                      icon: state is! PostSendingLike
                          ? _getIcon(likersUid)
                          : state.postId == post.id
                              ? const CenterProgressIndicator()
                              : _getIcon(likersUid),
                    ),
                    const SizedBox(width: AppSize.s10),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          Routes.viewPostComments,
                          arguments: widget.screenArgs,
                        );
                      },
                      icon: const ImageIcon(
                        size: 50,
                        AssetImage(AppIcons.chat),
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    IconButton(
                      onPressed: () {},
                      icon: const ImageIcon(
                        size: 50,
                        AssetImage(AppIcons.send),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const ImageIcon(
                        size: 50,
                        AssetImage(AppIcons.bookmark),
                      ),
                    ),
                  ],
                ),
                PostItemBtn(
                  label: '${likersUid.length} ${AppStrings.likes}',
                  onTap: () {
                    if (post.likes.isEmpty) return;

                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: LikersBuilder(likers: post.likes),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    ViewPublisherNameWidget(
                      personInfo: post.publisher,
                      name: post.publisher.username,
                    ),
                    if (post.postText != null) Text(post.postText!),
                  ],
                ),
                if (comments.isNotEmpty)
                  PostItemBtn(
                    label:
                        '${AppStrings.viewAll} ${comments.length.toString()} ${AppStrings.comments}',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.viewPostComments,
                        arguments: widget.screenArgs.copyWith(
                          post: post.copyWith(
                            comments: comments,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSize.s10),
              child: Text(
                getLongestSuitableDate(DateTime.parse(post.postDate)),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColors.black.withOpacity(.6)),
              ),
            ),
            SizedBox(
              height: AppSize.s60,
              child: StatefulBuilder(
                builder: (context, setState) => TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() => isFilled = true);
                    } else {
                      setState(() => isFilled = false);
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: null,
                    focusedBorder: null,
                    hintText: AppStrings.addCommentMsg,
                    suffix: state is! PostAddingComment
                        ? TextButton(
                            onPressed: !isFilled
                                ? null
                                : () {
                                    CommentParams commentParams = CommentParams(
                                      postId: post.id,
                                      commentText: controller.text,
                                      commenter: widget.screenArgs.personInfo,
                                      publisherUid: post.publisher.uid,
                                      commentDate: DateTime.now()
                                          .toUtc()
                                          .toLocal()
                                          .toString(),
                                    );
                                    context.read<PostBloc>().add(
                                          AddComment(commentParams),
                                        );
                                  },
                            child: Text(
                              AppStrings.post,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.blue),
                            ),
                          )
                        : const SizedBox(
                            width: AppSize.s20,
                            height: AppSize.s20,
                            child: CenterProgressIndicator(),
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ImageIcon _getIcon(List<String> likersUid) {
    return ImageIcon(
      size: 50,
      color: likersUid.contains(widget.screenArgs.personInfo.uid)
          ? AppColors.red
          : AppColors.black,
      AssetImage(
        likersUid.contains(widget.screenArgs.personInfo.uid)
            ? AppIcons.like
            : AppIcons.likeOutline,
      ),
    );
  }
}
