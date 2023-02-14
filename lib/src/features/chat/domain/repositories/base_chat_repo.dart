import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

import '../usecases/like_message_usecase.dart';
import '../usecases/like_reply_usecase.dart';
import '../usecases/reply_to_message_usecase.dart';
import '../usecases/send_message_usecase.dart';

abstract class BaseChatRepo {
  Future<Either<Failure, Message>> sendMessage(SendMessageParams params);
  Future<Either<Failure, Message>> likeMessage(LikeMessageParams params);
  Future<Either<Failure, Message>> likeReply(LikeReplyParams params);
  Future<Either<Failure, Message>> replyToMessage(ReplyToMessageParams params);
  Either<Failure, Stream<List<Chat>>> getChats();
  Future<Either<Failure, Chat>> getChat(String chatId);
  Either<Failure, Stream<List<Message>>> getMessages(String chatId);
}
