import 'package:flutter/material.dart';

class ChangePhoneNumberScreen extends StatelessWidget {
  const ChangePhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Change Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your new phone number', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
