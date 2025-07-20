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
    const double explanatoryTextHeight = 40.0;

    // Define the text styles
    final TextStyle? defaultNoteStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(
          color:
              Theme.of(context).appBarTheme.foregroundColor?.withOpacity(0.8) ??
              (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black54),
        );
    final TextStyle? boldNoteStyle = defaultNoteStyle?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              )
            : null,
        title: Center(child: Text(title)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(explanatoryTextHeight),
          child: Container(
            // color: Colors.orange, // Optional: for debugging layout
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                // Default style for the entire TextSpan (optional if all children have styles)
                // style: defaultNoteStyle, // You can set it here or individually
                children: <TextSpan>[
                  TextSpan(text: 'Nota: ', style: boldNoteStyle),
                  TextSpan(
                    text:
                        'Añade a los participantes de una cuenta compartida y calcula la parte de cada uno de manera justa y precisa!',
                    style: defaultNoteStyle,
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
