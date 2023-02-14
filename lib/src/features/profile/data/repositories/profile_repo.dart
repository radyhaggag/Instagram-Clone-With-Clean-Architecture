import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../domain/entities/profile.dart';

import '../../../../core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/network/connectivity_checker.dart';
import '../../domain/repositories/base_profile_repo.dart';
import '../datasources/local/base_local_profile_datasource.dart';
import '../datasources/remote/base_remote_profile_datasource.dart';

class ProfileRepo implements BaseProfileRepo {
  final BaseRemoteProfileDatasource baseRemoteProfileDatasource;
  final BaseLocalProfileDatasource baseLocalProfileDatasource;
  final BaseCheckInternetConnectivity baseCheckInternetConnectivity;
  ProfileRepo({
    required this.baseRemoteProfileDatasource,
    required this.baseLocalProfileDatasource,
    required this.baseCheckInternetConnectivity,
  });

  @override
  Future<Either<Failure, Profile>> getProfile(String uid) async {
    if (await baseCheckInternetConnectivity.isConnected()) {
      try {
        final profile = await baseRemoteProfileDatasource.getProfile(uid);
        return Right(profile);
      } catch (e) {
        final failure = ErrorHandler.handle(e).failure;
        return Left(failure);
      }
    } else {
      try {
        final profile = baseLocalProfileDatasource.getProfile(uid);
        return Right(profile);
      } catch (e) {
        final failure = ErrorHandler.handle(e).failure;
        return Left(failure);
      }
    }
  }

  @override
  Future<Either<Failure, List<Person>>> getFollowers(String uid) async {
    try {
      final res = await baseRemoteProfileDatasource.getFollowers(uid);
      final followers = res.map((e) => e.toDomain()).toList();
      return Right(followers);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Person>>> getFollowings(String uid) async {
    try {
      final res = await baseRemoteProfileDatasource.getFollowings(uid);
      final followings = res.map((e) => e.toDomain()).toList();
      return Right(followings);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, String>> follow(String personUid) async {
    try {
      final res = await baseRemoteProfileDatasource.follow(personUid);
      return Right(res);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, String>> unFollow(String personUid) async {
    try {
      final res = await baseRemoteProfileDatasource.unFollow(personUid);
      return Right(res);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, String>> updateProfile(PersonInfo params) async {
    try {
      final res = await baseRemoteProfileDatasource.updateProfile(params);
      return Right(res);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final res = await baseRemoteProfileDatasource.signOut();
      return Right(res);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }
}
