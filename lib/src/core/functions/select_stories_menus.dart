import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/story/presentation/bloc/story_bloc.dart';
import '../utils/app_colors.dart';
import '../utils/app_enums.dart';
import '../utils/app_size.dart';
import '../utils/app_strings.dart';

const double selectFromGalleryHeight = kToolbarHeight * 1.7;
const double selectFromCameraHeight = kToolbarHeight * 2.76;

Future<dynamic> selectFromCamera(BuildContext context) {
  return showMenu(
    context: context,
    color: Colors.transparent,
    elevation: 0.0,
    position: const RelativeRect.fromLTRB(
      AppSize.s70,
      selectFromCameraHeight,
      AppSize.s200,
      0.0,
    ),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: Row(
          children: [
            imageBtn(context, () {
              Navigator.pop(context);
              context.read<StoryBloc>().add(const SelectStory(
                  mediaType: MediaType.image, imageSource: ImageSource.camera));
            }),
            const SizedBox(width: AppSize.s10),
            videoBtn(context, () {
              Navigator.pop(context);
              context.read<StoryBloc>().add(const SelectStory(
                  mediaType: MediaType.video, imageSource: ImageSource.camera));
            }),
          ],
        ),
      ),
    ],
  );
}

Future<dynamic> selectFromGallery(BuildContext context) {
  return showMenu(
    context: context,
    color: Colors.transparent,
    elevation: 0.0,
    position: const RelativeRect.fromLTRB(
      AppSize.s70,
      selectFromGalleryHeight,
      AppSize.s200,
      0.0,
    ),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: Row(
          children: [
            imageBtn(context, () {
              Navigator.pop(context);
              context.read<StoryBloc>().add(const SelectStory(
                  mediaType: MediaType.image,
                  imageSource: ImageSource.gallery));
            }),
            const SizedBox(width: AppSize.s10),
            videoBtn(context, () {
              Navigator.pop(context);
              context.read<StoryBloc>().add(const SelectStory(
                  mediaType: MediaType.video,
                  imageSource: ImageSource.gallery));
            }),
          ],
        ),
      ),
    ],
  );
}

Widget imageBtn(BuildContext context, void Function()? onPressed) {
  return ElevatedButton.icon(
    style: _elevatedBtnStyle,
    icon: const Icon(Icons.image),
    label: const Text(AppStrings.image),
    onPressed: onPressed,
  );
}

Widget videoBtn(BuildContext context, void Function()? onPressed) {
  return ElevatedButton.icon(
    style: _elevatedBtnStyle,
    icon: const Icon(Icons.videocam_rounded),
    label: const Text(AppStrings.video),
    onPressed: onPressed,
  );
}

ButtonStyle get _elevatedBtnStyle {
  return ElevatedButton.styleFrom(backgroundColor: AppColors.vividCerise);
}
