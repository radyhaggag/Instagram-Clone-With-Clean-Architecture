part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  final String uid;

  const GetProfile(this.uid);
}

class GetProfileFollowings extends ProfileEvent {
  final String uid;

  const GetProfileFollowings(this.uid);
}

class GetProfileFollowers extends ProfileEvent {
  final String uid;

  const GetProfileFollowers(this.uid);
}

class SearchAboutSomeone extends ProfileEvent {
  final String name;
  final List<Person> persons;

  const SearchAboutSomeone({
    required this.name,
    required this.persons,
  });
}

class FollowProfile extends ProfileEvent {
  final String personUid;

  const FollowProfile(this.personUid);
}

class UnFollowProfile extends ProfileEvent {
  final String personUid;

  const UnFollowProfile(this.personUid);
}

class ChangeProfileImage extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final PersonInfo personInfo;

  const UpdateProfile(this.personInfo);
}

class SignOut extends ProfileEvent {}
