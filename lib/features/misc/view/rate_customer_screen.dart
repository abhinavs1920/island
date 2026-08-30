import 'package:flutter/material.dart';

class RateCustomerScreen extends StatelessWidget {
  const RateCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(size: 48, child: Icon(Icons.person, size: 32)),
            const SizedBox(height: 16),
            Text('How was your trip with John?', style: theme.textTheme.titleLarge),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => Icon(Icons.star_border, size: 40, color: theme.colorScheme.primary)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
