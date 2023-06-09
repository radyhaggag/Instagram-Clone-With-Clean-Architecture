import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../repositories/base_profile_repo.dart';

class UpdateProfileUseCase extends BaseUseCase<String, PersonInfo> {
  final BaseProfileRepo baseProfileRepo;

  UpdateProfileUseCase(this.baseProfileRepo);

  @override
  Future<Either<Failure, String>> call(PersonInfo params) async {
    return await baseProfileRepo.updateProfile(params);
  }
}

// class UpdateProfileParams extends Equatable {
//   final String name;
//   final String username;
//   final String gender;
//   final String imagePath;
//   final String email;
//   const UpdateProfileParams({
//     required this.name,
//     required this.username,
//     required this.gender,
//     required this.imagePath,
//     required this.email,
//   });

//   @override
//   List<Object> get props => [name, username, gender, imagePath, email];

//   UpdateProfileParams copyWith({
//     String? name,
//     String? username,
//     String? gender,
//     String? imagePath,
//     String? email,
//   }) {
//     return UpdateProfileParams(
//       name: name ?? this.name,
//       username: username ?? this.username,
//       gender: gender ?? this.gender,
//       imagePath: imagePath ?? this.imagePath,
//       email: email ?? this.email,
//     );
//   }
// }
