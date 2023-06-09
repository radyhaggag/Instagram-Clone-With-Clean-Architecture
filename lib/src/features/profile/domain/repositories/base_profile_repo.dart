import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile.dart';

import '../../../../core/domain/entities/person/person_info.dart';

abstract class BaseProfileRepo {
  Future<Either<Failure, Profile>> getProfile(String uid);
  Future<Either<Failure, List<Person>>> getFollowings(String uid);
  Future<Either<Failure, List<Person>>> getFollowers(String uid);
  Future<Either<Failure, String>> follow(String personUid);
  Future<Either<Failure, String>> unFollow(String personUid);
  Future<Either<Failure, String>> updateProfile(PersonInfo params);
  Future<Either<Failure, void>> signOut();
}
