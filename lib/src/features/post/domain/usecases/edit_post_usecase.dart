import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class EditPostUseCase extends BaseUseCase<bool, EditPostParams> {
  final BasePostRepo basePostRepo;

  EditPostUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, bool>> call(EditPostParams params) {
    return basePostRepo.editPost(params);
  }
}

class EditPostParams extends Equatable {
  final String? postText;
  final String postId;

  const EditPostParams({
    required this.postText,
    required this.postId,
  });

  @override
  List<Object?> get props => [postText, postId];
}
