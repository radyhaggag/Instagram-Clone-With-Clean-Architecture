import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/person/person.dart' as u;
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class SignupUseCase implements BaseUseCase<u.Person, SignupParams> {
  final BaseAuthRepository baseAuthRepository;

  SignupUseCase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, u.Person>> call(SignupParams params) {
    return baseAuthRepository.signUp(params);
  }
}

class SignupParams extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String username;

  const SignupParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.username,
  });

  @override
  List<Object> get props => [email, password, username, fullName];
}
