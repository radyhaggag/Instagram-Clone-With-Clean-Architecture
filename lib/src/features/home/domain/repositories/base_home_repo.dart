import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/story/stories.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/models/post/post_model.dart';

abstract class BaseHomeRepo {
  Future<Either<Failure, List<Stories>>> loadStories();
  Future<Either<Failure, List<PostModel>>> loadPosts();
}
