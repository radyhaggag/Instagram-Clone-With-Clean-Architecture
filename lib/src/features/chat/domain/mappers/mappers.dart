import '../../data/models/message_model.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

import '../../data/models/chat_model.dart';

extension MessageExtension on Message {
  MessageModel fromDomain() => MessageModel(
        date: date,
        sender: sender,
        receiver: receiver,
        likes: likes,
        replies: replies,
        id: id,
        text: text,
        imageUrl: imageUrl,
        videoUrl: videoUrl,
      );
}

extension MessageModelExtension on MessageModel {
  Message toDomain() => Message(
        date: date,
        sender: sender,
        receiver: receiver,
        likes: likes,
        replies: replies,
        id: id,
        text: text,
        imageUrl: imageUrl,
        videoUrl: videoUrl,
      );
}

extension ChatModelExtension on ChatModel {
  Chat toDomain() => Chat(
        lastMessage: lastMessage,
        personInfo: personInfo,
        chatId: chatId,
      );
}

extension ChatExtension on Chat {
  ChatModel fromDomain() => ChatModel(
        lastMessage: lastMessage,
        personInfo: personInfo,
        chatId: chatId,
      );
}
