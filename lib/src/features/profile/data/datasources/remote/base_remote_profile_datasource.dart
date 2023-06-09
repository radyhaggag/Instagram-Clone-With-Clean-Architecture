import '../../../../../core/domain/entities/person/person_info.dart';
import '../../../../../core/models/person/person_model.dart';
import '../../../domain/entities/profile.dart';

abstract class BaseRemoteProfileDatasource {
  Future<Profile> getProfile(String uid);

  Future<List<PersonModel>> getFollowings(String uid);

  Future<List<PersonModel>> getFollowers(String uid);

  Future<String> follow(String personUid);

  Future<String> unFollow(String personUid);

  Future<String> updateProfile(PersonInfo params);
  Future<void> signOut();
}
