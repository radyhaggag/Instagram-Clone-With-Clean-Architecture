import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/input_fields/caption_text_field.dart';
import '../../../../core/widgets/share_to_widgets.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../bloc/reels_bloc.dart';

class AddReelScreen extends StatefulWidget {
  const AddReelScreen({super.key});

  @override
  State<AddReelScreen> createState() => _AddReelScreenState();
}

class _AddReelScreenState extends State<AddReelScreen> {
  late final TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    context.read<ReelsBloc>().add(SelectReelVideo());
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
      body: BlocConsumer<ReelsBloc, ReelsState>(
        listener: (context, state) {
          if (state is ReelUploading) {
            showDialog(
              context: context,
              builder: (context) => const CenterProgressIndicator(),
            );
          }
          if (state is ReelUploadingSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.postUploadingSuccessMsg,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          }
          if (state is ReelUploadingFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          if (context.read<ReelsBloc>().videoPath != null) {
            return ListView(
              children: [
                if (context.read<ReelsBloc>().videoPath != null)
                  SizedBox(
                    height: context.height / 1.8,
                    child: VideoPlayerWidget(
                      videoPath: context.read<ReelsBloc>().videoPath,
                      autoPlay: true,
                    ),
                  ),
                if (context.read<ReelsBloc>().videoPath != null)
                  CaptionTextField(textController: _textController),
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
              context.read<ReelsBloc>().add(
                    UploadReel(
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
