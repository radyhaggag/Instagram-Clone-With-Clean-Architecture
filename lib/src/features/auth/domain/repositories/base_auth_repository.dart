import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart' as u;
import '../../../../core/error/failure.dart';
import '../usecases/login_usecase.dart';
import '../usecases/signup_usecase.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, u.Person>> login(LoginParams loginParams);
  Future<Either<Failure, u.Person>> loginWithFacebook();
  Future<Either<Failure, u.Person>> signUp(SignupParams signupParams);
  Future<Either<Failure, bool>> resetPassword(String email);
}
