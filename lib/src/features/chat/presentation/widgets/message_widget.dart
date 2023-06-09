import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../core/widgets/video_player_widget.dart';
import '../../domain/usecases/like_message_usecase.dart';

import '../../domain/entities/message.dart';
import '../bloc/chat_bloc.dart';
import 'text_message_widget.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.globalKey,
  });

  final GlobalKey globalKey;
  final Message message;

  void _onMessagePressed(BuildContext context, bool isSender) {
    final likersUid = message.likes.map((e) => e.uid);
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    final renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    RelativeRect receiverMenuPosition = RelativeRect.fromLTRB(
      renderBox.size.width + 30,
      position.dy,
      context.width - renderBox.size.width,
      position.dy,
    );
    RelativeRect senderMenuPosition = RelativeRect.fromLTRB(
      context.width - renderBox.size.width - 50,
      position.dy,
      renderBox.size.width + 20,
      position.dy,
    );

    showMenu(
      context: context,
      position: isSender ? senderMenuPosition : receiverMenuPosition,
      constraints: const BoxConstraints(
        maxWidth: AppSize.s40,
        maxHeight: AppSize.s40,
      ),
      color: Colors.transparent,
      shape: const CircleBorder(),
      elevation: 0.0,
      items: [
        PopupMenuItem(
          onTap: () {
            LikeMessageParams likeMessageParams = LikeMessageParams(
              messageId: message.id,
              receiverUid: message.receiver.uid,
            );
            context.read<ChatBloc>().add(LikeMessage(likeMessageParams));
          },
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
          height: AppSize.s5,
          child: ImageIcon(
            AssetImage(
              likersUid.contains(currentUid)
                  ? AppIcons.like
                  : AppIcons.likeOutline,
            ),
            color: likersUid.contains(currentUid)
                ? AppColors.red
                : AppColors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSender =
        message.sender.uid == FirebaseAuth.instance.currentUser?.uid;
    if (message.text != null) {
      return GestureDetector(
        onLongPress: () => _onMessagePressed(context, isSender),
        child: TextMessageWidget(
          isSender: isSender,
          globalKey: globalKey,
          message: message,
        ),
      );
    } else if (message.imageUrl != null) {
      return GestureDetector(
        onLongPress: () => _onMessagePressed(context, isSender),
        child: BubbleNormalImage(
          id: message.id,
          image: ImageViewBuilder(imageUrl: message.imageUrl!),
          color: isSender ? AppColors.grape : AppColors.blackWith40Opacity,
          tail: false,
          isSender: isSender,
        ),
      );
    } else {
      return GestureDetector(
        onLongPress: () => _onMessagePressed(context, isSender),
        child: BubbleNormalImage(
          id: message.id,
          image: VideoPlayerWidget(
            videoUrl: message.videoUrl,
            autoPlay: false,
          ),
          color: isSender ? AppColors.grape : AppColors.blackWith40Opacity,
          tail: false,
          isSender: isSender,
        ),
      );
    }
  }
}
