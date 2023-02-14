import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/media_query.dart';

import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../bloc/chat_bloc.dart';

class ViewMediaSelectionOptionsBtn extends StatelessWidget {
  const ViewMediaSelectionOptionsBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        RelativeRect menuPosition = RelativeRect.fromLTRB(
          0,
          context.height - 180,
          context.width,
          180,
        );

        showMenu(
          context: context,
          color: Colors.transparent,
          elevation: 0.0,
          position: menuPosition,
          constraints: const BoxConstraints(maxWidth: AppSize.s50),
          items: [
            PopupMenuItem(
              onTap: () {
                context.read<ChatBloc>().add(const SelectMessageMedia(
                      mediaType: MediaType.image,
                    ));
              },
              padding: EdgeInsets.zero,
              child: const Icon(Icons.perm_media_outlined),
            ),
            PopupMenuItem(
              onTap: () {
                context.read<ChatBloc>().add(const SelectMessageMedia(
                      mediaType: MediaType.video,
                    ));
              },
              padding: EdgeInsets.zero,
              child: const Icon(Icons.video_file_outlined),
            ),
          ],
        );
      },
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.link),
    );
  }
}
