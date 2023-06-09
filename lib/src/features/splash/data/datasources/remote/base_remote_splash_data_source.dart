import '../../../../../core/models/person/person_model.dart';

abstract class BaseRemoteSplashDataSource {
  Future<PersonModel?> getCurrentUser();
}
