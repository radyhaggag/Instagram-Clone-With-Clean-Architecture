import '../../../../../core/utils/app_boxes.dart';
import 'base_local_profile_datasource.dart';
import '../../../domain/entities/profile.dart';

class LocalProfileDatasource implements BaseLocalProfileDatasource {
  @override
  Profile getProfile(String uid) {
    final profile = AppBoxes.profileBox.values.firstWhere(
      (e) => e.person.personInfo.uid == uid,
    );
    return profile;
  }
}
