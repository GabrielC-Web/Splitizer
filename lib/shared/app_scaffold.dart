import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBack;

  const AppScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: showBack
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('Can pop: ${context.canPop()}');
            context.pop();
          },
        )
            : null,
        title: Center(child: Text(title)),
      ),
      body: child,
    );
  }
}
