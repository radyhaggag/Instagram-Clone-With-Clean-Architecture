import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

import '../media_query.dart';

class ImageBuilder extends StatelessWidget {
  final String imageUrl;
  final String? imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const ImageBuilder({
    super.key,
    required this.imageUrl,
    this.imagePath,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath != null && File(imagePath!).existsSync()) {
      return Image(
        image: FileImage(File(imagePath!)),
        width: context.width,
        height: context.height,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => _buildImageShimmer(),
        errorWidget: (context, url, error) => Image(
          image: const AssetImage(AppImages.noConnection),
          fit: BoxFit.cover,
          width: context.width,
        ),
        width: width ?? context.width,
        height: height ?? context.height,
        fit: fit ?? BoxFit.cover,
      );
    }
  }
}

class ImageViewBuilder extends StatelessWidget {
  const ImageViewBuilder({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => PhotoView(
        imageProvider: imageProvider,
        initialScale: PhotoViewComputedScale.covered,
      ),
      placeholder: (context, url) => _buildImageShimmer(),
      errorWidget: (context, url, error) => Image(
        image: const AssetImage(AppImages.noConnection),
        fit: BoxFit.cover,
        width: context.width,
      ),
    );
  }
}

Shimmer _buildImageShimmer() {
  return Shimmer.fromColors(
    baseColor: AppColors.black.withOpacity(.10),
    highlightColor: AppColors.black.withOpacity(.2),
    child: Container(
      color: AppColors.black,
    ),
  );
}
