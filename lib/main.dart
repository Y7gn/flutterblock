import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(SeriesApp(
    appRouter: AppRouter(),
  ));
}

class SeriesApp extends StatelessWidget {
  const SeriesApp({super.key, required this.appRouter});

  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
