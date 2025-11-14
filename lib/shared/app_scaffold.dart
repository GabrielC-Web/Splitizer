import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitizer/core/state/riverpod.dart';

class AppScaffold extends ConsumerWidget {
  final String title;
  final Widget child;
  final Widget bottomButtonContent;
  final bool showBack;
  final VoidCallback? onButtonPressed;

  const AppScaffold({
    super.key,
    required this.title,
    required this.child,
    this.bottomButtonContent = const Text(
      'Dividir cuenta',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    this.showBack = true,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              )
            : null,
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(riverpodThemeMode).themeMode == 'light'
                  ? ref.read(riverpodThemeMode).setThemeMode('dark')
                  : ref.read(riverpodThemeMode).setThemeMode('light');
            },
            icon: ref.read(riverpodThemeMode).themeMode == 'light'
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).state.name == 'bill'
                  ? context.go('/intro')
                  : context.go('/bill');
            },
            icon: GoRouter.of(context).state.name == 'bill'
                ? Icon(Icons.question_mark_rounded)
                : Icon(Icons.home_rounded),
          ),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: child),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: bottomButtonContent,
        ),
      ),
    );
  }
}
