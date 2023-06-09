import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile.dart';

import '../repositories/base_profile_repo.dart';

class GetProfileUseCase extends BaseUseCase<Profile, String> {
  final BaseProfileRepo baseProfileRepo;

  GetProfileUseCase(this.baseProfileRepo);

  @override
  Future<Either<Failure, Profile>> call(String params) async {
    return await baseProfileRepo.getProfile(params);
  }
}
