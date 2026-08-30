import 'package:flutter/material.dart';

class EarningsSummaryLoadingScreen extends StatelessWidget {
  const EarningsSummaryLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Summary')),
      body: Center(
        child: CircularProgressIndicator(color: theme.colorScheme.primary),
      ),
    );
  }
}
