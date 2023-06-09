import '../../../../core/domain/mappers/mappers.dart';
import 'message_model.dart';
import '../../domain/mappers/mappers.dart';

import '../../../../core/models/person/person_info_model.dart';
import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.personInfo,
    required super.lastMessage,
    required super.chatId,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) => ChatModel(
        chatId: map['chatId'],
        lastMessage: MessageModel.fromMap(map['lastMessage']),
        personInfo: PersonInfoModel.fromMap(map['personInfo']),
      );

  Map<String, dynamic> toMap() => {
        'chatId': chatId,
        'lastMessage': lastMessage?.fromDomain().toMap(),
        'personInfo': personInfo.fromDomain().toMap(),
      };
}
