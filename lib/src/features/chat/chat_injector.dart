import '../../config/container_injector.dart';
import 'data/datasources/remote/remote_chat_datasource.dart';
import 'domain/usecases/get_chats_usecase.dart';
import 'domain/usecases/get_messages_usecase.dart';
import 'domain/usecases/like_message_usecase.dart';
import 'domain/usecases/reply_to_message_usecase.dart';
import 'domain/usecases/send_message_usecase.dart';
import 'presentation/bloc/chat_bloc.dart';

import 'data/datasources/local/base_local_chat_datasource.dart';
import 'data/datasources/local/local_chat_datasource.dart';
import 'data/datasources/remote/base_remote_chat_datasource.dart';
import 'data/repositories/chat_repo.dart';
import 'domain/repositories/base_chat_repo.dart';
import 'domain/usecases/get_chat_usecase.dart';
import 'domain/usecases/like_reply_usecase.dart';

void initChat() {
  // add datasources
  sl.registerLazySingleton<BaseRemoteChatDatasource>(
    () => RemoteChatDatasource(
        firebaseFirestore: sl(),
        auth: sl(),
        firestoreManager: sl(),
        storage: sl()),
  );
  sl.registerLazySingleton<BaseLocalChatDatasource>(
    () => LocalChatDatasource(),
  );
  // add repos
  sl.registerLazySingleton<BaseChatRepo>(
    () => ChatRepo(
      baseLocalChatDatasource: sl(),
      baseRemoteChatDatasource: sl(),
      checkInternetConnectivity: sl(),
    ),
  );
  // add usecases
  sl.registerLazySingleton<GetChatsUseCase>(
    () => GetChatsUseCase(sl()),
  );
  sl.registerLazySingleton<GetChatUseCase>(
    () => GetChatUseCase(sl()),
  );
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(sl()),
  );
  sl.registerLazySingleton<LikeMessageUseCase>(
    () => LikeMessageUseCase(sl()),
  );
  sl.registerLazySingleton<LikeReplyUseCase>(
    () => LikeReplyUseCase(sl()),
  );
  sl.registerLazySingleton<ReplyToMessageUseCase>(
    () => ReplyToMessageUseCase(sl()),
  );
  sl.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(sl()),
  );

  // add bloc
  sl.registerFactory<ChatBloc>(
    () => ChatBloc(
      getChatUseCase: sl(),
      getChatsUseCase: sl(),
      sendMessageUseCase: sl(),
      likeMessageUseCase: sl(),
      replyToMessageUseCase: sl(),
      likeReplyUseCase: sl(),
      getMessagesUseCase: sl(),
    ),
  );
}
