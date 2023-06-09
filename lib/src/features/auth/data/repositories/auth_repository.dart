import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/app_boxes.dart';
import '../../domain/repositories/base_auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../datasources/remote/base_remote_auth_datasource.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseRemoteAuthDataSource baseRemoteAuthDataSource;

  AuthRepository({required this.baseRemoteAuthDataSource});

  @override
  Future<Either<Failure, Person>> login(LoginParams params) async {
    try {
      final person = await baseRemoteAuthDataSource.login(params);
      AppBoxes.personBox.put(AppBoxesKeys.person, person.toDomain());
      return Right(person.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Person>> loginWithFacebook() async {
    try {
      final person = await baseRemoteAuthDataSource.loginWithFacebook();
      AppBoxes.personBox.put(AppBoxesKeys.person, person.toDomain());
      return Right(person.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Person>> signUp(SignupParams signupParams) async {
    try {
      final person = await baseRemoteAuthDataSource.signUp(signupParams);
      AppBoxes.personBox.put(AppBoxesKeys.person, person.toDomain());
      return Right(person.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String email) async {
    try {
      await baseRemoteAuthDataSource.resetPassword(email);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
