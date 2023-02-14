import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/build_progress_dialog.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/post_bloc.dart';
import '../widgets/search_items_builder.dart';

class TagPeopleScreen extends StatefulWidget {
  const TagPeopleScreen({super.key});

  @override
  State<TagPeopleScreen> createState() => _TagPeopleScreenState();
}

class _TagPeopleScreenState extends State<TagPeopleScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    context
        .read<PostBloc>()
        .add(PostGetFollowings(uid: FirebaseAuth.instance.currentUser!.uid));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<PostBloc>();
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostFollowingsLoading) {
              showProgressDialog(context);
            }
            if (state is PostFollowingsLoadedSuccess) {
              Navigator.pop(context);
            }
            if (state is PostFollowingsLoadingFailed) {
              buildToast(toastType: ToastType.error, msg: state.message);
              Navigator.pop(context);
            }
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Column(
              children: [
                SearchWidget(
                  searchController: _searchController,
                  postBloc: postBloc,
                ),
                const SizedBox(height: AppSize.s20),
                if (postBloc.searchList.isNotEmpty)
                  SearchItemsBuilder(postBloc: postBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final PostBloc postBloc;

  const SearchWidget({
    Key? key,
    required this.searchController,
    required this.postBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchController,
            onChanged: (value) => postBloc.add(SearchAboutTagsPeople(value)),
            decoration: InputDecoration(
              hintText: AppStrings.searchAboutSomeone,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        TextButton(
          child: const Text(AppStrings.done),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
