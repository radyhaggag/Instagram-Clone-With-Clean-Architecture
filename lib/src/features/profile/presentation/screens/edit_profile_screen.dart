import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/center_progress_indicator.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../../../core/widgets/input_fields/name_field.dart';
import '../../../../core/widgets/input_fields/user_name_field.dart';

import '../bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final Person person;
  const EditProfileScreen({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController bioController;
  late final TextEditingController usernameController;
  late String gender;

  @override
  void initState() {
    super.initState();

    usernameController = TextEditingController(
      text: widget.person.personInfo.username,
    );
    nameController = TextEditingController(
      text: widget.person.personInfo.name,
    );
    bioController = TextEditingController(
      text: widget.person.personInfo.bio,
    );
    gender = widget.person.personInfo.gender;
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editProfile),
        leading: BackButton(onPressed: () {
          Navigator.of(context).pop('closed');
        }),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdatingSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.profileEditedSuccessMsg,
            );
          }
          if (state is ProfileUpdatingFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) {
                    return current is ProfileImageChangingSuccess;
                  },
                  builder: (context, state) {
                    if (state is ProfileImageChangingSuccess) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(AppSize.s80),
                              child: Image(
                                image: FileImage(File(state.imagePath)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const ChangeImageIcon(),
                        ],
                      );
                    } else {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(AppSize.s80),
                              child: ImageBuilder(
                                imageUrl: widget.person.personInfo.imageUrl,
                                imagePath:
                                    widget.person.personInfo.localImagePath,
                              ),
                            ),
                          ),
                          const ChangeImageIcon(),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: AppSize.s10),
                UsernameField(usernameController: usernameController),
                const SizedBox(height: AppSize.s10),
                NameField(nameController: nameController),
                const SizedBox(height: AppSize.s10),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: AppStrings.bio,
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      width: context.width,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: gender,
                        items: Gender.values
                            .map((e) => DropdownMenuItem<String>(
                                  value: e.getValue(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppSize.s10),
                                    child: Text(e.getValue()),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => gender = value ?? gender);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSize.s20),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: context.width,
                      height: AppSize.s50,
                      child: state is! ProfileUpdating
                          ? ElevatedButton(
                              onPressed: () {
                                final personInfo =
                                    widget.person.personInfo.copyWith(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  username: usernameController.text,
                                  gender: gender,
                                );
                                context
                                    .read<ProfileBloc>()
                                    .add(UpdateProfile(personInfo));
                              },
                              child: const Text(AppStrings.editProfile),
                            )
                          : const CenterProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeImageIcon extends StatelessWidget {
  const ChangeImageIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProfileBloc>().add(ChangeProfileImage());
      },
      child: Container(
        padding: const EdgeInsets.all(AppSize.s5),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(AppSize.s50),
        ),
        child: const Icon(
          Icons.photo_camera_outlined,
          color: AppColors.vividCerise,
          size: AppSize.s30,
        ),
      ),
    );
  }
}
