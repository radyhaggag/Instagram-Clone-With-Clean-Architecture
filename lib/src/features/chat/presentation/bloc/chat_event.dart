part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChats extends ChatEvent {}

class GetChat extends ChatEvent {
  final String chatId;

  const GetChat(this.chatId);
}

class SendMessage extends ChatEvent {
  final SendMessageParams params;

  const SendMessage(this.params);
}

class ReplyToMessage extends ChatEvent {
  final ReplyToMessageParams params;

  const ReplyToMessage(this.params);
}

class LikeMessage extends ChatEvent {
  final LikeMessageParams params;

  const LikeMessage(this.params);
}

class LikeReply extends ChatEvent {
  final LikeReplyParams params;

  const LikeReply(this.params);
}

class GetMessages extends ChatEvent {
  final String chatId;

  const GetMessages(this.chatId);
}

class SendChatsToBeLoaded extends ChatEvent {
  final List<Chat> chats;

  const SendChatsToBeLoaded(this.chats);
}

class SendMessagesToBeLoaded extends ChatEvent {
  final List<Message> messages;

  const SendMessagesToBeLoaded(this.messages);
}

class SelectMessageMedia extends ChatEvent {
  final MediaType mediaType;

  const SelectMessageMedia({required this.mediaType});
}

class ClearMessageSelectedMedia extends ChatEvent {}
