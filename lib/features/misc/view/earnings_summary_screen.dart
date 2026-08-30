import 'package:flutter/material.dart';

class EarningsSummaryScreen extends StatelessWidget {
  const EarningsSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Summary')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text('Total Earnings', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('\$1,234.56', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Recent Trip'),
            subtitle: const Text('Today, 2:30 PM'),
            trailing: const Text('+\$12.50'),
            tileColor: theme.cardColor,
          ),
        ],
      ),
    );
  }
}
