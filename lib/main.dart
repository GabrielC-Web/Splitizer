import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';

void main() => runApp(const SplitizerApp());

class SplitizerApp extends StatelessWidget {
  const SplitizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Splitizer',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
    );
  }
}
