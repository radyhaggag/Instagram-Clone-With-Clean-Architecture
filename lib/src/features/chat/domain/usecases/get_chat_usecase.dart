import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/chat.dart';
import '../repositories/base_chat_repo.dart';

class GetChatUseCase extends BaseUseCase<Chat, String> {
  final BaseChatRepo baseChatRepo;

  GetChatUseCase(this.baseChatRepo);

  @override
  Future<Either<Failure, Chat>> call(String params) async {
    return await baseChatRepo.getChat(params);
  }
}
