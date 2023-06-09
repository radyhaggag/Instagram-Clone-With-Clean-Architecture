import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reels_bloc.dart';
import '../widgets/reel_shimmer.dart';
import '../widgets/reel_view.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: BlocBuilder<ReelsBloc, ReelsState>(
        buildWhen: (previous, current) {
          return current is ReelsLoading || current is ReelsLoadingSuccess;
        },
        builder: (context, state) {
          if (state is ReelsLoadingSuccess) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => ReelView(
                reel: state.reels[index],
              ),
              itemCount: state.reels.length,
            );
          } else {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => const ReelShimmer(),
              itemCount: 10,
            );
          }
        },
      ),
    );
  }
}
