import 'package:flutter/material.dart';

class RatingSubmittedScreen extends StatelessWidget {
  const RatingSubmittedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text('Rating Submitted!', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Thank you for your feedback.', style: theme.textTheme.bodyMedium),
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
