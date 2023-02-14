import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/entities/post/location_info.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class AddPostUseCase extends BaseUseCase<Post, PostParams> {
  final BasePostRepo basePostRepo;

  AddPostUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, Post>> call(PostParams params) {
    return basePostRepo.addPost(params);
  }
}

class PostParams extends Equatable {
  final List<String> imagesPaths;
  final List<String> videosPaths;
  final String? postText;
  final String postDate;
  final List<Person>? taggedPeople;
  final LocationInfo? locationInfo;

  const PostParams({
    required this.imagesPaths,
    required this.videosPaths,
    required this.postText,
    required this.postDate,
    required this.taggedPeople,
    required this.locationInfo,
  });

  @override
  List<Object?> get props => [
        imagesPaths,
        videosPaths,
        postText,
        postDate,
        taggedPeople,
      ];
}
