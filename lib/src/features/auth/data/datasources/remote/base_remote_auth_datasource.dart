import '../../../../../core/models/person/person_model.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';

abstract class BaseRemoteAuthDataSource {
  Future<PersonModel> login(LoginParams loginParams);
  Future<PersonModel> loginWithFacebook();
  Future<PersonModel> signUp(SignupParams signupParams);
  Future<bool> resetPassword(String email);
}
