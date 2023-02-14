import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/domain/entities/story/stories.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/models/post/post_model.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../../domain/repositories/base_home_repo.dart';
import '../datasources/local/base_local_home_datasource.dart';
import '../datasources/remote/base_remote_home_datasource.dart';

class HomeRepo implements BaseHomeRepo {
  final BaseRemoteHomeDatasource baseRemoteHomeDatasource;
  final BaseLocalHomeDatasource baseLocalHomeDatasource;
  final BaseCheckInternetConnectivity baseCheckInternetConnectivity;

  HomeRepo({
    required this.baseRemoteHomeDatasource,
    required this.baseLocalHomeDatasource,
    required this.baseCheckInternetConnectivity,
  });

  @override
  Future<Either<Failure, List<Stories>>> loadStories() async {
    if (await baseCheckInternetConnectivity.isConnected()) {
      try {
        final stories = await baseRemoteHomeDatasource.loadStories();
        return Right(stories);
      } catch (e) {
        debugPrint(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      final stories = baseLocalHomeDatasource.loadStories();
      return Right(stories);
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> loadPosts() async {
    if (await baseCheckInternetConnectivity.isConnected()) {
      try {
        final posts = await baseRemoteHomeDatasource.loadPosts();
        return Right(posts);
      } catch (e) {
        debugPrint(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      final posts = baseLocalHomeDatasource.loadPosts();
      return Right(posts);
    }
  }
}
