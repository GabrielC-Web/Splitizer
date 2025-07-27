import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/app_router.dart';
import 'core/state/riverpod.dart';
import 'core/theme/theme.dart';
import 'core/theme/util.dart';

void main() => runApp(ProviderScope(child: const SplitizerApp()));

class SplitizerApp extends ConsumerWidget {
  const SplitizerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      title: 'Splitizer',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ref.watch(riverpodThemeMode).themeMode == 'light'
          ? ThemeMode.light
          : ref.watch(riverpodThemeMode).themeMode == 'dark'
          ? ThemeMode.dark
          : brightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }
}
