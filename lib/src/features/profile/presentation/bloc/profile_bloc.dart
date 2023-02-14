import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/follow_profile_usecase.dart';
import '../../domain/usecases/get_profile_followers_usecase.dart';
import '../../domain/usecases/get_profile_followings_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

import '../../../../core/domain/entities/person/person_info.dart';
import '../../domain/usecases/un_follow_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final GetProfileFollowingsUseCase getProfileFollowingsUseCase;
  final GetProfileFollowersUseCase getProfileFollowersUseCase;
  final FollowProfileUseCase followProfileUseCase;
  final UnFollowProfileUseCase unFollowProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final SignOutUseCase signOutUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.getProfileFollowingsUseCase,
    required this.getProfileFollowersUseCase,
    required this.followProfileUseCase,
    required this.unFollowProfileUseCase,
    required this.updateProfileUseCase,
    required this.signOutUseCase,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfile) await _getProfile(event, emit);
      if (event is GetProfileFollowings) {
        await _getProfileFollowings(event, emit);
      }
      if (event is GetProfileFollowers) await _getProfileFollowers(event, emit);
      if (event is SearchAboutSomeone) await _searchAboutSomeOne(event, emit);
      if (event is FollowProfile) await _followProfile(event, emit);
      if (event is UnFollowProfile) await _unFollowProfile(event, emit);
      if (event is ChangeProfileImage) await _changeProfileImage(event, emit);
      if (event is UpdateProfile) await _updateProfile(event, emit);
      if (event is SignOut) await _signOut(event, emit);
    });
  }

  Future<void> _getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final res = await getProfileUseCase(event.uid);
    res.fold(
      (l) => emit(ProfileLoadingFailed(l.message)),
      (r) => emit(ProfileLoadingSuccess(r)),
    );
  }

  Future<void> _getProfileFollowings(
    GetProfileFollowings event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFollowingsLoading());
    final res = await getProfileFollowingsUseCase(event.uid);
    res.fold(
      (l) => emit(ProfileFollowingsLoadingFailed(l.message)),
      (r) => emit(ProfileFollowingsLoadingSuccess(r)),
    );
  }

  Future<void> _getProfileFollowers(
    GetProfileFollowers event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFollowersLoading());
    final res = await getProfileFollowersUseCase(event.uid);
    res.fold(
      (l) => emit(ProfileFollowersLoadingFailed(l.message)),
      (r) => emit(ProfileFollowersLoadingSuccess(r)),
    );
  }

  _searchAboutSomeOne(SearchAboutSomeone event, Emitter<ProfileState> emit) {
    List<Person> result = [];
    for (var person in event.persons) {
      final personName = person.personInfo.name.toLowerCase();

      if (personName.contains(event.name.toLowerCase())) {
        result.add(person);
      }
    }
    emit(SearchResultsLoaded(result));
  }

  Future<void> _followProfile(
    FollowProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileFollowing());
    final res = await followProfileUseCase(event.personUid);
    res.fold(
      (l) => emit(ProfileFollowingFailed(l.message)),
      (r) => emit(ProfileFollowingSuccess(r)),
    );
  }

  Future<void> _unFollowProfile(
    UnFollowProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUnFollowing());
    final res = await unFollowProfileUseCase(event.personUid);
    res.fold(
      (l) => emit(ProfileUnFollowingFailed(l.message)),
      (r) => emit(ProfileUnFollowingSuccess(r)),
    );
  }

  String? _imagePath;
  String? get imagePath => _imagePath;

  Future<void> _changeProfileImage(
    ChangeProfileImage event,
    Emitter<ProfileState> emit,
  ) async {
    final XFile? pickedFile;
    pickedFile = await ImagePicker().pickImage(
      imageQuality: 70,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _imagePath = pickedFile.path;
      emit(ProfileImageChangingSuccess(_imagePath!));
    } else {
      emit(ProfileImageNotChanged());
    }
  }

  Future<void> _updateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    final personInfo = event.personInfo.copyWith(localImagePath: _imagePath);
    final res = await updateProfileUseCase(personInfo);
    res.fold(
      (l) => emit(ProfileUpdatingFailed(l.message)),
      (r) => emit(ProfileUpdatingSuccess(r)),
    );
  }

  _signOut(SignOut event, Emitter<ProfileState> emit) async {
    emit(ProfileSigningOut());
    final res = await signOutUseCase(null);
    res.fold(
      (l) => emit(ProfileSignOutFailed(l.message)),
      (r) => emit(ProfileSignOutSuccess()),
    );
  }
}
