import 'package:flutter/material.dart';

class EarningsEmptyStateScreen extends StatelessWidget {
  const EarningsEmptyStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 64, color: theme.disabledColor),
            const SizedBox(height: 16),
            Text('No Earnings Yet', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Complete tasks to start earning.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor)),
          ],
        ),
      ),
    );
  }
}
