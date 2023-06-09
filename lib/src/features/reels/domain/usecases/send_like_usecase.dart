import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/reel.dart';
import '../repositories/base_reels_repo.dart';

class SendReelLikeUseCase extends BaseUseCase<Reel, ReelLikeParams> {
  final BaseReelsRepo baseReelsRepo;

  SendReelLikeUseCase(this.baseReelsRepo);

  @override
  Future<Either<Failure, Reel>> call(ReelLikeParams params) async {
    return await baseReelsRepo.sendLike(params);
  }
}

class ReelLikeParams extends Equatable {
  final String reelId;
  final String publisherUid;

  const ReelLikeParams({required this.reelId, required this.publisherUid});

  @override
  List<Object> get props => [reelId, publisherUid];
}
