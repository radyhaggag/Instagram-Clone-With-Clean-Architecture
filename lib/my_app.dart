import 'package:flutter/material.dart';

import 'src/config/app_route.dart';
import 'src/config/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.getRoute,
      theme: getAppTheme(),
    );
  }
}
