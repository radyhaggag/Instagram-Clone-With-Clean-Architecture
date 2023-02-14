part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadingSuccess extends ProfileState {
  final Profile profile;

  const ProfileLoadingSuccess(this.profile);
}

class ProfileLoadingFailed extends ProfileState {
  final String message;

  const ProfileLoadingFailed(this.message);
}

class ProfileFollowingsLoading extends ProfileState {}

class ProfileFollowingsLoadingSuccess extends ProfileState {
  final List<Person> followings;

  const ProfileFollowingsLoadingSuccess(this.followings);
}

class ProfileFollowingsLoadingFailed extends ProfileState {
  final String message;

  const ProfileFollowingsLoadingFailed(this.message);
}

class ProfileFollowersLoading extends ProfileState {}

class ProfileFollowersLoadingSuccess extends ProfileState {
  final List<Person> followers;

  const ProfileFollowersLoadingSuccess(this.followers);
}

class ProfileFollowersLoadingFailed extends ProfileState {
  final String message;

  const ProfileFollowersLoadingFailed(this.message);
}

class SearchResultsLoaded extends ProfileState {
  final List<Person> persons;

  const SearchResultsLoaded(this.persons);
  @override
  List<Object> get props => [persons];
}

class ProfileFollowing extends ProfileState {}

class ProfileFollowingSuccess extends ProfileState {
  final String uid;

  const ProfileFollowingSuccess(this.uid);
}

class ProfileFollowingFailed extends ProfileState {
  final String message;

  const ProfileFollowingFailed(this.message);
}

class ProfileUnFollowing extends ProfileState {}

class ProfileUnFollowingSuccess extends ProfileState {
  final String uid;

  const ProfileUnFollowingSuccess(this.uid);
}

class ProfileUnFollowingFailed extends ProfileState {
  final String message;

  const ProfileUnFollowingFailed(this.message);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdatingSuccess extends ProfileState {
  final String uid;

  const ProfileUpdatingSuccess(this.uid);
}

class ProfileUpdatingFailed extends ProfileState {
  final String message;

  const ProfileUpdatingFailed(this.message);
}

class ProfileImageChangingSuccess extends ProfileState {
  final String imagePath;

  const ProfileImageChangingSuccess(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ProfileImageNotChanged extends ProfileState {}

class ProfileSigningOut extends ProfileState {}

class ProfileSignOutSuccess extends ProfileState {}

class ProfileSignOutFailed extends ProfileState {
  final String message;

  const ProfileSignOutFailed(this.message);
}
