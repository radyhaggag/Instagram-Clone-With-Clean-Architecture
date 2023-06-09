import '../../../../../core/domain/entities/person/person.dart';
import '../../../../../core/utils/app_boxes.dart';
import 'base_local_splash_data_source.dart';

class LocalSplashDataSource implements BaseLocalSplashDataSource {
  @override
  Person? getCurrentUser() {
    final personBox = AppBoxes.personBox;
    final person = personBox.get(AppBoxesKeys.person);
    return person;
  }
}
