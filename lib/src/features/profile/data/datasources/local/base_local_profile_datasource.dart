import '../../../domain/entities/profile.dart';

abstract class BaseLocalProfileDatasource {
  Profile getProfile(String uid);
}
