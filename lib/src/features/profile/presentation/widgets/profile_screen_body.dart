import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../config/screens_args.dart';
import '../../../../core/domain/entities/person/person_info.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/circle_image_avatar.dart';
import '../../../../core/widgets/posts_grid_view_builder.dart';
import '../../domain/entities/profile.dart';
import '../screens/view_persons_screen.dart';
import 'profile_options.dart';
import 'profile_shimmer.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';

import '../../../../core/utils/app_size.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key, required this.personInfo});

  final PersonInfo personInfo;

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  Profile? profile;
  List<String> yourFollowingsUid = [];

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile(
          widget.personInfo.uid,
        ));
    context.read<ProfileBloc>().add(GetProfileFollowings(
          FirebaseAuth.instance.currentUser!.uid,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        return current is ProfileLoading || current is ProfileLoadingSuccess;
      },
      listener: (context, state) {
        if (state is ProfileLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ProfileLoadingSuccess) {
          profile = state.profile;
        }
        if (state is ProfileFollowingsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ProfileFollowersLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
        if (state is ProfileFollowingsLoadingSuccess) {
          yourFollowingsUid =
              state.followings.map((e) => e.personInfo.uid).toList();
        }
        if (state is ProfileUnFollowingSuccess) {
          yourFollowingsUid.removeWhere(
            (element) => element == widget.personInfo.uid,
          );
          profile = profile?.copyWith(
              person: profile?.person.copyWith(
            numOfFollowers: profile!.person.numOfFollowers - 1,
          ));
        }
        if (state is ProfileFollowingSuccess) {
          yourFollowingsUid.add(widget.personInfo.uid);
          profile = profile?.copyWith(
              person: profile?.person.copyWith(
            numOfFollowers: profile!.person.numOfFollowers + 1,
          ));
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const ProfileShimmer();
        } else if (profile != null) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(GetProfile(
                      profile!.person.personInfo.uid,
                    ));
                context.read<ProfileBloc>().add(GetProfileFollowings(
                      FirebaseAuth.instance.currentUser!.uid,
                    ));
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          CircleImageAvatar(
                            personInfo: profile!.person.personInfo,
                            radius: AppSize.s40,
                            enableNavigate: false,
                          ),
                          const SizedBox(height: AppSize.s5),
                          Text(
                            profile!.person.personInfo.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatsWidget(
                              label: AppStrings.posts,
                              number: profile!.person.numOfPosts,
                            ),
                            BlocBuilder<ProfileBloc, ProfileState>(
                              buildWhen: (previous, current) {
                                return current is ProfileUnFollowingSuccess ||
                                    current is ProfileFollowingSuccess;
                              },
                              builder: (context, state) {
                                return StatsWidget(
                                  label: AppStrings.followers,
                                  number: profile!.person.numOfFollowers,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.viewPersons,
                                      arguments: PersonsScreenArgs(
                                        uid: profile!.person.personInfo.uid,
                                        personsType: PersonsType.followers,
                                        title: AppStrings.followers,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            StatsWidget(
                              label: AppStrings.followings,
                              number: profile!.person.numOfFollowings,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  Routes.viewPersons,
                                  arguments: PersonsScreenArgs(
                                    uid: profile!.person.personInfo.uid,
                                    personsType: PersonsType.followings,
                                    title: AppStrings.followings,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  BioWidget(
                    bio: profile!.person.personInfo.bio,
                  ),
                  const SizedBox(height: AppSize.s10),
                  ProfileOptions(
                    person: profile!.person,
                    yourFollowings: yourFollowingsUid,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {},
                          shape: const Border(
                            bottom: BorderSide(width: AppSize.s1),
                          ),
                          child: const Icon(Icons.apps_outlined),
                        ),
                      ),
                      const Expanded(
                        child: MaterialButton(
                          onPressed: null,
                          child: Icon(Icons.lock),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s5),
                  profile!.posts.isNotEmpty
                      ? PostsGridViewBuilder(
                          posts: profile!.posts,
                          personInfo: profile!.person.personInfo,
                        )
                      : Center(
                          child: Image(
                            width: context.width / 2,
                            height: context.height / 2,
                            image: const AssetImage(AppImages.noPosts),
                          ),
                        ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
