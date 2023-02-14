import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_reels_repo.dart';

class DeleteReelUseCase extends BaseUseCase<bool, String> {
  final BaseReelsRepo baseReelRepo;

  DeleteReelUseCase(this.baseReelRepo);

  @override
  Future<Either<Failure, bool>> call(String params) {
    return baseReelRepo.deleteReel(params);
  }
}
