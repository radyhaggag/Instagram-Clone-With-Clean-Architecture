import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../domain/entities/reel.dart';
import '../widgets/reel_view.dart';

class ViewReelScreen extends StatelessWidget {
  const ViewReelScreen({super.key, required this.reel});
  final Reel reel;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          ReelView(reel: reel),
          Padding(
            padding: const EdgeInsets.all(AppSize.s25),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.blackWith40Opacity,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: AppSize.s30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
