part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatsLoading extends ChatState {}

class ChatsLoadingSuccess extends ChatState {
  final List<Chat> chats;

  const ChatsLoadingSuccess(this.chats);
}

class ChatsLoadingFailed extends ChatState {
  final String message;

  const ChatsLoadingFailed(this.message);
}

class ChatLoading extends ChatState {}

class ChatLoadingSuccess extends ChatState {
  final Chat chat;

  const ChatLoadingSuccess(this.chat);
}

class ChatLoadingFailed extends ChatState {
  final String message;

  const ChatLoadingFailed(this.message);
}

class MessageSending extends ChatState {}

class MessageSendingSuccess extends ChatState {
  final Message message;

  const MessageSendingSuccess(this.message);
}

class MessageSendingFailed extends ChatState {
  final String message;

  const MessageSendingFailed(this.message);
}

class ReplySending extends ChatState {}

class ReplySendingSuccess extends ChatState {
  final Message message;

  const ReplySendingSuccess(this.message);
}

class ReplySendingFailed extends ChatState {
  final String message;

  const ReplySendingFailed(this.message);
}

class LikeMessageSending extends ChatState {}

class LikeMessageSendingSuccess extends ChatState {
  final Message message;

  const LikeMessageSendingSuccess(this.message);
}

class LikeMessageSendingFailed extends ChatState {
  final String message;

  const LikeMessageSendingFailed(this.message);
}

class LikeReplySending extends ChatState {}

class LikeReplySendingSuccess extends ChatState {
  final Message message;

  const LikeReplySendingSuccess(this.message);
}

class LikeReplySendingFailed extends ChatState {
  final String message;

  const LikeReplySendingFailed(this.message);
}

class MessagesLoading extends ChatState {}

class MessagesLoadingSuccess extends ChatState {
  final List<Message> messages;

  const MessagesLoadingSuccess(this.messages);
}

class MessagesLoadingFailed extends ChatState {
  final String message;

  const MessagesLoadingFailed(this.message);
}

class MessageImageSelected extends ChatState {
  final String imagePath;

  const MessageImageSelected(this.imagePath);
}

class MessageVideoSelected extends ChatState {
  final String videoPath;

  const MessageVideoSelected(this.videoPath);
}

class MessageMediaSelectionFailed extends ChatState {}

class MessageMediaSelectionCleared extends ChatState {}
