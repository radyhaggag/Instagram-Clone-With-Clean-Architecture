import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../utils/app_colors.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    this.videoPath,
    this.videoUrl,
    this.disableTapped,
    required this.autoPlay,
    this.progressInBottom,
  });

  final bool autoPlay;
  final bool? disableTapped;
  final bool? progressInBottom;
  final String? videoPath;
  final String? videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.videoPath != null && File(widget.videoPath!).existsSync()) {
      controller = VideoPlayerController.file(File(widget.videoPath!))
        ..initialize().then((_) {
          setState(() {});
          if (widget.autoPlay) controller.play();
        });
    } else {
      controller = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
          if (widget.autoPlay) controller.play();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disableTapped == null
          ? () {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            }
          : null,
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(controller),
            Align(
              alignment: widget.progressInBottom != null
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              child: VideoProgress(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoProgress extends StatelessWidget {
  const VideoProgress({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      padding: EdgeInsets.zero,
      colors: const VideoProgressColors(
        backgroundColor: AppColors.light,
        playedColor: AppColors.blue,
      ),
    );
  }
}
