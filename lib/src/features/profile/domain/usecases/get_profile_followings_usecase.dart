import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

import '../repositories/base_profile_repo.dart';

class GetProfileFollowingsUseCase extends BaseUseCase<List<Person>, String> {
  final BaseProfileRepo baseProfileRepo;

  GetProfileFollowingsUseCase(this.baseProfileRepo);

  @override
  Future<Either<Failure, List<Person>>> call(String params) async {
    return await baseProfileRepo.getFollowings(params);
  }
}
