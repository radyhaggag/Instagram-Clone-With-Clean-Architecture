import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class ResetPasswordUseCase implements BaseUseCase<bool, String> {
  final BaseAuthRepository baseAuthRepository;

  ResetPasswordUseCase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, bool>> call(String params) {
    return baseAuthRepository.resetPassword(params);
  }
}
