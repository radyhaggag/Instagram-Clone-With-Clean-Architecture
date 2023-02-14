import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/media_query.dart';
import '../bloc/reels_bloc.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../domain/entities/reel.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/get_reel_usecase.dart';
import '../widgets/reels_comment_widget.dart';

class ViewReelsCommentsScreen extends StatefulWidget {
  final ReelsScreensArgs screenArgs;

  const ViewReelsCommentsScreen({
    super.key,
    required this.screenArgs,
  });

  @override
  State<ViewReelsCommentsScreen> createState() =>
      _ViewReelsCommentsScreenState();
}

class _ViewReelsCommentsScreenState extends State<ViewReelsCommentsScreen> {
  late Reel reel;

  @override
  void initState() {
    super.initState();
    reel = widget.screenArgs.reel;
  }

  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s10),
        child: BlocConsumer<ReelsBloc, ReelsState>(
          listener: (context, state) {
            if (state is ReelLoadingFailed) {
              buildToast(toastType: ToastType.error, msg: state.message);
            }
            if (state is ReelCommentedSuccess) {
              reel = state.reel;
            }
            if (state is ReelLoadingSuccess) {
              reel = state.reel;
            }
            if (state is ReelLikedSuccess) {
              reel = state.reel;
            }
          },
          builder: (context, state) {
            if (reel.comments.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: context.width / 3,
                            image: const AssetImage(AppIcons.chat),
                          ),
                          Text(
                            AppStrings.noComments,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    ReelCommentTextField(reel: reel),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ReelsBloc>().add(
                        GetReel(
                          GetReelParams(
                            reelId: reel.id,
                            publisherId: reel.publisher.uid,
                          ),
                        ),
                      );
                },
                child: state is! ReelLoading
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ReelsCommentWidget(
                                  screenArgs: widget.screenArgs.copyWith(
                                    comment: reel.comments[index],
                                    reel: reel,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: reel.comments.length,
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          ReelCommentTextField(reel: reel),
                        ],
                      )
                    : const CenterProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ReelCommentTextField extends StatefulWidget {
  final Reel reel;
  const ReelCommentTextField({
    super.key,
    required this.reel,
  });

  @override
  State<ReelCommentTextField> createState() => _ReelCommentTextFieldState();
}

class _ReelCommentTextFieldState extends State<ReelCommentTextField> {
  late final TextEditingController controller;

  bool isFilled = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReelsBloc, ReelsState>(
      buildWhen: (previous, current) {
        return current is ReelAddingComment ||
            current is ReelCommentedFailed ||
            current is ReelCommentedSuccess;
      },
      builder: (context, state) {
        return SizedBox(
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
                suffix: state is! ReelAddingComment
                    ? TextButton(
                        onPressed: !isFilled
                            ? null
                            : () {
                                ReelCommentParams commentParams =
                                    ReelCommentParams(
                                  reelId: widget.reel.id,
                                  commentText: controller.text,
                                  publisherUid: widget.reel.publisher.uid,
                                  commentDate: DateTime.now()
                                      .toUtc()
                                      .toLocal()
                                      .toString(),
                                );
                                context.read<ReelsBloc>().add(AddReelComment(
                                      commentParams,
                                    ));
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
        );
      },
    );
  }
}
