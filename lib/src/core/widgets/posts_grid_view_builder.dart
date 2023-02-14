import 'package:flutter/material.dart';
import '../domain/entities/person/person_info.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import 'video_player_widget.dart';
import '../../features/reels/domain/mappers/mappers.dart';

import '../../config/app_route.dart';
import '../../config/screens_args.dart';
import '../domain/entities/post/post.dart';
import '../utils/app_size.dart';
import 'custom_shimmers.dart';
import 'image_builder.dart';

class PostsShimmerBuilder extends StatelessWidget {
  const PostsShimmerBuilder({super.key, required this.postsCount});

  final int postsCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: postsCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: AppSize.s5,
        mainAxisSpacing: AppSize.s5,
      ),
      itemBuilder: (context, index) {
        return const LightShimmer();
      },
    );
  }
}

class PostsGridViewBuilder extends StatelessWidget {
  const PostsGridViewBuilder({
    super.key,
    required this.posts,
    required this.personInfo,
  });

  final PersonInfo personInfo;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: AppSize.s5,
        mainAxisSpacing: AppSize.s5,
      ),
      itemBuilder: (context, index) {
        if (posts[index].postMedia.imagesUrl.isNotEmpty) {
          return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.viewPost,
                  arguments: PostScreensArgs(
                    post: posts[index],
                    personInfo: personInfo,
                  ),
                );
              },
              child: ImageBuilder(
                imageUrl: posts[index].postMedia.imagesUrl.first,
                imagePath: posts[index].postMedia.imagesLocalPaths.first,
              ));
        } else {
          return InkWell(
            onTap: () {
              // the followings condition available only on reel
              if (isReel(posts[index])) {
                Navigator.of(context).pushNamed(
                  Routes.viewReel,
                  arguments: posts[index].toReel(),
                );
              } else {
                Navigator.of(context).pushNamed(
                  Routes.viewPost,
                  arguments: PostScreensArgs(
                    post: posts[index],
                    personInfo: personInfo,
                  ),
                );
              }
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: VideoPlayerWidget(
                    videoUrl: posts[index].postMedia.videosUrl.first,
                    videoPath:
                        posts[index].postMedia.videosLocalPaths.isNotEmpty
                            ? posts[index].postMedia.videosLocalPaths.first
                            : null,
                    autoPlay: false,
                    disableTapped: true,
                  ),
                ),
                if (isReel(posts[index]))
                  const Padding(
                    padding: EdgeInsets.all(AppSize.s10),
                    child: ImageIcon(
                      AssetImage(AppIcons.video),
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  bool isReel(Post post) {
    if (post.postMedia.videosLocalPaths.isEmpty &&
        post.postMedia.videosUrl.isNotEmpty &&
        post.postMedia.videosUrl.length == 1) {
      return true;
    }
    return false;
  }
}
