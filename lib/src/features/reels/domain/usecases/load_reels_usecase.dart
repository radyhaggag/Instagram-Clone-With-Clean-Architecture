import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/reel.dart';
import '../repositories/base_reels_repo.dart';

class LoadReelsUseCase extends BaseUseCase<List<Reel>, void> {
  final BaseReelsRepo baseReelsRepo;

  LoadReelsUseCase(this.baseReelsRepo);

  @override
  Future<Either<Failure, List<Reel>>> call(void params) async {
    return await baseReelsRepo.loadReels();
  }
}
