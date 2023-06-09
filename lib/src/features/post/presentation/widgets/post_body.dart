import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/video_player_widget.dart';

import '../../../../config/screens_args.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../domain/usecases/send_like_usecase.dart';
import '../bloc/post_bloc.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key, required this.screenArgs}) : super(key: key);

  final PostScreensArgs screenArgs;

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    if (widget.screenArgs.post.postMedia.videosUrl.isEmpty) {
      return InkWell(
        onDoubleTap: () {
          LikeParams likeParams = LikeParams(
            postId: widget.screenArgs.post.id,
            publisherUid: widget.screenArgs.post.publisher.uid,
          );
          context.read<PostBloc>().add(SendLike(likeParams));

          context.read<PostBloc>().add(SendLike(likeParams));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: AppSize.s400,
                viewportFraction: 1.0,
                enableInfiniteScroll:
                    widget.screenArgs.post.postMedia.imagesUrl.length > 1
                        ? true
                        : false,
              ),
              itemCount: widget.screenArgs.post.postMedia.imagesUrl.length,
              itemBuilder: (context, index, realIndex) {
                return ImageViewBuilder(
                  imageUrl: widget.screenArgs.post.postMedia.imagesUrl[index],
                );
              },
            ),
            if (widget.screenArgs.post.postMedia.imagesUrl.length > 1) ...[
              SliderButton(
                buttonCarouselController: buttonCarouselController,
                isNext: false,
              ),
              SliderButton(
                buttonCarouselController: buttonCarouselController,
                isNext: true,
              ),
            ],
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          CarouselSlider.builder(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: AppSize.s400,
              viewportFraction: 1.0,
              enableInfiniteScroll:
                  widget.screenArgs.post.postMedia.videosUrl.length > 1
                      ? true
                      : false,
            ),
            itemCount: widget.screenArgs.post.postMedia.videosUrl.length,
            itemBuilder: (context, index, realIndex) {
              return VideoPlayerWidget(
                videoUrl: widget.screenArgs.post.postMedia.videosUrl[index],
                videoPath:
                    widget.screenArgs.post.postMedia.videosLocalPaths[index],
                autoPlay: false,
              );
            },
          ),
          if (widget.screenArgs.post.postMedia.imagesUrl.length > 1) ...[
            SliderButton(
              buttonCarouselController: buttonCarouselController,
              isNext: false,
            ),
            SliderButton(
              buttonCarouselController: buttonCarouselController,
              isNext: true,
            ),
          ],
        ],
      );
    }
  }
}

class SliderButton extends StatelessWidget {
  final bool isNext;
  const SliderButton({
    super.key,
    required this.buttonCarouselController,
    required this.isNext,
  });

  final CarouselController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isNext ? Alignment.centerRight : Alignment.centerLeft,
      child: OutlinedButton(
        onPressed: () {
          if (isNext) {
            buttonCarouselController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          } else {
            buttonCarouselController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }
        },
        child: Icon(
          isNext ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
          size: AppSize.s40,
        ),
      ),
    );
  }
}
