import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class SendLikeUseCase extends BaseUseCase<Post, LikeParams> {
  final BasePostRepo basePostRepo;

  SendLikeUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Post>> call(LikeParams params) async {
    return await basePostRepo.sendLike(params);
  }
}

class LikeParams extends Equatable {
  final String postId;
  final String publisherUid;

  const LikeParams({required this.postId, required this.publisherUid});

  @override
  List<Object> get props => [postId, publisherUid];
}
