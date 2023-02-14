import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/media_query.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../bloc/post_bloc.dart';
import '../widgets/comment_widget.dart';

class ViewPostCommentsScreen extends StatelessWidget {
  final PostScreensArgs screenArgs;

  const ViewPostCommentsScreen({
    super.key,
    required this.screenArgs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s10),
        child: BlocConsumer<PostBloc, PostState>(
          buildWhen: (previous, current) {
            return current is PostLoadingSuccess || current is PostLoading;
          },
          listener: (context, state) {
            if (state is PostLoadingFailed) {
              buildToast(toastType: ToastType.error, msg: state.message);
            }
          },
          builder: (context, state) {
            if (screenArgs.post.comments.isEmpty) {
              return Center(
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
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PostBloc>().add(
                        GetPost(
                          GetPostParams(
                            postId: screenArgs.post.id,
                            publisherId: screenArgs.post.publisher.uid,
                          ),
                        ),
                      );
                },
                child: state is! PostLoading
                    ? (state is PostLoadingSuccess
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                screenArgs: screenArgs.copyWith(
                                    comment: state.post.comments[index]),
                                isReply: false,
                                viewRepliesIsEnable: true,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.post.comments.length,
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                screenArgs: screenArgs.copyWith(
                                  comment: screenArgs.post.comments[index],
                                ),
                                isReply: false,
                                viewRepliesIsEnable: true,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: screenArgs.post.comments.length,
                          ))
                    : const CenterProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
