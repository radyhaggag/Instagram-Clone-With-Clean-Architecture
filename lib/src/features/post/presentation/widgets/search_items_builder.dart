import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../bloc/post_bloc.dart';

class SearchItemsBuilder extends StatelessWidget {
  const SearchItemsBuilder({
    Key? key,
    required this.postBloc,
  }) : super(key: key);

  final PostBloc postBloc;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: postBloc.searchList.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: AppSize.s10);
      },
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            TagItem(
              imageUrl: postBloc.searchList[index].personInfo.imageUrl,
              name: postBloc.searchList[index].personInfo.name,
              onTap: () {
                postBloc.add(SelectTagsPeople(
                  postBloc.searchList[index],
                ));
              },
            ),
            if (postBloc.taggedPeople.contains(postBloc.searchList[index]))
              const Icon(
                Icons.check,
                color: AppColors.blue,
              ),
          ],
        );
      },
    );
  }
}

class TagItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final void Function()? onTap;
  const TagItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              width: AppSize.s50,
              height: AppSize.s50,
              imageUrl,
            ),
          ),
          const SizedBox(width: AppSize.s20),
          Text(name),
        ],
      ),
    );
  }
}
