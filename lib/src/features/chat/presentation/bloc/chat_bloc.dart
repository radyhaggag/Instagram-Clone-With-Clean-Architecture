import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_chat_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/like_message_usecase.dart';
import '../../domain/usecases/like_reply_usecase.dart';
import '../../domain/usecases/reply_to_message_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';

import '../../../../core/utils/app_enums.dart';
import '../../domain/usecases/get_chats_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.getChatUseCase,
    required this.getChatsUseCase,
    required this.sendMessageUseCase,
    required this.likeMessageUseCase,
    required this.replyToMessageUseCase,
    required this.likeReplyUseCase,
    required this.getMessagesUseCase,
  }) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetChats) await _getChats(event, emit);
      if (event is GetChat) await _getChat(event, emit);
      if (event is SendMessage) await _sendMessage(event, emit);
      if (event is ReplyToMessage) await _replyToMessage(event, emit);
      if (event is LikeMessage) await _likeMessage(event, emit);
      if (event is LikeReply) await _likeReply(event, emit);
      if (event is GetMessages) await _getMessages(event, emit);
      if (event is SelectMessageMedia) await _selectMessageMedia(event, emit);
      if (event is ClearMessageSelectedMedia) _clearMessageMedia(event, emit);
    });
    on<SendChatsToBeLoaded>((event, emit) {
      emit(ChatsLoadingSuccess(event.chats));
    });
    on<SendMessagesToBeLoaded>((event, emit) {
      emit(MessagesLoadingSuccess(event.messages));
    });
  }

  void _clearMessageMedia(
    ClearMessageSelectedMedia event,
    Emitter<ChatState> emit,
  ) {
    emit(MessageMediaSelectionCleared());
  }

  final GetChatUseCase getChatUseCase;
  final GetChatsUseCase getChatsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final LikeMessageUseCase likeMessageUseCase;
  final LikeReplyUseCase likeReplyUseCase;
  final ReplyToMessageUseCase replyToMessageUseCase;
  final SendMessageUseCase sendMessageUseCase;

  bool _isDisposed = false;
  @override
  Future<void> close() async {
    super.close();
    _isDisposed = true;
  }

  _getChats(GetChats event, Emitter<ChatState> emit) async {
    emit(ChatsLoading());
    final res = getChatsUseCase(null);
    await res.fold(
      (l) async => emit(ChatsLoadingFailed(l.message)),
      (r) async => r.listen((data) {
        if (_isDisposed) return;

        add(SendChatsToBeLoaded(data));
      }),
    );
  }

  _getMessages(GetMessages event, Emitter<ChatState> emit) async {
    emit(MessagesLoading());
    final res = getMessagesUseCase(event.chatId);
    await res.fold(
      (l) async => emit(MessagesLoadingFailed(l.message)),
      (r) async => r.listen((data) {
        if (_isDisposed) return;
        add(SendMessagesToBeLoaded(data));
      }),
    );
  }

  _getChat(GetChat event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final res = await getChatUseCase(event.chatId);
    res.fold(
      (l) => emit(ChatLoadingFailed(l.message)),
      (r) => emit(ChatLoadingSuccess(r)),
    );
  }

  _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    emit(MessageSending());
    final res = await sendMessageUseCase(event.params);
    res.fold(
      (l) => emit(MessageSendingFailed(l.message)),
      (r) => emit(MessageSendingSuccess(r)),
    );
  }

  _replyToMessage(ReplyToMessage event, Emitter<ChatState> emit) async {
    emit(ReplySending());
    final res = await replyToMessageUseCase(event.params);
    res.fold(
      (l) => emit(ReplySendingFailed(l.message)),
      (r) => emit(ReplySendingSuccess(r)),
    );
  }

  _likeMessage(LikeMessage event, Emitter<ChatState> emit) async {
    emit(LikeMessageSending());
    final res = await likeMessageUseCase(event.params);
    res.fold(
      (l) => emit(LikeMessageSendingFailed(l.message)),
      (r) => emit(LikeMessageSendingSuccess(r)),
    );
  }

  _likeReply(LikeReply event, Emitter<ChatState> emit) async {
    emit(LikeReplySending());
    final res = await likeReplyUseCase(event.params);
    res.fold(
      (l) => emit(LikeReplySendingFailed(l.message)),
      (r) => emit(LikeReplySendingSuccess(r)),
    );
  }

  Future<void> _selectMessageMedia(
    SelectMessageMedia event,
    Emitter<ChatState> emit,
  ) async {
    if (event.mediaType == MediaType.image) {
      final XFile? pickedFile;
      pickedFile = await ImagePicker().pickImage(
        imageQuality: 70,
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(MessageImageSelected(pickedFile.path));
      } else {
        emit(MessageMediaSelectionFailed());
      }
    } else {
      final XFile? pickedFile;
      pickedFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 30),
      );
      if (pickedFile != null) {
        emit(MessageVideoSelected(pickedFile.path));
      } else {
        emit(MessageMediaSelectionFailed());
      }
    }
  }
}
