import os

base_dir = "/home/abxh/island/lib/features/misc"
views_dir = os.path.join(base_dir, "view")
widgets_dir = os.path.join(base_dir, "widgets")

os.makedirs(views_dir, exist_ok=True)
os.makedirs(widgets_dir, exist_ok=True)

screens = {
    "earnings_empty_state_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "earnings_summary_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "earnings_summary_loading_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "earnings_error_state_screen.dart": """import 'package:flutter/material.dart';

class EarningsErrorStateScreen extends StatelessWidget {
  const EarningsErrorStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('Oops! Something went wrong.', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
""",
    "logout_confirmation_dialog.dart": """import 'package:flutter/material.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out of your account?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Cancel', style: TextStyle(color: theme.colorScheme.primary)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.error),
          child: Text('Log Out', style: TextStyle(color: theme.colorScheme.onError)),
        ),
      ],
    );
  }
}
""",
    "change_phone_number_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "rate_customer_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "rating_submitted_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "report_submitted_screen.dart": """import 'package:flutter/material.dart';

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
""",
    "splash_screen.dart": """import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_taxi, size: 100, color: theme.colorScheme.onPrimary),
            const SizedBox(height: 24),
            Text(
              'Flikk',
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
"""
}

for filename, content in screens.items():
    path = os.path.join(views_dir, filename)
    with open(path, "w") as f:
        f.write(content)
    print(f"Created {path}")

