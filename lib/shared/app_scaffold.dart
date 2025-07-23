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
        centerTitle: true,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              )
            : null,
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              ModalRoute.of(context)?.settings.name == 'bill'
                  ? context.go('/intro')
                  : context.go('/bill');
            },
            icon: ModalRoute.of(context)?.settings.name == 'bill'
                ? Icon(Icons.question_mark_rounded)
                : Icon(Icons.home_rounded),
          ),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}
