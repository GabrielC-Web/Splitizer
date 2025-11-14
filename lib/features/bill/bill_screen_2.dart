import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../shared/app_scaffold.dart';

class BillScreen2 extends StatelessWidget {
  const BillScreen2({super.key});

  // Mock data — in a real app this would come from a provider or database
  final List<Map<String, dynamic>> mockSplits = const [
    // {
    //   'title': 'Cena con amigos',
    //   'total': 120.0,
    //   'people': 4,
    //   'date': '2025-11-08',
    // },
    // {
    //   'title': 'Almuerzo de trabajo',
    //   'total': 65.5,
    //   'people': 3,
    //   'date': '2025-10-31',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    final hasSplits = mockSplits.isNotEmpty;
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return AppScaffold(
      title: 'Splitizer',
      showBack: false,
      bottomButtonContent: const Text(
        'Dividir cuenta',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onButtonPressed: () {
        context.go('/form');
      },
      child: SafeArea(
        child: hasSplits
            ? ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockSplits.length,
                itemBuilder: (context, index) {
                  final split = mockSplits[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        split['title'],
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        '${split['people']} personas • ${dateFormat.format(DateTime.parse(split['date']))}',
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: Text(
                        '€${split['total'].toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      onTap: () {
                        // TODO: Navigate to split detail
                      },
                    ),
                  );
                },
              )
            : const _BillScreen2EmptyState(),
      ),
    );
  }
}

class _BillScreen2EmptyState extends StatelessWidget {
  const _BillScreen2EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_rounded,
              size: 96,
              color: theme.colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Aún no has dividido ninguna cuenta.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Toca “Dividir cuenta” para empezar tu primera división.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
