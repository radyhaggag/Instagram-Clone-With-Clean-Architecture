import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/profile_bloc.dart';

import '../../../../config/app_route.dart';
import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/widgets/view_publisher_name_widget.dart';
import '../screens/view_persons_screen.dart';
import '../widgets/follow_button.dart';

class PersonsBuilder extends StatefulWidget {
  const PersonsBuilder({
    super.key,
    required this.followings,
    required this.followers,
    required this.personsType,
  });

  final List<Person> followers;
  final List<Person> followings;
  final PersonsType personsType;

  @override
  State<PersonsBuilder> createState() => _PersonsBuilderState();
}

class _PersonsBuilderState extends State<PersonsBuilder> {
  late final TextEditingController controller;
  List<Person> persons = [];
  List<String> yourFollowingsUid = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _checkPersons();
    context.read<ProfileBloc>().add(GetProfileFollowings(
          FirebaseAuth.instance.currentUser!.uid,
        ));
  }

  void _checkPersons() {
    switch (widget.personsType) {
      case PersonsType.followings:
        persons = widget.followings;
        break;
      case PersonsType.followers:
        persons = widget.followers;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<ProfileBloc>().add(
                    SearchAboutSomeone(
                      name: value,
                      persons: widget.personsType == PersonsType.followers
                          ? widget.followers
                          : widget.followings,
                    ),
                  );
            },
            decoration: InputDecoration(
              hintText: AppStrings.searchAboutSomeone,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSize.s10),
          BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is SearchResultsLoaded) {
                persons = state.persons;
              }
              if (state is ProfileFollowingsLoadingSuccess) {
                yourFollowingsUid =
                    state.followings.map((e) => e.personInfo.uid).toList();
              }
              if (state is ProfileUnFollowingSuccess) {
                yourFollowingsUid.removeWhere(
                  (element) => element == state.uid,
                );
              }
              if (state is ProfileFollowingSuccess) {
                yourFollowingsUid.add(state.uid);
              }
            },
            builder: (context, state) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: AppSize.s30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        persons[index].personInfo.imageUrl,
                      ),
                    ),
                    title: ViewPublisherNameWidget(
                      personInfo: persons[index].personInfo,
                      disableNavigate: false,
                      name: persons[index].personInfo.name,
                    ),
                    trailing: persons[index].personInfo.uid !=
                            FirebaseAuth.instance.currentUser?.uid
                        ? FollowButton(
                            personUid: persons[index].personInfo.uid,
                            yourFollowings: yourFollowingsUid,
                          )
                        : null,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.profileScreen,
                        arguments: persons[index].personInfo,
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
