import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/reel.dart';
import '../repositories/base_reels_repo.dart';

class GetReelUseCase extends BaseUseCase<Reel, GetReelParams> {
  final BaseReelsRepo basePostRepo;

  GetReelUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Reel>> call(GetReelParams params) {
    return basePostRepo.getReel(params);
  }
}

class GetReelParams extends Equatable {
  final String reelId;
  final String publisherId;

  const GetReelParams({
    required this.reelId,
    required this.publisherId,
  });

  @override
  List<Object> get props => [reelId, publisherId];
}
