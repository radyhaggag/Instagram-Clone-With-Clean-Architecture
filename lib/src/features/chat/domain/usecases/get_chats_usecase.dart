import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/chat.dart';
import '../repositories/base_chat_repo.dart';

class GetChatsUseCase extends StreamUseCase<List<Chat>, void> {
  final BaseChatRepo baseChatRepo;

  GetChatsUseCase(this.baseChatRepo);

  @override
  Either<Failure, Stream<List<Chat>>> call(void params) {
    return baseChatRepo.getChats();
  }
}
