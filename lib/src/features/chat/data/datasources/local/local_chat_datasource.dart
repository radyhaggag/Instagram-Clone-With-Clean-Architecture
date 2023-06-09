import '../../../../../core/utils/app_boxes.dart';
import '../../../domain/entities/chat.dart';

import 'base_local_chat_datasource.dart';

class LocalChatDatasource implements BaseLocalChatDatasource {
  @override
  Chat? getChat(String chatId) {
    Chat? chat;
    for (var e in AppBoxes.chatBox.values) {
      if (e.chatId == chatId) {
        chat = e;
        break;
      }
    }
    return chat;
  }

  @override
  List<Chat>? getChats() {
    List<Chat>? chats = AppBoxes.chatBox.values.map((e) => e).toList();
    return chats;
  }
}
