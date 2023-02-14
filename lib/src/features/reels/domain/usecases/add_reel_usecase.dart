import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/reel.dart';
import '../repositories/base_reels_repo.dart';

class AddReelUsecase extends BaseUseCase<Reel, ReelParams> {
  final BaseReelsRepo baseReelRepo;

  AddReelUsecase(this.baseReelRepo);

  @override
  Future<Either<Failure, Reel>> call(ReelParams params) {
    return baseReelRepo.addReel(params);
  }
}

class ReelParams extends Equatable {
  final String videoPath;
  final String? reelText;
  final String reelDate;

  const ReelParams({
    required this.videoPath,
    required this.reelText,
    required this.reelDate,
  });

  @override
  List<Object?> get props => [videoPath, reelText, reelDate];
}
