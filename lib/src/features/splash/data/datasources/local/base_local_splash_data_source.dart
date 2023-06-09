import '../../../../../core/domain/entities/person/person.dart';

abstract class BaseLocalSplashDataSource {
  Person? getCurrentUser();
}
