import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/entities/post/post.dart';
import '../../../../core/error/failure.dart';

abstract class BaseSearchRepo {
  Future<Either<Failure, List<Post>>> loadSearchPosts();
  Future<Either<Failure, List<Person>>> search(String name);
}
