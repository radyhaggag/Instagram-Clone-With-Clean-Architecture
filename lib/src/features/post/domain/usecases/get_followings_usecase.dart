import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_post_repo.dart';

class GetFollowingsUseCase extends BaseUseCase<List<Person>, String> {
  final BasePostRepo basePostRepo;

  GetFollowingsUseCase(this.basePostRepo);

  @override
  Future<Either<Failure, List<Person>>> call(String params) {
    return basePostRepo.getFollowings(params);
  }
}
