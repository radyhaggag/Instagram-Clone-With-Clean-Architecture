import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/screens_args.dart';
import '../../../../../core/functions/build_toast.dart';
import '../../../../../core/media_query.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_enums.dart';
import '../../../../../core/widgets/custom_shimmers.dart';

import '../../../../../core/domain/entities/person/person_info.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../core/widgets/post_view.dart';
import '../../bloc/home_bloc.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({super.key, required this.currentPersonInfo});

  final PersonInfo currentPersonInfo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomePostsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      buildWhen: (previous, current) {
        return current is HomePostsLoadingSuccess ||
            current is HomePostsLoading;
      },
      builder: (context, state) {
        if (state is HomePostsLoading) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const PostShimmer(),
            separatorBuilder: (context, index) => const SizedBox(
              height: AppSize.s10,
            ),
            itemCount: 10,
          );
        }
        if (context.read<HomeBloc>().posts.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => PostView(
              screenArgs: PostScreensArgs(
                post: context.read<HomeBloc>().posts[index],
                personInfo: currentPersonInfo,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: AppSize.s10,
            ),
            itemCount: context.read<HomeBloc>().posts.length,
          );
        } else {
          return Center(
            child: Image(
              width: context.width / 2,
              height: context.height / 2,
              image: const AssetImage(AppImages.noPosts),
            ),
          );
        }
      },
    );
  }
}

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s5),
            child: Row(
              children: const [
                CircleShimmer(radius: AppSize.s20),
                SizedBox(width: AppSize.s10),
                LightShimmer(width: AppSize.s100, height: AppSize.s15),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s5),
          LightShimmer(width: context.width, height: AppSize.s400),
          const SizedBox(height: AppSize.s10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleShimmer(radius: AppSize.s15),
                      SizedBox(width: AppSize.s10),
                      CircleShimmer(radius: AppSize.s15),
                      SizedBox(width: AppSize.s10),
                      CircleShimmer(radius: AppSize.s15),
                      SizedBox(width: AppSize.s10),
                      Spacer(),
                      CircleShimmer(radius: AppSize.s15),
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                  const LightShimmer(width: AppSize.s100, height: AppSize.s15),
                  const SizedBox(height: AppSize.s10),
                  LightShimmer(width: context.width / 2, height: AppSize.s15),
                  const SizedBox(height: AppSize.s10),
                  const LightShimmer(width: AppSize.s100, height: AppSize.s15),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              LightShimmer(width: context.width, height: AppSize.s40)
            ],
          )
        ],
      ),
    );
  }
}
