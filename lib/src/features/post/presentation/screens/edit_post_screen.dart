import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/functions/get_suitable_date.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../../domain/usecases/edit_post_usecase.dart';

import '../bloc/post_bloc.dart';

class EditPostScreen extends StatefulWidget {
  final Post post;
  const EditPostScreen({super.key, required this.post});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.post.postText);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostEditingSuccess) {
          buildToast(
            toastType: ToastType.success,
            msg: AppStrings.postEditedSuccessMsg,
          );
        }
        if (state is PostEditingFailed) {
          buildToast(
            toastType: ToastType.error,
            msg: state.message,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppStrings.edit,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: const CloseButton(),
          actions: [
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<PostBloc>().add(
                          EditPost(EditPostParams(
                            postText: controller.text,
                            postId: widget.post.id,
                          )),
                        );
                  },
                  icon: state is! PostEditing
                      ? const Icon(
                          Icons.check,
                          color: AppColors.blue,
                        )
                      : const SizedBox(
                          width: AppSize.s20,
                          height: AppSize.s20,
                          child: CenterProgressIndicator(),
                        ),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: AppSize.s10),
                  SizedBox(
                    width: AppSize.s30,
                    height: AppSize.s30,
                    child: ImageBuilder(
                      imageUrl: widget.post.publisher.imageUrl,
                      imagePath: widget.post.publisher.localImagePath,
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  ViewPublisherNameWidget(
                    personInfo: widget.post.publisher,
                    name: widget.post.publisher.name,
                  ),
                  const Spacer(),
                  Text(getLongestSuitableDate(
                      DateTime.parse(widget.post.postDate))),
                  const SizedBox(width: AppSize.s20),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              SizedBox(
                height: context.height / 1.5,
                child: ImageBuilder(
                  imageUrl: widget.post.postMedia.imagesUrl.first,
                  imagePath: widget.post.postMedia.imagesLocalPaths.first,
                ),
              ),
              TextFormField(
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
