import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/message.dart';
import '../repositories/base_chat_repo.dart';

class LikeReplyUseCase extends BaseUseCase<Message, LikeReplyParams> {
  LikeReplyUseCase(this.baseChatRepo);

  final BaseChatRepo baseChatRepo;

  @override
  Future<Either<Failure, Message>> call(LikeReplyParams params) async {
    return await baseChatRepo.likeReply(params);
  }
}

class LikeReplyParams extends Equatable {
  final String messageId;
  final String replyId;
  final String receiverUid;

  const LikeReplyParams({
    required this.messageId,
    required this.receiverUid,
    required this.replyId,
  });

  @override
  List<Object> get props => [messageId, receiverUid, replyId];
}
