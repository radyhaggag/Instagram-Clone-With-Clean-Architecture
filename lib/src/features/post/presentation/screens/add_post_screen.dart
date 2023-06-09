import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/input_fields/caption_text_field.dart';
import '../../../../core/widgets/share_to_widgets.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../bloc/post_bloc.dart';
import '../widgets/post_feature_item.dart';

class AddPostScreen extends StatefulWidget {
  final MediaType mediaType;
  const AddPostScreen({super.key, required this.mediaType});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late final TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    context.read<PostBloc>().add(SelectPostMedia(
          mediaType: widget.mediaType,
          imageSource: ImageSource.gallery,
        ));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, _textController),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostUploading) {
            showDialog(
                context: context,
                builder: (context) => const CenterProgressIndicator());
          }
          if (state is PostUploadingSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.postUploadingSuccessMsg,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          }
          if (state is PostUploadingFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          final postBloc = context.read<PostBloc>();
          if (postBloc.imagesPaths != null || postBloc.videoPath != null) {
            return ListView(
              children: [
                if (postBloc.imagesPaths != null)
                  Container(
                    padding: const EdgeInsets.all(AppSize.s10),
                    decoration: const BoxDecoration(
                      color: AppColors.light,
                    ),
                    height: context.height / 4,
                    child: Row(
                      children: [
                        Image(
                          height: context.height / 4,
                          width: context.width / 4,
                          fit: BoxFit.cover,
                          image: FileImage(File(postBloc.imagesPaths!.first)),
                        ),
                        const SizedBox(width: AppSize.s5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CaptionTextField(textController: _textController),
                              if (postBloc.taggedPeople.isNotEmpty) ...[
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(AppSize.s10),
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      String name = 'With ';
                                      name += postBloc.taggedPeople
                                          .map((e) => e.personInfo.name)
                                          .join(', ')
                                          .toString();
                                      return Text(name);
                                    },
                                  ),
                                ),
                              ],
                              if (postBloc.locationName != null) ...[
                                const Divider(),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppSize.s10),
                                    child: Text(
                                      "Location ${postBloc.locationName!}",
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (postBloc.videoPath != null)
                  SizedBox(
                    height: context.height / 1.8,
                    child: VideoPlayerWidget(
                      videoPath: postBloc.videoPath,
                      autoPlay: true,
                    ),
                  ),
                if (postBloc.videoPath != null)
                  CaptionTextField(textController: _textController),
                const Divider(),
                const PostFeatureItem(
                  title: AppStrings.tagPeople,
                  route: Routes.tagsPeople,
                ),
                const Divider(),
                const PostFeatureItem(
                  title: AppStrings.addLocation,
                  route: Routes.addLocation,
                ),
                const Divider(),
                const ShareToWidgets(),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(
          BuildContext context, TextEditingController textController) =>
      AppBar(
        title: const Text(AppStrings.newPost),
        actions: [
          TextButton(
            onPressed: () {
              context.read<PostBloc>().add(
                    UploadPost(
                      textController.text,
                      DateTime.now().toLocal().toString(),
                    ),
                  );
            },
            child: const Text(AppStrings.share),
          ),
        ],
      );
}
