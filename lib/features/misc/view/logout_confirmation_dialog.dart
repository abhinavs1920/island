import 'package:flutter/material.dart';

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
