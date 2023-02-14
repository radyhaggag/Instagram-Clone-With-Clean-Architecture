import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../datasources/remote/base_remote_chat_datasource.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/chat.dart';
import '../../domain/mappers/mappers.dart';
import '../../domain/repositories/base_chat_repo.dart';
import '../../domain/usecases/like_message_usecase.dart';
import '../../domain/usecases/like_reply_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/reply_to_message_usecase.dart';

import '../datasources/local/base_local_chat_datasource.dart';

class ChatRepo implements BaseChatRepo {
  ChatRepo({
    required this.checkInternetConnectivity,
    required this.baseRemoteChatDatasource,
    required this.baseLocalChatDatasource,
  });

  final BaseLocalChatDatasource baseLocalChatDatasource;
  final BaseRemoteChatDatasource baseRemoteChatDatasource;
  final BaseCheckInternetConnectivity checkInternetConnectivity;

  @override
  Future<Either<Failure, Chat>> getChat(String chatId) async {
    try {
      if (await checkInternetConnectivity.isConnected()) {
        final result = await baseRemoteChatDatasource.getChat(chatId);
        return Right(result.toDomain());
      } else {
        final result = baseLocalChatDatasource.getChat(chatId);
        if (result == null) {
          return const Left(Failure(ErrorMessages.networkConnectionFailed));
        }
        return Right(result);
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Either<Failure, Stream<List<Chat>>> getChats() {
    try {
      return Right(baseRemoteChatDatasource.getChats());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Either<Failure, Stream<List<Message>>> getMessages(String chatId) {
    try {
      return Right(baseRemoteChatDatasource.getMessages(chatId));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Message>> likeMessage(LikeMessageParams params) async {
    try {
      final result = await baseRemoteChatDatasource.likeMessage(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Message>> replyToMessage(
      ReplyToMessageParams params) async {
    try {
      final result = await baseRemoteChatDatasource.replyToMessage(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(SendMessageParams params) async {
    try {
      final result = await baseRemoteChatDatasource.sendMessage(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Message>> likeReply(LikeReplyParams params) async {
    try {
      final result = await baseRemoteChatDatasource.likeReply(params);
      return Right(result.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
