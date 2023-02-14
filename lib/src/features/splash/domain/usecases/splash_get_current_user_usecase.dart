import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_splash_repository.dart';

class SplashGetCurrentUserUseCase extends BaseUseCase<Person?, NoParams> {
  final BaseSplashRepository baseSplashRepository;

  SplashGetCurrentUserUseCase({required this.baseSplashRepository});

  @override
  Future<Either<Failure, Person?>> call(NoParams params) {
    return baseSplashRepository.getCurrentUser();
  }
}
