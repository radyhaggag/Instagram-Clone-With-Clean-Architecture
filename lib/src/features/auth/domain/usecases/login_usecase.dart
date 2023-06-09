import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/person/person.dart' as u;
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class LoginUseCase implements BaseUseCase<u.Person, LoginParams> {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase({required this.baseAuthRepository});
  @override
  Future<Either<Failure, u.Person>> call(LoginParams params) {
    return baseAuthRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
