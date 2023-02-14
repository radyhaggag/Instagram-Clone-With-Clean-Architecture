import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart' as u;
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class LoginWithFacebookUseCase implements BaseUseCase<u.Person, NoParams> {
  final BaseAuthRepository baseAuthRepository;

  LoginWithFacebookUseCase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, u.Person>> call(NoParams params) {
    return baseAuthRepository.loginWithFacebook();
  }
}
