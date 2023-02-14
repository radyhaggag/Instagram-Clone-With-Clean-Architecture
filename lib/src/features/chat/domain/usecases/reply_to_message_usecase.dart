import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/message.dart';
import '../repositories/base_chat_repo.dart';
import 'send_message_usecase.dart';

class ReplyToMessageUseCase extends BaseUseCase<Message, ReplyToMessageParams> {
  ReplyToMessageUseCase(this.baseChatRepo);

  final BaseChatRepo baseChatRepo;

  @override
  Future<Either<Failure, Message>> call(ReplyToMessageParams params) async {
    return await baseChatRepo.replyToMessage(params);
  }
}

class ReplyToMessageParams extends Equatable {
  const ReplyToMessageParams({
    required this.messageId,
    required this.message,
  });

  final String messageId;
  final SendMessageParams message;

  @override
  List<Object?> get props => [message, messageId];
}
