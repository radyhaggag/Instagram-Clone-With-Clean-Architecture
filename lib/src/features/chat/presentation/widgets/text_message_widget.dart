import 'package:flutter/material.dart';
import '../../../../core/media_query.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../../domain/entities/message.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    super.key,
    required this.isSender,
    required this.globalKey,
    required this.message,
  });

  final bool isSender;
  final Message message;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
        child: Container(
          key: globalKey,
          padding: const EdgeInsets.all(AppSize.s10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .7,
          ),
          decoration: BoxDecoration(
            gradient: isSender
                ? const LinearGradient(
                    colors: [AppColors.grape, AppColors.vividCerise],
                  )
                : null,
            color: isSender ? null : AppColors.blackWith40Opacity,
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                    ),
              ),
              if (message.imageUrl != null) ...[
                const SizedBox(height: AppSize.s5),
                ImageBuilder(
                  imageUrl: message.imageUrl!,
                  height: context.height / 5,
                ),
              ],
              if (message.videoUrl != null) ...[
                const SizedBox(height: AppSize.s5),
                SizedBox(
                  height: context.height / 5,
                  width: context.width / 2,
                  child: VideoPlayerWidget(
                    videoUrl: message.videoUrl!,
                    autoPlay: false,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
