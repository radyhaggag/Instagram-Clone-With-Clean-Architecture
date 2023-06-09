import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../widgets/send_message_text_field.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../../domain/entities/message.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/message_widget.dart';

class ChatWithScreen extends StatefulWidget {
  const ChatWithScreen({super.key, required this.personInfo});

  final PersonInfo personInfo;

  @override
  State<ChatWithScreen> createState() => _ChatWithScreenState();
}

class _ChatWithScreenState extends State<ChatWithScreen> {
  List<Message>? messages;
  late final ScrollController scrollController;

  @override
  initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void _scrollToEnd() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + AppSize.s50,
        duration: const Duration(
          milliseconds: AppConstants.chatAnimationDuration,
        ),
        curve: Curves.bounceIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleImageAvatar(personInfo: widget.personInfo),
            const SizedBox(width: AppSize.s10),
            Text(
              widget.personInfo.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is MessagesLoadingSuccess) {
            if (state.messages.length != messages?.length &&
                state.messages.isNotEmpty) {
              if (state.messages.last.sender.uid ==
                  FirebaseAuth.instance.currentUser?.uid) {
                _scrollToEnd();
              }
            }
            messages = state.messages;
          }
          if (state is MessagesLoadingFailed) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is MessageSendingFailed) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
        },
        buildWhen: (previous, current) {
          return current is MessagesLoadingSuccess;
        },
        builder: (context, state) {
          if (messages != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      GlobalKey key = GlobalKey(); // declare a global key

                      return MessageWidget(
                        message: messages![index],
                        globalKey: key,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: AppSize.s10,
                    ),
                    itemCount: messages!.length,
                  ),
                ),
                SendMessageTextField(personInfo: widget.personInfo),
                const SizedBox(height: AppSize.s10),
              ],
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return const Align(
                    alignment: Alignment.centerRight,
                    child: MessageShimmer(),
                  );
                }
                return const Align(
                  alignment: Alignment.centerLeft,
                  child: MessageShimmer(),
                );
              },
              itemCount: 15,
            );
          }
        },
      ),
    );
  }
}

class MessageShimmer extends StatelessWidget {
  const MessageShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s10),
      child: LightShimmer(
        width: context.width / 2,
        height: AppSize.s35,
        borderRadius: BorderRadius.circular(AppSize.s5),
      ),
    );
  }
}
