import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class DeletePostUseCase extends BaseUseCase<bool, String> {
  final BasePostRepo basePostRepo;

  DeletePostUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, bool>> call(String params) {
    return basePostRepo.deletePost(params);
  }
}
