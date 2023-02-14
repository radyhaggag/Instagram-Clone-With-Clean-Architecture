import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/message.dart';
import '../repositories/base_chat_repo.dart';

class GetMessagesUseCase extends StreamUseCase<List<Message>, String> {
  final BaseChatRepo baseChatRepo;

  GetMessagesUseCase(this.baseChatRepo);

  @override
  Either<Failure, Stream<List<Message>>> call(String params) {
    return baseChatRepo.getMessages(params);
  }
}
