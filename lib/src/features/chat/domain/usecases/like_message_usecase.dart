import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/message.dart';
import '../repositories/base_chat_repo.dart';

class LikeMessageUseCase extends BaseUseCase<Message, LikeMessageParams> {
  LikeMessageUseCase(this.baseChatRepo);

  final BaseChatRepo baseChatRepo;

  @override
  Future<Either<Failure, Message>> call(LikeMessageParams params) async {
    return await baseChatRepo.likeMessage(params);
  }
}

class LikeMessageParams extends Equatable {
  final String messageId;
  final String receiverUid;

  const LikeMessageParams({
    required this.messageId,
    required this.receiverUid,
  });

  @override
  List<Object> get props => [messageId, receiverUid];
}
