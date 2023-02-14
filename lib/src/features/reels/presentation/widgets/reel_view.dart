import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../domain/usecases/send_like_usecase.dart';

import '../../../../config/screens_args.dart';
import '../../../../core/domain/entities/post/comment.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../domain/entities/reel.dart';
import '../bloc/reels_bloc.dart';

class ReelView extends StatefulWidget {
  const ReelView({super.key, required this.reel});
  final Reel reel;

  @override
  State<ReelView> createState() => _ReelViewState();
}

class _ReelViewState extends State<ReelView> {
  late final TextEditingController controller;
  List<String> likersUid = [];
  List<Comment> comments = [];
  late Reel reel;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    reel = widget.reel;
    likersUid = reel.likes.map((e) => e.uid).toList();
    comments = reel.comments.map((e) => e).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReelsBloc, ReelsState>(
      listener: (context, state) {
        if (state is ReelLikedSuccess) {
          if (reel.id == state.reel.id) {
            reel = state.reel;
            likersUid = state.reel.likes.map((e) => e.uid).toList();
          }
        }
        if (state is ReelCommentedSuccess) {
          if (reel.id == state.reel.id) {
            comments = state.reel.comments.map((e) => e).toList();
          }
        }
        if (state is ReelCommentedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ReelLikedFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: VideoPlayerWidget(
              videoUrl: reel.videoUrl,
              autoPlay: true,
              progressInBottom: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<ReelsBloc, ReelsState>(
                    buildWhen: (previous, current) {
                      return current is ReelSendingLike ||
                          current is ReelLikedSuccess ||
                          current is ReelLikedFailed;
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<ReelsBloc>().add(
                                    SendReelLike(ReelLikeParams(
                                      reelId: widget.reel.id,
                                      publisherUid: widget.reel.publisher.uid,
                                    )),
                                  );
                            },
                            child: _getIcon(likersUid),
                          ),
                          if (likersUid.isNotEmpty)
                            Text(
                              likersUid.length.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.white,
                                  ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s15),
                  BlocBuilder<ReelsBloc, ReelsState>(
                    buildWhen: (previous, current) {
                      return current is ReelAddingComment ||
                          current is ReelCommentedSuccess ||
                          current is ReelCommentedFailed;
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Routes.viewReelComments,
                                arguments: ReelsScreensArgs(
                                  reel: reel,
                                ),
                              );
                            },
                            child: const ImageIcon(
                              AssetImage(AppIcons.chat),
                              size: AppSize.s40,
                              color: AppColors.white,
                            ),
                          ),
                          if (comments.isNotEmpty)
                            Text(
                              comments.length.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.white,
                                  ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s15),
                  InkWell(
                    onTap: () {},
                    child: const ImageIcon(
                      AssetImage(AppIcons.send),
                      size: AppSize.s40,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: AppSize.s15),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      size: AppSize.s40,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleImageAvatar(
                        personInfo: reel.publisher,
                        radius: AppSize.s30,
                      ),
                      const SizedBox(width: AppSize.s5),
                      ViewPublisherNameWidget(
                        personInfo: reel.publisher,
                        name: reel.publisher.name,
                        textColor: AppColors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                  if (reel.reelText != null)
                    Text(
                      reel.reelText!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                  Text(
                    getLongestSuitableDate(DateTime.parse(reel.reelDate)),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.white.withOpacity(.8)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: AppSize.s30,
            left: AppSize.s30,
            child: Text(
              AppStrings.reels,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  ImageIcon _getIcon(List<String> likersUid) {
    return ImageIcon(
      size: AppSize.s40,
      color: likersUid.contains(FirebaseAuth.instance.currentUser?.uid)
          ? AppColors.red
          : AppColors.white,
      AssetImage(
        likersUid.contains(FirebaseAuth.instance.currentUser?.uid)
            ? AppIcons.like
            : AppIcons.likeOutline,
      ),
    );
  }
}
