import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_profile_repo.dart';

class FollowProfileUseCase extends BaseUseCase<String, String> {
  FollowProfileUseCase(this.baseProfileRepo);

  final BaseProfileRepo baseProfileRepo;

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await baseProfileRepo.follow(params);
  }
}
