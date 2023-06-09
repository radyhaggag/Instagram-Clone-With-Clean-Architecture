import 'package:flutter/material.dart';
import '../../config/app_route.dart';
import '../domain/entities/person/person_info.dart';

import '../utils/app_fonts.dart';
import '../utils/app_size.dart';

class ViewPublisherNameWidget extends StatelessWidget {
  const ViewPublisherNameWidget({
    Key? key,
    required this.personInfo,
    required this.name,
    this.disableNavigate,
    this.textColor,
    this.addPadding,
  }) : super(key: key);
  final PersonInfo personInfo;
  final bool? disableNavigate;
  final String name;
  final Color? textColor;
  final bool? addPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: addPadding == null
          ? const EdgeInsets.symmetric(
              horizontal: AppSize.s10,
              vertical: AppSize.s5,
            )
          : EdgeInsets.zero,
      child: InkWell(
        onTap: disableNavigate != null
            ? null
            : () {
                Navigator.of(context).pushNamed(
                  Routes.profileScreen,
                  arguments: personInfo,
                );
              },
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontThickness.bold,
                color: textColor,
              ),
        ),
      ),
    );
  }
}
