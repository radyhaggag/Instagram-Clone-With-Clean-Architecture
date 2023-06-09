import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/base_search_repo.dart';

class SearchUseCase extends BaseUseCase<List<Person>, String> {
  final BaseSearchRepo baseSearchRepo;

  SearchUseCase(this.baseSearchRepo);

  @override
  Future<Either<Failure, List<Person>>> call(String params) async {
    return await baseSearchRepo.search(params);
  }
}
