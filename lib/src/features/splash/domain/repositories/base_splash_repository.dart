import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/error/failure.dart';

abstract class BaseSplashRepository {
  Future<Either<Failure, Person?>> getCurrentUser();
}
