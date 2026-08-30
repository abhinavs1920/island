import 'package:flutter/material.dart';

class ReportSubmittedScreen extends StatelessWidget {
  const ReportSubmittedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield, size: 80, color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text('Report Submitted', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('We will review your report shortly.', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
