import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../../domain/repositories/base_splash_repository.dart';
import '../datasources/local/base_local_splash_data_source.dart';
import '../datasources/remote/base_remote_splash_data_source.dart';

class SplashRepository implements BaseSplashRepository {
  final BaseRemoteSplashDataSource baseRemoteSplashDataSource;
  final BaseLocalSplashDataSource baseLocalSplashDataSource;
  final BaseCheckInternetConnectivity checkInternetConnectivity;

  SplashRepository({
    required this.baseRemoteSplashDataSource,
    required this.baseLocalSplashDataSource,
    required this.checkInternetConnectivity,
  });

  @override
  Future<Either<Failure, Person?>> getCurrentUser() async {
    if (await checkInternetConnectivity.isConnected()) {
      try {
        final person = await baseRemoteSplashDataSource.getCurrentUser();
        if (person != null) {
          return Right(person.toDomain());
        } else {
          return const Right(null);
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      final person = baseLocalSplashDataSource.getCurrentUser();
      return Right(person);
    }
  }
}
