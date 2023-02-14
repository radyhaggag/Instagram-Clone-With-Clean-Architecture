import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/reel.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_reels_repo.dart';

class AddReelCommentUseCase extends BaseUseCase<Reel, ReelCommentParams> {
  final BaseReelsRepo baseReelsRepo;

  AddReelCommentUseCase(this.baseReelsRepo);

  @override
  Future<Either<Failure, Reel>> call(ReelCommentParams params) async {
    return await baseReelsRepo.addComment(params);
  }
}

class ReelCommentParams extends Equatable {
  final String reelId;
  final String publisherUid;
  final String commentText;
  final String commentDate;

  const ReelCommentParams({
    required this.reelId,
    required this.commentText,
    required this.commentDate,
    required this.publisherUid,
  });

  @override
  List<Object> get props => [
        reelId,
        commentText,
        commentDate,
        publisherUid,
      ];
}
