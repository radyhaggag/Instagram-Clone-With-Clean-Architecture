import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

import '../repositories/base_profile_repo.dart';

class SignOutUseCase extends BaseUseCase<void, void> {
  final BaseProfileRepo baseProfileRepo;

  SignOutUseCase(this.baseProfileRepo);

  @override
  Future<Either<Failure, void>> call(void params) async {
    return await baseProfileRepo.signOut();
  }
}
