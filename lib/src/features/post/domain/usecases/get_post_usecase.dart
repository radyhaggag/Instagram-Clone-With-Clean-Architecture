import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class GetPostUseCase extends BaseUseCase<Post, GetPostParams> {
  final BasePostRepo basePostRepo;

  GetPostUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Post>> call(GetPostParams params) {
    return basePostRepo.getPost(params);
  }
}

class GetPostParams extends Equatable {
  final String postId;
  final String publisherId;

  const GetPostParams({
    required this.postId,
    required this.publisherId,
  });

  @override
  List<Object> get props => [postId, publisherId];
}
