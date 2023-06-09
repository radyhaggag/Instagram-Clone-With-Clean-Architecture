import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/entities/person/person_info.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/message.dart';
import '../repositories/base_chat_repo.dart';

class SendMessageUseCase extends BaseUseCase<Message, SendMessageParams> {
  SendMessageUseCase(this.baseChatRepo);

  final BaseChatRepo baseChatRepo;

  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) async {
    return await baseChatRepo.sendMessage(params);
  }
}

class SendMessageParams extends Equatable {
  const SendMessageParams({
    required this.receiver,
    this.text,
    this.imagePath,
    this.videoPath,
    required this.date,
  });

  final String date;
  final String? imagePath;
  final PersonInfo receiver;
  final String? text;
  final String? videoPath;

  @override
  List<Object?> get props {
    return [receiver, text, imagePath, videoPath, date];
  }
}
