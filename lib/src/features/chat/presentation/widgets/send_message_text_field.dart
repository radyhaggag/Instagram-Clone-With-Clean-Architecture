import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/video_player_widget.dart';
import 'view_media_selection_option_btn.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../bloc/chat_bloc.dart';

class SendMessageTextField extends StatefulWidget {
  const SendMessageTextField({super.key, required this.personInfo});

  final PersonInfo personInfo;

  @override
  State<SendMessageTextField> createState() => _SendMessageTextFieldState();
}

class _SendMessageTextFieldState extends State<SendMessageTextField> {
  late final TextEditingController controller;
  String? imagePath;
  String? videoPath;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is MessageImageSelected) {
          imagePath = state.imagePath;
        }
        if (state is MessageVideoSelected) {
          videoPath = state.videoPath;
        }
        if (state is MessageMediaSelectionCleared ||
            state is MessageSendingSuccess) {
          imagePath = videoPath = null;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (imagePath != null || videoPath != null)
              Container(
                alignment: Alignment.centerRight,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    if (imagePath != null)
                      Image(
                        image: FileImage(File(imagePath!)),
                        height: context.height / 5,
                      ),
                    if (videoPath != null)
                      SizedBox(
                        height: context.height / 5,
                        width: context.width / 2,
                        child: VideoPlayerWidget(
                          videoPath: videoPath,
                          autoPlay: false,
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        context.read<ChatBloc>().add(
                              ClearMessageSelectedMedia(),
                            );
                      },
                      icon: const Icon(Icons.clear, color: AppColors.red),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                const ViewMediaSelectionOptionsBtn(),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    enabled: state is! MessageSending,
                    decoration: InputDecoration(
                      hintText: AppStrings.typeMessage,
                      suffixIcon: InkWell(
                        onTap: state is MessageSending
                            ? null
                            : () {
                                SendMessageParams sendMessageParams =
                                    SendMessageParams(
                                  receiver: widget.personInfo,
                                  date: DateTime.now().toLocal().toString(),
                                  text: controller.text,
                                  imagePath: imagePath,
                                  videoPath: videoPath,
                                );
                                context
                                    .read<ChatBloc>()
                                    .add(SendMessage(sendMessageParams));
                                controller.clear();
                              },
                        child: state is MessageSending
                            ? const Icon(Icons.more_horiz)
                            : const Icon(Icons.send),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s10),
              ],
            ),
          ],
        );
      },
    );
  }
}
