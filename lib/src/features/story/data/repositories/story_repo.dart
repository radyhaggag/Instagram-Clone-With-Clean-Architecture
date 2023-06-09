import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/story/story.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../../domain/repositories/base_story_repo.dart';
import '../../domain/usecases/upload_story_usecase.dart';
import '../datasources/remote/base_remote_story_datasource.dart';

class StoryRepo implements BaseStoryRepo {
  final BaseRemoteStoryDatasource baseRemoteStoryDatasource;
  final BaseCheckInternetConnectivity connectivity;

  StoryRepo(
      {required this.baseRemoteStoryDatasource, required this.connectivity});

  @override
  Future<Either<Failure, bool>> uploadStory(StoryParams storyParams) async {
    if (await connectivity.isConnected()) {
      try {
        final result = await baseRemoteStoryDatasource.uploadStory(storyParams);
        return Right(result);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return const Left(Failure(ErrorMessages.networkConnectionFailed));
    }
  }

  @override
  Future<Either<Failure, bool>> viewStory(Story story) async {
    if (await connectivity.isConnected()) {
      try {
        final result = await baseRemoteStoryDatasource.viewStory(story);
        return Right(result);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return const Left(Failure(ErrorMessages.networkConnectionFailed));
    }
  }
}
