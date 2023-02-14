import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/entities/person/person.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../datasources/local/base_local_search_datasource.dart';
import '../datasources/remote/base_remote_search_datasource.dart';
import '../../domain/repositories/base_search_repo.dart';

import '../../../../core/error/error_messages.dart';

class SearchRepo implements BaseSearchRepo {
  final BaseRemoteSearchDatasource baseRemoteSearchDatasource;
  final BaseLocalSearchDatasource baseLocalSearchDatasource;
  final BaseCheckInternetConnectivity checkConnection;

  SearchRepo({
    required this.baseRemoteSearchDatasource,
    required this.baseLocalSearchDatasource,
    required this.checkConnection,
  });

  @override
  Future<Either<Failure, List<Post>>> loadSearchPosts() async {
    if (await checkConnection.isConnected()) {
      try {
        final res = await baseRemoteSearchDatasource.loadSearchPosts();
        final posts = res.map((e) => e.toDomain()).toList();
        return Right(posts);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      try {
        final res = baseLocalSearchDatasource.loadSearchPosts();
        return Right(res);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    }
  }

  @override
  Future<Either<Failure, List<Person>>> search(String name) async {
    if (await checkConnection.isConnected()) {
      try {
        final res = await baseRemoteSearchDatasource.search(name);
        final persons = res.map((e) => e.toDomain()).toList();

        return Right(persons);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return const Left(Failure(ErrorMessages.networkConnectionFailed));
    }
  }
}
