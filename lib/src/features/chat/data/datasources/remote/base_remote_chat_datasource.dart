import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../../../domain/usecases/reply_to_message_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';

import '../../../domain/usecases/like_message_usecase.dart';
import '../../../domain/usecases/like_reply_usecase.dart';

abstract class BaseRemoteChatDatasource {
  Stream<List<ChatModel>> getChats();
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<ChatModel> getChat(String chatId);
  Future<MessageModel> sendMessage(SendMessageParams params);
  Future<MessageModel> likeMessage(LikeMessageParams params);
  Future<MessageModel> likeReply(LikeReplyParams params);
  Future<MessageModel> replyToMessage(ReplyToMessageParams params);
}
