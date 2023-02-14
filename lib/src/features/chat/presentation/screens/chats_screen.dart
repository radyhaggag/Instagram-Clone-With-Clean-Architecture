import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../bloc/chat_bloc.dart';

import '../../domain/entities/chat.dart';
import '../widgets/last_message_caption.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.chats,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatsLoadingSuccess && state.chats.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (context, index) => ChatTile(
                chat: state.chats[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s10,
              ),
              itemCount: state.chats.length,
            );
          } else if (state is ChatsLoadingSuccess && state.chats.isEmpty) {
            return const Center(child: Text(AppStrings.noMessages));
          } else if (state is ChatsLoadingFailed) {
            return Center(child: Text(state.message));
          } else {
            return ListView.separated(
              itemBuilder: (context, index) => const ChatTileShimmer(),
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s10,
              ),
              itemCount: 10,
            );
          }
        },
      ),
    );
  }
}

class ChatTileShimmer extends StatelessWidget {
  const ChatTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleShimmer(radius: AppSize.s30),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LightShimmer(width: AppSize.s100, height: AppSize.s15),
          SizedBox(height: AppSize.s10),
          LightShimmer(width: AppSize.s80, height: AppSize.s13),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.chatWithScreen,
          arguments: chat.personInfo,
        );
      },
      leading: CircleImageAvatar(
        radius: AppSize.s30,
        personInfo: chat.personInfo,
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewPublisherNameWidget(
            name: chat.personInfo.name,
            personInfo: chat.personInfo,
            disableNavigate: true,
            addPadding: false,
          ),
          const SizedBox(height: AppSize.s10),
          if (chat.lastMessage != null)
            LastMessageCaption(message: chat.lastMessage!),
        ],
      ),
    );
  }
}
