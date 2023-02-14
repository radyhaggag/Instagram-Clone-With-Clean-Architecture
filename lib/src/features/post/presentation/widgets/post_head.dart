import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../../home/presentation/bloc/home_bloc.dart';

import '../../../../config/screens_args.dart';
import '../../../../core/utils/app_size.dart';
import '../bloc/post_bloc.dart';

class PostHead extends StatelessWidget {
  const PostHead({Key? key, required this.screenArgs}) : super(key: key);

  final PostScreensArgs screenArgs;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostDeletingSuccess) {
          buildToast(
            toastType: ToastType.success,
            msg: AppStrings.postDeletedSuccessMsg,
          );
          context.read<HomeBloc>().add(HomeLoadPosts());
        }
        if (state is PostDeletingFailed) {
          buildToast(
            toastType: ToastType.error,
            msg: state.message,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s5),
        child: Row(
          children: [
            CircleImageAvatar(
              personInfo: screenArgs.post.publisher,
              radius: AppSize.s20,
            ),
            const SizedBox(width: AppSize.s10),
            ViewPublisherNameWidget(
              personInfo: screenArgs.post.publisher,
              name: screenArgs.post.publisher.name,
            ),
            const Spacer(),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return BlocProvider.value(
                          value: context.read<PostBloc>(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (FirebaseAuth.instance.currentUser?.uid ==
                                  screenArgs.post.publisher.uid) ...[
                                SizedBox(
                                  width: context.width,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: ctx,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text(
                                            AppStrings.deleteEnsureMessage,
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(ctx);
                                                  },
                                                  child: Text(
                                                    AppStrings.no,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: AppColors.blue,
                                                        ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<PostBloc>()
                                                        .add(DeletePost(
                                                          screenArgs.post.id,
                                                        ));
                                                    Navigator.pop(ctx);
                                                  },
                                                  child: Text(
                                                    AppStrings.yes,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                AppColors.red),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColors.red,
                                    ),
                                    label: Text(
                                      AppStrings.delete,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: AppColors.red),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSize.s10),
                                SizedBox(
                                  width: context.width,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        Routes.editPost,
                                        arguments: screenArgs.post,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.blue,
                                    ),
                                    label: Text(
                                      AppStrings.edit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: AppColors.blue),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_horiz),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
