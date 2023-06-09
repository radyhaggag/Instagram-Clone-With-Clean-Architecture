import '../../../domain/entities/chat.dart';

abstract class BaseLocalChatDatasource {
  List<Chat>? getChats();
  Chat? getChat(String chatId);
}
