// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:instagram_clone/src/core/domain/entities/person/person_info.dart';
import 'package:instagram_clone/src/features/chat/domain/entities/message.dart';

part 'chat.g.dart';

@HiveType(typeId: 12)
class Chat extends HiveObject with EquatableMixin {
  @HiveField(0)
  final PersonInfo personInfo;
  @HiveField(1)
  final Message? lastMessage;
  @HiveField(2)
  final String chatId;
  Chat({
    required this.personInfo,
    required this.lastMessage,
    required this.chatId,
  });

  @override
  List<Object?> get props => [personInfo, lastMessage, chatId];

  Chat copyWith({
    PersonInfo? personInfo,
    Message? lastMessage,
    String? chatId,
  }) {
    return Chat(
      personInfo: personInfo ?? this.personInfo,
      lastMessage: lastMessage ?? this.lastMessage,
      chatId: chatId ?? this.chatId,
    );
  }
}
